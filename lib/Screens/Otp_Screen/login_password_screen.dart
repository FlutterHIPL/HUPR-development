
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

enum PasswordError {
  upperCase('Must contain at least one uppercase'),
  lowerCase('Must contain at least one lowercase'),
  digit('Must contain at least one digit'),
  eigthCharacter('Must be at least 9 characters in length'),
  specialCharacter('Contain at least one special character: !@#\\\$&*~');

  final String message;

  const PasswordError(this.message);
}

class MyLoginPasswordPage extends StatefulWidget {
  var countryCode,phoneNumber;
   MyLoginPasswordPage({super.key,required this.countryCode,required this.phoneNumber});

  @override
  State<MyLoginPasswordPage> createState() => _MyLoginPasswordPageState();
}

class _MyLoginPasswordPageState extends State<MyLoginPasswordPage> {
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();

var isLoading=false;
  List<PasswordError> passwordValidator(String password) {
    List<PasswordError> errors = [];

    while (!RegExp(r'.{8,}').hasMatch(password)) {
      errors.add(PasswordError.eigthCharacter);
      if (!RegExp(r'[A-Z]').hasMatch(password)) {
        errors.add(PasswordError.upperCase);
      } else if (!RegExp(r'[a-z]').hasMatch(password)) {
        errors.add(PasswordError.lowerCase);
        break;
      } else if (!RegExp(r'[0-9]').hasMatch(password)) {
        errors.add(PasswordError.digit);
        break;
      } else if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
        errors.add(PasswordError.specialCharacter);
        break;
      }
    }

    return errors;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
          child: Scaffold(
        body: GetX<DriverAuthController>(
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
                        height: MediaQuery.of(context).size.height / 2 * 0.4,
                        decoration: BoxDecoration(color: fillColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 20),
                          child: Image.asset(Images.setPasswordImage),
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
                     heightSpace20,
                      Text(
                        languages[choosenLanguage]['text_Enter_Password'],
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 24.0),
                      ),
                     heightSpace20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomTextField(
                          AutovalidateModes: AutovalidateMode.onUserInteraction,
                          controller: controller.driverPasswordController,
                          obscureText: showPassword,
                          isTrue: true,
                          isPassword: true,
                          hintText:   languages[choosenLanguage]['text_Password'],
                          onIconTap: () {},
                          iconPerfix: GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Container(
                              height: 14,
                              width: 14,
                              child: showPassword
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                         
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return languages[choosenLanguage]['text_Password_is_required'];
                            }
                            if (value.length < 8) {
                              return languages[choosenLanguage]
                                    ['text_The_password_field_must_be_at_least_8_characters'];
                            }
      
                            return null;
                          }
                        ),
                      ),
                     heightSpace20,
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: controller.isLoading.value
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
                                  btnName: languages[choosenLanguage]['text_Continue'],
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller.driverLoginCall("password");
                                    }
                          
                                  },
                                )),
                     heightSpace20,
                    controller.isLoadingOTP.value
                              ? Container(
                                  height: 50,
                                  
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, ),
                                    child: Center(
                                      child: SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3, color: appBackgroundColor),
                                      ),
                                    ),
                                  ))
                              : GestureDetector(
                        onTap: () {
                          controller.driverOTP();
                        },
                        child: Text(
                          languages[choosenLanguage]['text_Use_OTP_instead'],
                          style: TextStyle(
                              color: appBackgroundColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                        ),
                      ),
                    heightSpace20,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  
}
