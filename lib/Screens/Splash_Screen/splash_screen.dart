import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Screens/Announcements/announcement.dart';
import 'package:hupr_texibooking/Screens/Home_Screens/home_screen.dart';
import 'package:hupr_texibooking/Screens/Welcome_Screen/welcome_app_screen.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    super.initState();


    Timer(
      const Duration(seconds: 3),
      () async {
       
        SharedPreferences preferences = await SharedPreferences.getInstance();
        var isLoginKey = preferences.getBool("status") ?? false;

        if (isLoginKey == false) {
          Get.offAll(()=>MyWelcomeAppPage());
        } else {

         Get.offAll(() => MyHomePage());
 
        }

         print("SystemChannels  ${language()}");
        choosenLanguage =
            language().toString() == "" ? "en" : language().toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(child: Center(child: SvgPicture.asset(Images.appLogo))),
    );
  }
}
