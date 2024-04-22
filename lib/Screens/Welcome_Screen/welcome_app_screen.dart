import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_indecator_widget.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Screens/Welcome_Screen/welcome_reward_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyWelcomeAppPage extends StatefulWidget {
  const MyWelcomeAppPage({super.key});

  @override
  State<MyWelcomeAppPage> createState() => _MyWelcomeAppPageState();
}

class _MyWelcomeAppPageState extends State<MyWelcomeAppPage> {
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
                  Images.welcomeAppImg,
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
              languages[choosenLanguage]['text_Welcome_App'],
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
              languages[choosenLanguage]['text_Taxi_service_designed'],
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
                  CommonRunningCarIndicatorWidget(),
                  const SizedBox(
                    width: 5,
                  ),
                  CommonIndicatorWidget(),
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
                  Get.to(()=>MyWelcomeRewardPage());
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
