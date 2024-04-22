import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Screens/Home_Screens/home_screen.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewPassword extends StatefulWidget {
  var mobile,country;
   NewPassword({super.key,required this.mobile,required this.country});

  @override
  State<NewPassword> createState() => _NewPasswordState();
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

class _NewPasswordState extends State<NewPassword> {

TextEditingController passwordController=TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();
  bool isLoading=false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();

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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20),
                        child: Image.asset(Images.contactDetails),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      languages[choosenLanguage]['text_Enter_Password'],
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
                       languages[choosenLanguage]['text_Lorem_Ipsum_is_simply_dummy_text_typesetting_industry'],
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
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        controller: passwordController,
                          AutovalidateModes: AutovalidateMode.onUserInteraction,
                          obscureText: showPassword,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage]['text_New_Password'],
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
                           validator: (password) {
                           if( languageSelectcode.toString()=="en"){
                            if (password != null) {
                              // Get all errors
                              final validators = passwordValidator(password);

                              // Returns null if password is valid
                              if (validators.isEmpty) return null;

                              // Join all errors that start with "-"
                              return validators
                                  .map((e) => '- ${e.message}')
                                  .join('\n');
                            }}else{
                               if (password != null) {
                               // Get all errors
                              final validators = passwordValidator1(password);

                              // Returns null if password is valid
                              if (validators.isEmpty) return null;

                              // Join all errors that start with "-"
                              return validators
                                  .map((e) => '- ${ e.message}')
                                  .join('\n');
                            }
                            }

                            return null;
                          },
                         ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        controller: confirmpasswordController,
                          AutovalidateModes: AutovalidateMode.onUserInteraction,
                          obscureText: showConfirmPassword,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage]['text_Confirm_Password'],
                          onIconTap: () {},
                          iconPerfix: GestureDetector(
                            onTap: () {
                              setState(() {
                                showConfirmPassword = !showConfirmPassword;
                              });
                            },
                            child: Container(
                              height: 14,
                              width: 14,
                              child: showConfirmPassword
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                          validator: (password) {
                          if( languageSelectcode.toString()=="en"){
                            if (password != null) {
                              // Get all errors
                              final validators = passwordValidator(password);

                              // Returns null if password is valid
                              if (validators.isEmpty) return null;

                              // Join all errors that start with "-"
                              return validators
                                  .map((e) => '- ${e.message}')
                                  .join('\n');
                            }}else{
                               if (password != null) {
                               // Get all errors
                              final validators = passwordValidator1(password);

                              // Returns null if password is valid
                              if (validators.isEmpty) return null;

                              // Join all errors that start with "-"
                              return validators
                                  .map((e) => '- ${ e.message}')
                                  .join('\n');
                            }
                            }
                          return null;
                        },
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomButton(
                          isVisible: true,
                          btnName: "Save",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                             if(passwordController.text.toString()!=confirmpasswordController.text.toString()){
                                showSnackBar("Error",languages[choosenLanguage]['text_Password_and_Confirm_Password_should_be_not_match'] ,
                                    Colors.redAccent);
                             }else{
                                  newPaswordApi() ;
                             }
                            }

                          },
                        )),
                    
                    heightSpace20,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

newPaswordApi() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");

    setState(() {
      isLoading = true;
    });

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
       'Accept-Language': languageSelectcode.toString(),
    };
    final body = {
      "mobile_number": widget.mobile.toString(),
      "country_code": widget.country.toString(),
      "password":passwordController.text,
        "confirm_password":confirmpasswordController.text
     
    };

    log("rideHistoryApi ${body}");

    final res = await http.post(Uri.parse(AppConstants.changepassword),
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
          isLoading = false;
          Get.offAll(() => MyHomePage());
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
