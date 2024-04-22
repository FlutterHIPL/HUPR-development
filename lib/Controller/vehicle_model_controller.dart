import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Model/VehicleModeAndMakeModel.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';

class VehicleModelController extends GetxController {
  var isLoading = false.obs;
  VehicleModeAndMakeModel? vehicleModel;
  // var vehicleID = 0;
  // var plantList = <Data>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchVehicleModelData();
  }

  fetchVehicleModelData() async {
    try {
      isLoading(true);
      print('Vehicle Model API Call');

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
      };

      print("**********");

      final res = await http.get(Uri.parse(AppConstants.vehicleModels),
          headers: requestHeaders);

      print(res);

      if (kDebugMode) {
        print('Vehicle Model API Call');

        print(AppConstants.vehicleModels);
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
            vehicleModel = VehicleModeAndMakeModel.fromJson(result);
          } else {
            showSnackBar("Error!!", data['message'], Colors.redAccent);
            return null;
          }
        } else {
          showSnackBar("Error!!", data['message'], Colors.redAccent);
          return null;
        }
      } else {
        showSnackBar("Error!!", data['message'], Colors.redAccent);
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
