import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Screens/Settings_Screens/change_pass_otp_screen.dart';
import 'package:hupr_texibooking/Screens/Settings_Screens/language_setting_screen.dart';
import 'package:hupr_texibooking/Screens/Settings_Screens/map_setting_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(Images.backIcon)),
            heightSpace20,
            Row(
              children: [
                Text(
                  languages[choosenLanguage]['text_Settings'],
                  style: TextStyle(
                      color: blackTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            heightSpace20,
            GestureDetector(
              onTap: () {
                Get.to(()=>MyMapSettingPage());
              },
              child: Row(
                children: [
                  SvgPicture.asset(Images.mapSettingsIcon),
                  widthSpace10,
                  Text(
                     languages[choosenLanguage]['text_Map_Settings'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  SvgPicture.asset(Images.arrowRightIcon),
                ],
              ),
            ),
            heightSpace20,
            GestureDetector(
              onTap: () async {
               await  Get.to(()=>MyLanguageSettingPage());
                setState(() {});
              },
              child: Row(
                children: [
                  SvgPicture.asset(Images.mapLanguageIcon),
                  widthSpace10,
                  Text(
                          languages[choosenLanguage]['text_Language_Settings'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  SvgPicture.asset(Images.arrowRightIcon),
                ],
              ),
            ),
            heightSpace20,
            GestureDetector(
              onTap: () {
                Get.to(()=>MyChangePassOtpPage());
              },
              child: Row(
                children: [
                  SvgPicture.asset(Images.mapChangePassIcon),
                  widthSpace10,
                  Text(
                     languages[choosenLanguage]['text_Change_Password'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  SvgPicture.asset(Images.arrowRightIcon),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

