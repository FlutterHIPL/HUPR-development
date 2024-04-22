
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_indecator_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';


class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  DriverAuthController controller = Get.put(DriverAuthController());

    
  final countryPicker =   FlCountryCodePicker(
    localize: true, 
    title: Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "  ${languages[choosenLanguage]['text_Select_Country']}",
        style: TextStyle(fontSize: 24),
      ),
    ),
    searchBarDecoration: InputDecoration(
      suffixIcon: Icon(Icons.search),
      hintText:
          '${languages[choosenLanguage]['text_Country_Code_or_Dial_Code']}',
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    filteredCountries: ['+91', 'IN', '+31', 'NL'],
    favorites: ['+91', 'IN', '+31', 'NL'],
  );
  var  flagImage = "", countryCodePackageName = "";
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
        child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:   Column(
          children: [
            Container(
              decoration: BoxDecoration(color: fillColor),
              child: Image.asset(Images.signInImage),
            ),
            heightSpace30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    CommonIndicatorWidget(),
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
                    CommonRunningCarIndicatorWidget(),
                  ],
                ),
              ],
            ),
          
          
          
          
          
           heightSpace20,
           CustomWidget().CustomTextWidget(
            text:languages[choosenLanguage]['text_Sign_Sign'],
            textsize: 24,
            fontWeight: FontWeight.w600
            ),
           
            heightSpace10,
             Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CustomWidget().CustomTextWidget(
                      text: languages[choosenLanguage]
                          ['text_Moments_away_from_registering'],
                      textsize: 14,
                      fontWeight: FontWeight.w400),
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
                          setState(() {
                           controller. countryCode.value = picked.dialCode;
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
                                  ?
                                SizedBox(
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
                                    CustomWidget().CustomTextWidget(
                                      text: controller.countryCode.value,
                                      textsize: 14,
                                      fontWeight: FontWeight.w400),
                              
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
                        controller: controller.driverMobileNumberController,
                        maxLength: 15,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        isTrue: true,
                        hintText: languages[choosenLanguage]
                            ['text_Enter_phone_number'],
                        obscureText: false,
                        onIconTap: () {},
                        onChanged: (value) {
                          setState(() {
                            if (value != null || value!.isNotEmpty) {
                              isError = false;
                             
                            }
                            
                            
                            
                            if (value.length < 7  ) {
                              isLengthError = true;
                            } else {
                              isLengthError = false;
                            }
                             if (value.isEmpty ) {
                                isLengthError = false;
                              isError = true;
                           controller.driverMobileNumberController.clear();
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
                    child: CustomWidget().CustomTextWidget(
                            text:  languages[choosenLanguage]['text_Phone_number_required'],
                            textsize: 12,
                            textColor: redColor,
                            fontWeight: FontWeight.w400),
                    
                    
                   
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
                    child: CustomWidget().CustomTextWidget(
                            text: languages[choosenLanguage] ['text_phone_number_7_digits'],
                            textsize: 12,
                            textColor: redColor,
                            fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(
                () => controller.isVarifyContactNumberLoading.value
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
                    : CustomButton(
                        isVisible: true,
                        btnName: languages[choosenLanguage]
                            ['text_Confirm'],
                        onPressed: () {
                          
                          setState(() {
                            if (controller.driverMobileNumberController.text
                                .isEmpty) {
                              isError = true;
                            } else if (controller
                                    .driverMobileNumberController
                                    .text
                                    .length <
                                7) {
                              isLengthError = true;
                            } else {
                              isError = true;
                              isLengthError = true;
                            }
                  
                            if (isError && isLengthError) {
                              isError = false;
                              isLengthError = false;

                              controller.varifyContactNumberCall();
                             
                            }
                            
                          });
                  
                  
                        },
                      ),
              ),
            ),
            heightSpace20,
          ],
        ),
          ),
        ));
  }

 
}
class MyOvalClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    //modify value here based on your need
    //size width = 30.0, and height = 30.0 regardless of child size its don't matter
    var rect = const Rect.fromLTWH(0.0, 0.0, 30.0, 30.0);
    return rect;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
