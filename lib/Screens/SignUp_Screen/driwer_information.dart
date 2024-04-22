import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      body: Container(
        alignment: Alignment.center,
             padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
         Text(
          languages[choosenLanguage]['text_inactive_account_line'],
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        heightSpace40,
        ElevatedButton(
            onPressed: () {
              // AppNavigator.gotoLanding(context);
             Navigator.pop(context);
              Get.offAll(() => MySignUpPage());
            },
            child:  Text(
                languages[choosenLanguage]['text_Okay']))
      ],
              ),
            ),
    );
  }
}
