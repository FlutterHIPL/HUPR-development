import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Screens/Settings_Screens/new_pass_screen.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OTPVerifyPassword extends StatefulWidget {
  var mobile,country;
   OTPVerifyPassword({super.key,required this.mobile,required this.country});

  @override
  State<OTPVerifyPassword> createState() => _OTPVerifyPasswordState();
}

class _OTPVerifyPasswordState extends State<OTPVerifyPassword> {
  var isLoading = false;
  var isButtonLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController pinController = TextEditingController();
  bool countDown = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: fillColor),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(Images.backIcon))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2 * 0.5,
                    decoration: BoxDecoration(color: fillColor),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset(Images.otpImage),
                    ),
                  ),
                 heightSpace20,
                  Text(
                    "Enter OTP",
                    style: TextStyle(
                        color: blackTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                  heightSpace10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "A verification code has been sent to your phone number",
                      style: TextStyle(
                          color: greyTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  heightSpace20,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 50),
                    child: PinCodeTextField(
                      animationType: AnimationType.none,
                      appContext: context,
                      controller: pinController,
                      length: 6,
                      obscureText: false,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.number,
                      autoDismissKeyboard: true,
                      cursorColor: blackTextColor,
                      enableActiveFill: true,
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return languages[choosenLanguage]
                              ['text_The_Pin_is_required'];
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        setState(() {
                          
                        });
                      },
                      pinTheme: PinTheme(
                        fieldHeight: 55,
                        fieldWidth: 38,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        selectedFillColor: fillColor,
                        activeFillColor: fillColor,
                        inactiveFillColor: fillColor,
                        inactiveColor: outlineColor,
                        selectedColor: outlineColor,
                        activeColor: outlineColor,
                      ),
                    ),
                  ),
                  heightSpace20,
                  isLoading == false
                      ? GestureDetector(
                              onTap: () {
                                setState(() {
                                 verifyMobileApi();
                                  pinController.clear();
                                });
                              },
                              child: Text(
                                languages[choosenLanguage]
                              ['text_Resend_code'],
                                style: TextStyle(
                                    color: appBackgroundColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0),
                              ),
                            )
                          
                      : Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                                strokeWidth: 3, color: appBackgroundColor),
                          ),
                        ),
                  Spacer(),
                  isButtonLoading == false
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomButton(
                            isVisible: true,
                            btnName:  languages[choosenLanguage]
                                ['text_Confirm'],
                            onPressed: () async {
                          if (_formKey.currentState!.validate()) {  
                                if (pinController.text.length == 6) {
                                  
                               verifyOTPApi();
                                
                          
                                  
                                  } 
                                  else{
                                    showSnackBar(
                                      languages[choosenLanguage]['text_Error'],languages[choosenLanguage]['text_Please_Enter_6_digit_otp']
                                      ,
                                      Colors.redAccent);
                                  }
                                } 
                              
                            },
                          ),
                        )
                      : Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: appBackgroundColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 12.0),
                            child: Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                    strokeWidth: 3, color: whiteColor),
                              ),
                            ),
                          )),
                  heightSpace20,
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }













   verifyOTPApi() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");

    setState(() {
      isButtonLoading = true;
    });



    Map<String, String> requestHeaders = {
     'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
       'Accept-Language': languageSelectcode.toString(),
    };
        final body = {
      "mobile_number": widget.mobile.toString(),
      "country_code": widget.country.toString(),
      "otp": pinController.text.trim()
    };

    log("rideHistoryApi ${body}");

    final res = await http.post(Uri.parse(AppConstants.verifyotp),
        body: body, headers: requestHeaders);


    if (kDebugMode) {
      print(res.statusCode);
      print(requestHeaders);
      print(res.body);
    }

    var data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      if (data["status"] == true) {
        setState(() {
          isButtonLoading = false;
          Get.to(()=>NewPassword(mobile:widget.mobile.toString(),country:widget.country.toString()));
          showSnackBar(
              languages[choosenLanguage]['text_Success'], data["message"].toString(), Colors.greenAccent);
        });
      }
    } else if (res.statusCode == 500) {
      setState(() {
        isButtonLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], data["error"].toString(), Colors.redAccent);
      });
    } else if (res.statusCode == 401) {
      setState(() {
        isButtonLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], data["message"].toString(), Colors.redAccent);
      });
    } else if (res.statusCode == 404) {
      setState(() {
        isButtonLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], data["message"].toString(), Colors.redAccent);
      });
    } else {
      setState(() {
          isButtonLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], res.statusCode.toString(), Colors.redAccent);
      });
    
    }
  }


  verifyMobileApi() async {
    setState(() {
      isLoading = true;
    });

    final body = {
      "mobile_number": widget.mobile.toString(),
      "country_code": widget.country.toString()
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept-Language': languageSelectcode.toString(),
    };

    final res = await http.post(Uri.parse(AppConstants.driverSendOTP),
        body: jsonEncode(body), headers: requestHeaders);

    // log("rideHistoryApi ${res.body}");
    if (kDebugMode) {
      print(res.statusCode);
      print(requestHeaders);
      print(res.body);
    }

    var data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      if (data["status"] == true) {
        setState(() {
          isLoading = false;
         
          showSnackBar(
             languages[choosenLanguage]['text_Success'], data["message"].toString(), Colors.greenAccent);
        });
      }
    } else if (res.statusCode == 500) {
      setState(() {
        isLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], data["error"].toString(), Colors.redAccent);
      });
    } else if (res.statusCode == 401) {
      setState(() {
        isLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], data["message"].toString(), Colors.redAccent);
      });
    } else {
      setState(() {
         isLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], res.statusCode.toString(), Colors.redAccent);
      });
     
    }
  }
}
