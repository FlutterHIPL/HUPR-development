import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Screens/Driver_Details_Screens/document_screen.dart';
import 'package:hupr_texibooking/Screens/Home_Screens/home_screen.dart';
import 'package:hupr_texibooking/Screens/Otp_Screen/login_password_screen.dart';
import 'package:hupr_texibooking/Screens/Otp_Screen/otpScreen.dart';
import 'package:hupr_texibooking/Screens/Otp_Screen/otpScreen1.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/driwer_information.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Services/driver_auth_services.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverAuthController extends GetxController {
  TextEditingController driverMobileNumberController = TextEditingController();
  TextEditingController driverPasswordController = TextEditingController();
  TextEditingController driverFirstNameController = TextEditingController();
  TextEditingController driverLastNameController = TextEditingController();
  TextEditingController driverDLNumberController = TextEditingController();
  TextEditingController driverEmailController = TextEditingController();
  TextEditingController driverAddressController = TextEditingController();
  TextEditingController vehiclePlateNumberController = TextEditingController();
  TextEditingController vehicleProducationYearController =
      TextEditingController();
  TextEditingController pinController = TextEditingController();

  var box=GetStorage();
  var countryCode = "+31".obs;
  var driverGender = "".obs;
  var driverImage = "".obs;
  var driverID = "".obs;
  var driverDLImage = "".obs;
  var driverOwnershipIDImage = "".obs;
  var driverLanguageId = 1.obs;
  var vehicleColorID = 0.obs;
  var vehicleModelID = 0.obs;
  var driverTypeID = "".obs;
  var isLoading = false.obs;
  var isLoadingOTP = false.obs;
  var isVarifyContactNumberLoading = false.obs;
  var hasError = false.obs;

  var driverName = "";
  var driverPP = "";
  var mobileNumber = "";
  var emailID = "";
  var profilePic = "";
  var countryCodeValues = "";
  File? driverProfileImage,
      driverDrivingLicenceLImage,
      driverOwnershipIdImage,
      driverIDImage;

  @override
  void onInit() {
    super.onInit();
     FirebaseMessaging.instance.getToken().then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("fcm_token", value.toString());
      print('Firebase Token :- $value');
    });
  }





  varifyContactNumberCall() async {
   
    isVarifyContactNumberLoading(true);
    try {
    final body = {
        "mobile_number": driverMobileNumberController.text,
        "country_code": countryCode.value,
    
     };
     log("body :- $body ");
      var response=await ApiProvider().postRequest1(apiUrl: AppConstants.verifyMobileNumber,data: body);
    log("verifyMobileNumber :- $response ");
      if(response["status"]==true){
        if(response["data"]["status"]=="inactive"){
          isVarifyContactNumberLoading(false);
         showSnackBar(
              languages[choosenLanguage]['text_Error'], languages[choosenLanguage]['text_account_inactive'], Colors.redAccent);
        }else{
           isVarifyContactNumberLoading(false);
      
              Get.to(() => MyLoginPasswordPage(
                  countryCode: countryCode.value,
                  phoneNumber: driverMobileNumberController.text));
        }
      }else{

        if(response["message"]=="messages.mobile_not_exists"){
          isVarifyContactNumberLoading(false);
                Get.to(() => MyOtpPage(
                    otp: response["otp"],
                    countryCode: countryCode.value,
                    phoneNumber: driverMobileNumberController.text));

        }else{
          isVarifyContactNumberLoading(false);
          showSnackBar(languages[choosenLanguage]['text_Error'], response["message"], Colors.redAccent);
        }
          
}
    } catch (e) {
      isVarifyContactNumberLoading(false);
    }
  }

  driverLoginCall(var key) async {


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var fcmToken=prefs.getString("fcm_token");
    isLoading(true);


    try {
      await DriverAuthServices.driverLogin(
              driverMobileNumberController.text,
              driverPasswordController.text,
              key,
              pinController.text,
              countryCode.value,
              fcmToken)
          .then((value) {
        isLoading(false);
        if (value != null) {

          box.write("token", value["token"].toString());
          box.write("driver_id", value["data"]["id"].toString());
          box.write("countryCode", countryCode.value.toString());
           box.write("language_id", value["data"]["language_id"].toString());
          prefs.setString("token", value["token"].toString());
          prefs.setInt("id", value["data"]["id"]);
         // prefs.setInt("language_id", value["data"]["language_id"]);
           prefs.setString("country_code", value["data"]["country_code"].toString());
          prefs.setString("first_name", value["data"]["first_name"].toString());
          prefs.setString("last_name", value["data"]["last_name"].toString());
          prefs.setString("email", value["data"]["email"].toString());
          prefs.setString("mobile_number", value["data"]["mobile_number"].toString());
          // prefs.setString("address", value["data"]['profile']['address'].toString());
          if (value["data"]["uploads"].isNotEmpty) {
            prefs.setString(
                "Driver_Image", value["data"]["uploads"][0]["file_path"]);
          }
      
          prefs.setBool("status", value["status"]);
          prefs.setBool("success", value["success"]);
          showSnackBar(languages[choosenLanguage]['text_Success'], value["message"].toString(), Colors.greenAccent);
          if (value["status"]==true) {
           
            Get.offAll(() => MyHomePage());
               box.write("driver_id", value["data"]["id"].toString());
          } else {
             
          }
          driverMobileNumberController.clear();
          driverMobileNumberController.clear();
        } else {
          if (value == "error") {
            isLoading(false);
            showSnackBar(languages[choosenLanguage]['text_Error'], value, Colors.greenAccent);
          }
        }
      });
    } catch (e) {
      showSnackBar(
          languages[choosenLanguage]['text_Error'], e.toString(), Colors.greenAccent);
      isLoading(false);
    }
  }

  driverOTP() async {
    isLoadingOTP(true);
    try {
      await DriverAuthServices.driverOTP(
        driverMobileNumberController.text.trim(),
        countryCode.value,
      ).then((value) {
        log("driverOTP ${value}");
        if (value["status"] == true) {
          isLoadingOTP(false);
          
          showSnackBar(languages[choosenLanguage]['text_Success'], value["message"], Colors.greenAccent);
          Get.to(() => MyOtpPage1());
        } else {
          isLoadingOTP(false);
          showSnackBar(languages[choosenLanguage]['text_Error'], value["message"], Colors.redAccent);
        }
      });
    } catch (e) {
      isLoadingOTP(false);
      log("Send_OTP ${e.toString()}");
    }
  }

  

 
  Future registerDriver(Map<String, dynamic> fields, context) async {
    isLoading.value = true;
    update();

try{
    final header = {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
     'Accept-Language': languageSelectcode.toString(),
    };
    var request =
        new http.MultipartRequest("POST", Uri.parse(AppConstants.register));
    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

  
  if(driverTypeID.value=="owner"){

    request.files
        .add(await http.MultipartFile.fromPath('id_card', driverIDImage!.path));
    request.files.add(await http.MultipartFile.fromPath(
        'ownership_id', driverOwnershipIdImage!.path));
    request.files.add(await http.MultipartFile.fromPath(
        'dl_licence', driverDrivingLicenceLImage!.path));
    request.files.add(await http.MultipartFile.fromPath(
        'driver_image', driverProfileImage!.path));
  }else{
    request.files.add(
            await http.MultipartFile.fromPath('id_card', driverIDImage!.path));
        request.files.add(await http.MultipartFile.fromPath(
            'dl_licence', driverDrivingLicenceLImage!.path));
        request.files.add(await http.MultipartFile.fromPath(
            'driver_image', driverProfileImage!.path));
  }

    // }
    request.headers.addAll(header);
    print(request.headers);
    print(request.files);
    print(request.fields);
    print(request.fields);

    await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      var data = jsonDecode(alldata);
      print(request.fields);
      print(value.statusCode);
      print(data);
      if (value.statusCode == 200) {
        print(data);
        if(driverTypeID.value == "owner")
        {
            Get.offAll(() => MySignUpPage());
        }else{
          showDialog(
            context: context,
            builder: (context) => InformationWidget(),
          );
        }
        showSnackBar(languages[choosenLanguage]['text_Congratulations'],
              languages[choosenLanguage]['text_You_Are_Successfully_Registered'],
            Colors.greenAccent);
        isLoading.value = false;
        update();
      } else if (value.statusCode == 401) {
         isLoading.value = false;
          showSnackBar(
            languages[choosenLanguage]['text_Error'],
            data['error'],
            Colors.redAccent,
          );
            update();
      }
      
      else {
        isLoading.value = false;
        showSnackBar(
          languages[choosenLanguage]['text_Error'],data['message'], Colors.redAccent,
        );

        update();
      }
    });
    isLoading.value = false;
    update();
}catch(e){
    isLoading.value = false;
     print(e.toString());
    update();
}
  }

  logoutCall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading(true);
    try {
      await DriverAuthServices.logout().then((value) {
        isLoading(false);
        log("logout $value");
        if (value != null) {
          prefs.clear();
          box.erase();
            update();
          Get.offAll(() => MySignUpPage());
        }
      });
    } catch (e) {
      isLoading(false);
    }
  }
  var isLoadingApi = false.obs;
  TaxiNumberCheckApi() async {
    isLoadingApi(true);
    try {
      var response = await ApiProvider().getRequest2(
          apiUrl:
              "https://opendata.rdw.nl/resource/m9d7-ebf2.json?kenteken=${vehiclePlateNumberController.text}");
      log('TaxiNumberCheckApi:- $response');
      if (response != null && response.length!=0) {
        log('TaxiNumberCheckApi 4:- $response');
        if(response[0]["wam_verzekerd"]=="Ja")
        {
          isLoadingApi(false);
         Get.to(() => MyDocumentPage());
        }else{
          showSnackBar(languages[choosenLanguage]['text_Error'], languages[choosenLanguage]['text_Vehicle_plate_number_incorrect'], Colors.redAccent);
              isLoadingApi(false);
        }
       
      } else {
        log('TaxiNumberCheckApi 1:- $response');
        isLoadingApi(false);
        showSnackBar(
            languages[choosenLanguage]['text_Error'], languages[choosenLanguage]['text_Vehicle_plate_number_incorrect'], Colors.redAccent);
      }
    } catch (e) {
      log('TaxiNumberCheckApicatch:- ${e.toString()}');
      isLoadingApi(false);
    }
  }




  @override
  void dispose() {
    driverPasswordController.dispose();
    driverMobileNumberController.dispose();
    // pinController.dispose();
    
    driverFirstNameController.dispose();
    driverLastNameController.dispose();
    driverDLNumberController.dispose();
    driverEmailController.dispose();
    driverAddressController.dispose();
    vehiclePlateNumberController.dispose();
    vehicleProducationYearController.dispose();

    super.dispose();
  }
}
