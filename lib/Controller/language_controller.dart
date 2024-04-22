import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Model/LanguageModel.dart';
import 'package:hupr_texibooking/Services/language_services.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/language/language_option.dart';


class LanguageController extends GetxController {
   TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  LanguageModel? languageModel;
  var selectedValue = 0;
    var value2 = "".obs;

  @override
  Future<void> onInit() async {

    super.onInit();

    if (language() != '') {
      log('App+A ${language()}');
      selectedValue= languageCode()==""?0:languageCode();
      choosenLanguage = language().toString();
      update();
      value2.value = language().toString();
      update();
    } else {
      log('App+B ${language()}');
        box.write('language', "en");
      choosenLanguage = 'en';
      update();
      value2.value = 'en';
      update();
    }


    getDriverProfileCall();
  }


void changeLanguage(value) {
    value2.value = value;
    update();
    box.write('language', value);
    update();
    log(value2.value);
    log('App Language ${language()}');
    choosenLanguage = value2.value;
    update();
  }

  getDriverProfileCall() async {
    isLoading(true);
    try {
      await LanguageServices.getLanguage().then((value) {
        isLoading(false);
        if (value != null) {
          languageModel = LanguageModel.fromJson(value);
        }
      });
    } catch (e) {
      isLoading(false);
    }
  }
}
