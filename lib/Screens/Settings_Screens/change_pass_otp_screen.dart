import 'dart:convert';
import 'dart:developer';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Screens/Settings_Screens/otp_verify_password.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyChangePassOtpPage extends StatefulWidget {
  const MyChangePassOtpPage({super.key});

  @override
  State<MyChangePassOtpPage> createState() => _MyChangePassOtpPageState();
}

class _MyChangePassOtpPageState extends State<MyChangePassOtpPage> {
  final _formKey = GlobalKey<FormState>();
  final countryPicker =  FlCountryCodePicker(
     title: Padding(
       padding: EdgeInsets.all(8.0),
       child: Text(
        "  ${languages[choosenLanguage]['text_Select_Country']}",
        style: TextStyle(fontSize: 24),
           ),
     ),
    searchBarDecoration: InputDecoration(
      suffixIcon: Icon(Icons.search),
      hintText: '${languages[choosenLanguage]['text_Country_Code_or_Dial_Code']}',
      contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
      filteredCountries: ['+91', 'IN', '+31', 'NL'],
    favorites: ['+91', 'IN', '+31', 'NL'],
  );
   TextEditingController driverMobileNumberController = TextEditingController();

 var countryCode = "+31";
  var flagImage = "", countryCodePackageName = "";
  bool isLoading=false;

  bool isError = false, isLengthError = false;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 270,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(color: fillColor),
                        child: Image.asset(Images.signInImage),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(Images.backIcon)),
                      ),
                    ],
                  ),
                 heightSpace20,
                  Text(
                    languages[choosenLanguage]['text_Enter_Mobile_Number'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                  heightSpace10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      languages[choosenLanguage]['text_Moments_away_from_registering_your_account_and_enjoying_comfortable_rides'],
                      style: TextStyle(
                          color: greyTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  heightSpace20,
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: () async {
                             final picked = await countryPicker.showPicker(
                                  context: context);
                              if (picked != null) {
                                print(picked);
                                setState(() {
                                  countryCode =
                                      picked.dialCode;
                                  flagImage = picked.flagUri;
                                  countryCodePackageName =
                                      picked.flagImagePackage;
                                });
                              }
                            },
                            child:
                                 Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffF5F5FF),
                                  border: Border.all(color: outlineColor),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    flagImage == ""
                                        ? SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: ClipOval(
                                              clipper: MyOvalClipper(),
                                              child: Image.asset(
                                                Images.engFlagIcon,
                                                width: 25,
                                                height: 25,
                                                fit: BoxFit.fill,
                                              ),
                                            ))
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                              fit: BoxFit.fill,
                                              width: 25,
                                              height: 25,
                                              flagImage,
                                              package: countryCodePackageName,
                                            ),
                                          ),
                                    Text(
                                      countryCode,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: "Poppins",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SvgPicture.asset(Images.dropDownRightIcon),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            child: CustomTextField(
                              inputFormat: [
                                LengthLimitingTextInputFormatter(15),
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              AutovalidateModes:
                                  AutovalidateMode.onUserInteraction,
                              controller: driverMobileNumberController,
                              maxLength: 15,
                              inputAction: TextInputAction.done,
                              inputType: TextInputType.number,
                              isTrue: true,
                              hintText:  languages[choosenLanguage]['text_Enter_phone_number'],
                              // hintText: "",
                              obscureText: false,
                              onIconTap: () {},
                              onChanged: (value) {
                            
                                setState(() {
                                  if (value != null || value!.isNotEmpty) {
                                    isError = false;
                                  }
      
                                  if (value.length < 7) {
                                    isLengthError = true;
                                  } else {
                                    isLengthError = false;
                                  }
                                  if (value.isEmpty) {
                                    isLengthError = false;
                                    isError = true;
                                  }
                                });
                              },
                            
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: isError,
                          child: Text(
                            languages[choosenLanguage]['text_Phone_number_required'],
                            style: TextStyle(
                                color: redColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          visible: isLengthError,
                          child: Text(
                            languages[choosenLanguage]['text_phone_number_7_digits'],
                            style: TextStyle(
                                color: redColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:
                        isLoading
                              ? Container(
                                  height: 50,
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
                                  ))
                              :
                        CustomButton(
                      isVisible: true,
                      btnName: languages[choosenLanguage]['text_Confirm'],
                      onPressed: () {
                       
                        setState(() {
                          if (driverMobileNumberController.text.isEmpty) {
                            log("Pawan ${driverMobileNumberController.text.isEmpty}");
                            isError = true;
                          } else if (driverMobileNumberController.text.length <7) {
                             log("Pawan1 ${driverMobileNumberController.text}");
                            // isError = true;
                            isLengthError = true;
                          } else {
                            isError = true;
                            isLengthError = true;
                             log("Pawan2 ${driverMobileNumberController.text}");
                          }

                          if (isError && isLengthError) {
                            isError = false;
                            isLengthError = false;
                            verifyMobileApi();
                          //  controller.varifyContactNumberCall();
                          }
                        });
                      },
                    ),
                  ),
                 heightSpace20,
                ],
              ),
            ),
          )),
    );
  }




   verifyMobileApi() async {

    setState(() {
        isLoading = true;
    });

    final body = {
      "mobile_number": driverMobileNumberController.text.trim(),
      "country_code":countryCode.toString()
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
       'Accept-Language': languageSelectcode.toString(),
    };

    final res = await http.post(Uri.parse(AppConstants.driverSendOTP),
        body: jsonEncode(body), headers: requestHeaders);
 
 log("APiURL ${AppConstants.driverSendOTP}");
   log("driverSendOTP ${res.body}");
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
            Get.to(()=>OTPVerifyPassword(mobile:driverMobileNumberController.text,country:countryCode));
            showSnackBar(languages[choosenLanguage]['text_Success'], data["message"].toString(), Colors.greenAccent);
          });
        }
      } else if (res.statusCode == 500) {
        setState(() {
         isLoading = false;
          showSnackBar(languages[choosenLanguage]['text_Error'], data["message"].toString(), Colors.redAccent);
        });
      } else if (res.statusCode == 401) {
      setState(() {
        isLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], data["message"].toString(), Colors.redAccent);
      });
    } else {
       isLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Error'], res.statusCode.toString(), Colors.redAccent);
      }
   
  }




}
