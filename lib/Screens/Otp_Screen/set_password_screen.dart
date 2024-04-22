import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Screens/Driver_Details_Screens/contact_details_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MySetPasswordPage extends StatefulWidget {
  const MySetPasswordPage({super.key});

  @override
  State<MySetPasswordPage> createState() => _MySetPasswordPageState();
}

enum PasswordError {
  requiredError('Password is Required'),
  upperCase('Must contain at least one uppercase'),
  lowerCase('Must contain at least one lowercase'),
  digit('Must contain at least one digit'),
  eigthCharacter('The Password field must be between 9 and 64 characters.'),
  specialCharacter('Contain at least one special character: !@#\\\$&*~');

  final String message;

  const PasswordError(this.message);
}
enum PasswordError1 {
  requiredError('Wachtwoord is vereist'),
  upperCase('Moet minstens één hoofdletter bevatten'),
  lowerCase('Moet minstens één kleine letter bevatten'),
  digit('Moet minstens één cijfer bevatten'),
  eigthCharacter('Het wachtwoordveld moet tussen 9 en 64 tekens lang zijn.'),
  specialCharacter('Bevat ten minste één speciaal teken: !@#\\\$&*~');

  final String message;

  const PasswordError1(this.message);
}

class _MySetPasswordPageState extends State<MySetPasswordPage> {
  DriverAuthController controller = Get.put(DriverAuthController());
  bool showPassword = true;
  final _formKey = GlobalKey<FormState>();

  int errorValue = 0;

  List<PasswordError> passwordValidator(String password) {
    List<PasswordError> errors = [];
    
    if (password.isEmpty) {
      errors.add(PasswordError.requiredError);
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add(PasswordError.upperCase);
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add(PasswordError.lowerCase);
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add(PasswordError.digit);
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      errors.add(PasswordError.specialCharacter);
    }
    if (!RegExp(r'.{9,}').hasMatch(password)) {
      errors.add(PasswordError.eigthCharacter);
    }


    return errors;
  }
  List<PasswordError1> passwordValidator1(String password) {
    List<PasswordError1> errors = [];

    if (password.isEmpty) {
      errors.add(PasswordError1.requiredError);
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      errors.add(PasswordError1.upperCase);
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      errors.add(PasswordError1.lowerCase);
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      errors.add(PasswordError1.digit);
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(password)) {
      errors.add(PasswordError1.specialCharacter);
    }
    if (!RegExp(r'.{9,}').hasMatch(password)) {
      errors.add(PasswordError1.eigthCharacter);
    }

    return errors;
  }


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
                      height: MediaQuery.of(context).size.height / 2 * 0.4,
                      decoration: BoxDecoration(color: fillColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20),
                        child: Image.asset(Images.setPasswordImage),
                      ),
      
                
                    ),
                   heightSpace30,
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
                          SvgPicture.asset(Images.indecatorBg),
                          Container(
                            decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: Text(
                                "2",
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
                      languages[choosenLanguage]['text_Set_Password'],
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0),
                    ),
                   heightSpace10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(

                        AutovalidateModes: AutovalidateMode.onUserInteraction,
                        controller: controller.driverPasswordController,
                        validator: (password) {
                           if (languageSelectcode.toString() == "en") {
                            if (password != null) {
                              // Get all errors
                              final validators = passwordValidator(password);

                              // Returns null if password is valid
                              if (validators.isEmpty) return null;

                              // Join all errors that start with "-"
                              return validators
                                  .map((e) => '- ${e.message}')
                                  .join('\n');
                            }
                          } else {
                            if (password != null) {
                              // Get all errors
                              final validators = passwordValidator1(password);

                              // Returns null if password is valid
                              if (validators.isEmpty) return null;

                              // Join all errors that start with "-"
                              return validators
                                  .map((e) => '- ${e.message}')
                                  .join('\n');
                            }
                          }
                          return null;
                        },
                        obscureText: showPassword,
                        isTrue: true,
                        isPassword: true,
                        hintText: languages[choosenLanguage]
                            ['text_Password'],
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
                      ),
                    ),
                   heightSpace20,
                   
      
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: greyTextColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        widthSpace10,
                          Text(
                            languages[choosenLanguage]['text_Between_9_and_64_characters'],
                            style: TextStyle(
                                color: greyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ],
                      ),
                    ),
      
                    heightSpace10,
                   
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: greyTextColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        widthSpace10,
                          Text(
                            languages[choosenLanguage]['text_Uppercase_letters'],
                            style: TextStyle(
                                color: greyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ],
                      ),
                    ),
                   heightSpace10,
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: greyTextColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                      widthSpace10,
                          Text(
                            languages[choosenLanguage]['text_Lowercase_letters'],
                            style: TextStyle(
                                color: greyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ],
                      ),
                    ),
                  heightSpace10,
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: greyTextColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                         widthSpace10,
                          Text(
                            languages[choosenLanguage]['text_Numbers'],
                            style: TextStyle(
                                color: greyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ],
                      ),
                    ),
                   heightSpace10,
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                color: greyTextColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        widthSpace10,
                          Text(
                            languages[choosenLanguage]['text_Special_characters'],
                            style: TextStyle(
                                color: greyTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Nunito Sans'),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap: () {
                        
      
                            if (_formKey.currentState!.validate()) {
                              Get.to(()=>MyContactDetailsPage());
                            }
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: btnColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 12.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        languages[choosenLanguage]['text_Confirm'],
                                        style: TextStyle(
                                            color: hintTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Nunito Sans'),
                                      ),
                                    heightSpace10,
                                    ],
                                  ),
                                ),
                              )),
                        )),
                  heightSpace10,
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

//

