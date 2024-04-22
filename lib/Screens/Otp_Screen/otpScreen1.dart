import 'dart:async';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';

import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MyOtpPage1 extends StatefulWidget {
 MyOtpPage1( {super.key,});
  @override
  State<MyOtpPage1> createState() => _MyOtpPage1State();
}

class _MyOtpPage1State extends State<MyOtpPage1> {
final _formKey = GlobalKey<FormState>();  






  

  
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
        body: SafeArea(
            child: GetX<DriverAuthController>(
          init: DriverAuthController(),
          builder: (controller) => 
             CustomScrollView(
          
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
                    
                          // SvgPicture.asset(Images.signInImage),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: appBackgroundColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(Images.dotImage),
                              Container(
                                decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                        color: hintTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(Images.dotImage),
                              Container(
                                decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                        color: hintTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(Images.dotImage),
                              Container(
                                decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "4",
                                    style: TextStyle(
                                        color: hintTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(Images.dotImage),
                              Container(
                                decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5),
                                  child: Text(
                                    "5",
                                    style: TextStyle(
                                        color: hintTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                       Text(
                        languages[choosenLanguage]['text_Enter_OTP'],
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 24.0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            languages[choosenLanguage]['text_verification_code_has_been_sent_phone_number'],
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
                            controller:controller.pinController,
                            length: 6,
                            obscureText: false,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.number,
                            autoDismissKeyboard: true,
                            cursorColor: blackTextColor,
                            enableActiveFill: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return languages[choosenLanguage]
                                  ['text_The_Pin_is_required'];
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) {},
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
                        SizedBox(
                          height: 20,
                        ),
                
                       controller.isLoadingOTP.value==false
                              ?  GestureDetector(
                          onTap: (){
                            setState(() {
                              // controller.isLoadingOTP.value=true;
                            controller.pinController.clear();
                            controller.driverOTP();
                            });
                           
                          },
                          child: Text(
                            languages[choosenLanguage] ['text_Resend_code'],
                            style: TextStyle(
                                color: appBackgroundColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0),
                          ),
                        ): Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                                strokeWidth: 3, color: appBackgroundColor),
                          ),
                        ),
                       
                        Spacer(),
                       controller.isLoading.value?
                        
                        
                        Container(
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
                                  )): Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomButton(
                            isVisible: true,
                            btnName: languages[choosenLanguage]
                                    ['text_Confirm'],
                            onPressed: () async {
                
                                 if (_formKey.currentState!.validate()) {  
                    
                                              if(controller.pinController.text.length==6)
                                              {
                                         setState(() {
                                          controller.driverLoginCall("otp");
                                                //isButtonLoading=true;
                                            });
                
                
                
                
                           
                                            }
                            
                                            else{
                                              
                                            }
                                 }
                    
                    
                    
                         
                            
                            },
                          ),
                        ),
                        heightSpace20,
                      ],
                    ),
                  ),
                ),
                        ],
                      ),
              
            )
            ),
      ),
    );
  }


 


}
