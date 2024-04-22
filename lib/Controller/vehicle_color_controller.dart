import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Model/VehicleColorModel.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class VehicleColorController extends GetxController {
  var isLoading = false.obs;

  VehicleColorModel? vehicleColorModel;
 var vehicleItem=[
  {
    'id':"owner",
    'name':"${languages[choosenLanguage]['text_I_Am_Owner']}"
  },
  {'id': "driver", 'name': "${languages[choosenLanguage]['text_I_Am_Not_Owner']}"}

 ];

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchVehicleColor();
  }

  fetchVehicleColor() async {
    try {
      isLoading(true);

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      print("**********");

      final res = await http.get(Uri.parse(AppConstants.vehicleColors),
          headers: requestHeaders);

      print(res);

      if (kDebugMode) {
        print('Vehicle Colors API Call');

        print(AppConstants.vehicleColors);
        print(requestHeaders);
        print(res.statusCode);
      }

      var data = json.decode(res.body);

      if (kDebugMode) {
        print(data);
      }

      if (res.statusCode == 200) {
        if (data != null) {
          if (data['data'] != null) {
            var result = jsonDecode(res.body);
            vehicleColorModel = VehicleColorModel.fromJson(result);
          } else {
            showSnackBar(languages[choosenLanguage]['text_Error'], data['message'], Colors.redAccent);
            return null;
          }
        } else {
          showSnackBar(languages[choosenLanguage]['text_Error'], data['message'], Colors.redAccent);
          return null;
        }
      } else {
        showSnackBar(languages[choosenLanguage]['text_Error'], data['message'], Colors.redAccent);
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while getting data is $e');
      }
    } finally {
      isLoading(false);
    }
  }



 




}
