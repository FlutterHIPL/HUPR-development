import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Model/DriverProfileNewModel.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Services/driver_profile_services.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DriverProfileController extends GetxController {
  TextEditingController driverFirstNameController = TextEditingController();
  TextEditingController driverLastNameController = TextEditingController();
  TextEditingController driverAddressController = TextEditingController();

  int? selectedOption;
  var stripeStatus = "false".obs;
  final isLoading = false.obs;

  DriverProfileNewModel? driverProfileModel;
  final file_path = "".obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    getDriverProfileCall();
  }

  getDriverProfileCall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      await DriverProfileServices.getDriverProfile().then((value) {
        isLoading.value = false;
        if (value != null) {


          driverProfileModel = DriverProfileNewModel.fromJson(value);

           log("Profile ${value["profileData"]["starRating"]}");
           box.write("starRating", value["profileData"]["starRating"].toString());
            box.write(
              "totalBookings", value["profileData"]["totalBookings"].toString());
               box.write("totalDistance",
              value["profileData"]["totalDistance"].toString());
              
          stripeStatus.value=value["profileData"]["onboarding_status"].toString();
          update();

          for (int i = 0; i < driverProfileModel!.data!.uploads!.length; i++) {
            if (driverProfileModel!.data!.uploads![i].type == "Driver-Image") {
              file_path.value =
                  driverProfileModel!.data!.uploads![i].filePath.toString();
              prefs.setString("Driver_Image",
                  driverProfileModel!.data!.uploads![i].filePath.toString());
              log("Driver_Image ${driverProfileModel!.data!.uploads![i].filePath.toString()}");
              getLoginData();
            }
          }

          update();
          log("driverProfileModel ${driverProfileModel!.data!.lastName.toString()}");
          driverFirstNameController.text =
              driverProfileModel!.data!.firstName.toString();
          driverLastNameController.text =
              driverProfileModel!.data!.lastName.toString();
          driverAddressController.text =
              driverProfileModel!.data!.profile!.address.toString();

          update();
          //  Get.to(MyProfileInfoPage());
        }
      });
    } catch (e) {
      isLoading.value = false;
    }
  }

  DriverAuthController driverAuthController = Get.put(DriverAuthController());
  // String firstName = "", lastName = "", mobile_number = "", profileImage = "";
  // int language_id = 0;

  void getLoginData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    driverAuthController.countryCodeValues =
        preferences.getString("country_code") != null
            ? preferences.getString("country_code")!
            : "+31";
    driverAuthController.driverName = preferences.getString("first_name")! +
        " " +
        preferences.getString("last_name")!;
    driverAuthController.mobileNumber =
        preferences.getString("mobile_number") != null
            ? preferences.getString("mobile_number")!
            : "";

    driverAuthController.driverPP =
        preferences.getString("Driver_Image") != null
            ? preferences.getString("Driver_Image")!
            : "";
    driverAuthController.update();
  }

  DeleteAccountApi() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids = pref.getInt("id");

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    };

    if (kDebugMode) {
      print("**********");
    }
    try {
      final res = await http.delete(
          Uri.parse("${AppConstants.deleteAccount}$ids"),
          headers: requestHeaders);

      if (kDebugMode) {
        print(AppConstants.deleteAccount);
        print(ids);
        print(res.statusCode);
        print(requestHeaders);
        print(res.body);
      }

      var data = jsonDecode(res.body);

      if (kDebugMode) {
        print(data);
      }

      if (res.statusCode == 200) {
        if (data["status"] == true) {
          pref.clear();
          Get.offAll(() => MySignUpPage());
          showSnackBar("Success", data["message"], Colors.greenAccent);
        } else {
          showSnackBar("Error", "", Colors.redAccent);
        }
      } else if (res.statusCode == 500) {
        showSnackBar("Error", "500 Internal Server error", Colors.redAccent);
      } else {
        showSnackBar("Error", res.statusCode.toString(), Colors.redAccent);
      }
    } catch (e) {
      showSnackBar("Error", e.toString(), Colors.redAccent);
    }
  }
}
