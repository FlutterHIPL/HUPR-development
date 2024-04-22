import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_indecator_widget.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Screens/Welcome_Screen/language_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyWelcomeRewardPage extends StatefulWidget {
  const MyWelcomeRewardPage({super.key});

  @override
  State<MyWelcomeRewardPage> createState() => _MyWelcomeRewardPageState();
}

class _MyWelcomeRewardPageState extends State<MyWelcomeRewardPage> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                color: fillColor,
                image: DecorationImage(
                    image: AssetImage(
                  Images.getRewardImage,
                ))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Get.to(()=>MySignUpPage());
                },
                child: Text(
                  languages[choosenLanguage]['text_Skip'],
                  style: TextStyle(
                      color: appBackgroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              languages[choosenLanguage]['text_Get_Rewarded'],
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
            child: Text(
              languages[choosenLanguage]['text_Get_extra_bonuses'],
              style: TextStyle(
                  color: greyTextColor,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  CommonIndicatorWidget(),
                  const SizedBox(
                    width: 5,
                  ),
                  CommonRunningCarIndicatorWidget(),
                  const SizedBox(
                    width: 5,
                  ),
                  CommonIndicatorWidget(),
                  const SizedBox(
                    width: 5,
                  ),
                  CommonIndicatorWidget()
                ],
              ),
              CustomButton(
                isVisible: false,
                btnName: languages[choosenLanguage]['text_Next'],
                onPressed: () {
                  Get.to(()=>MyLanguagePage());
                },
              )
            ],
          ),
         heightSpace20,
         
        ],
      )),
    );
  }
}
