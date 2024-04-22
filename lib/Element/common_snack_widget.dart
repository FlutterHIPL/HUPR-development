import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(textMessage, String messgae, MaterialAccentColor bgColor) {
  Get.showSnackbar(
    GetSnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
      borderRadius: 10,
      title: textMessage,
      message: messgae,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      snackStyle: SnackStyle.FLOATING,
    ),
  );
}

void showSnackBar1( String messgae, MaterialAccentColor bgColor) {
  Get.showSnackbar(
    GetSnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
      borderRadius: 10,
      message: messgae,
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      backgroundColor: bgColor,
      snackStyle: SnackStyle.FLOATING,
    ),
  );
}