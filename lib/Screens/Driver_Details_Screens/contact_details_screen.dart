import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Screens/Driver_Details_Screens/vehicle_details_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyContactDetailsPage extends StatefulWidget {
  const MyContactDetailsPage({super.key});

  @override
  State<MyContactDetailsPage> createState() => _MyContactDetailsPageState();
}

class _MyContactDetailsPageState extends State<MyContactDetailsPage> {
  int? selectedOption;
  bool isVisible = false;
  final _formKey = GlobalKey<FormState>();

  DriverAuthController controller = Get.put(DriverAuthController());

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? languages[choosenLanguage]['text_Enter_valid_email_address']
        : null;
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
                        child: Image.asset(Images.contactDetails),
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
                          SvgPicture.asset(Images.indecatorBg),
                          Container(
                            decoration: BoxDecoration(
                                color: appBackgroundColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: Text(
                                "3",
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
                      languages[choosenLanguage]['text_Contact_Details'],
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0),
                    ),
                    heightSpace20,
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Text(
                            languages[choosenLanguage]['text_Gender'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    heightSpace10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color:
                                    isVisible ? redColor : Colors.transparent)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Radio(
                              activeColor: appBackgroundColor,
                              value: 0,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                  controller.driverGender.value = "Male";
                                });
                              },
                            ),
                            Text(
                              languages[choosenLanguage]['text_Male'],
                              style: TextStyle(
                                color: greyTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                fontSize: 12.0,
                              ),
                            ),
                            Radio(
                              activeColor: appBackgroundColor,
                              value: 1,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                  controller.driverGender.value = "Female";
      
                                  print("Button value: $value");
                                });
                              },
                            ),
                            Text(
                              languages[choosenLanguage]['text_Female'],
                              style: TextStyle(
                                color: greyTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                fontSize: 12.0,
                              ),
                            ),
                            Radio(
                              activeColor: appBackgroundColor,
                              value: 2,
                              groupValue: selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                  controller.driverGender.value =
                                      "Neutral / Unknown";
                                  print("Button value: $value");
                                });
                              },
                            ),
                            Text(
                              languages[choosenLanguage]['text_Neutral_Unknown'],
                              style: TextStyle(
                                color: greyTextColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Roboto",
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              languages[choosenLanguage]['text_Select_Gender'],
                              style: TextStyle(
                                  color: redColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    ),
                    heightSpace10,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                        capitalization: TextCapitalization.words,
                        AutovalidateModes: AutovalidateMode.onUserInteraction,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        controller: controller.driverFirstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return languages[choosenLanguage]['text_First_name_is_required'];
                          }
                          return null;
                        },
                        obscureText: false,
                        isTrue: true,
                        isPassword: true,
                        hintText: languages[choosenLanguage]
                            ['text_First_name'],
                        onIconTap: () {},
                      ),
                    ),
                    heightSpace20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                        ],
                        capitalization: TextCapitalization.words,
                        AutovalidateModes: AutovalidateMode.onUserInteraction,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        controller: controller.driverLastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return languages[choosenLanguage]['text_Last_name_is_required'];
                          }
                          return null;
                        },
                        obscureText: false,
                        isTrue: true,
                        isPassword: true,
                        hintText: languages[choosenLanguage]
                            ['text_Last_name'],
                        onIconTap: () {},
                      ),
                    ),
                  heightSpace20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        inputFormat: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                        ],
                        capitalization: TextCapitalization.words,
                        AutovalidateModes: AutovalidateMode.onUserInteraction,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.text,
                        controller: controller.driverDLNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return languages[choosenLanguage]
                            ['text_Driver_license_number_required'];
                          }
                          return null;
                        },
                        obscureText: false,
                        isTrue: true,
                        isPassword: true,
                        hintText: languages[choosenLanguage]['text_Driver_license_number'],
                        onIconTap: () {},
                      ),
                    ),
                   heightSpace20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        capitalization: TextCapitalization.words,
                        AutovalidateModes: AutovalidateMode.onUserInteraction,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.emailAddress,
                        controller: controller.driverEmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return languages[choosenLanguage]
                                ['text_Email_is_required'];
                          }
                          return validateEmail(value);
                        },
                        obscureText: false,
                        isTrue: true,
                        isPassword: true,
                        hintText: languages[choosenLanguage]
                            ['text_E-mail'],
                        onIconTap: () {},
                      ),
                    ),
                    heightSpace20,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: CustomTextField(
                        capitalization: TextCapitalization.words,
                        AutovalidateModes: AutovalidateMode.onUserInteraction,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                        controller: controller.driverAddressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return languages[choosenLanguage]['text_Address_is_required'];
                          }
                          return null;
                        },
                        obscureText: false,
                        isTrue: true,
                        isPassword: true,
                        hintText: languages[choosenLanguage]
                            ['text_Address'],
                        onIconTap: () {},
                      ),
                    ),
                    heightSpace20,
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CustomButton(
                          isVisible: true,
                          btnName: languages[choosenLanguage]['text_Confirm'],
                          onPressed: () {
                        
                            if (_formKey.currentState!.validate()) {
                              if (selectedOption != null) {
                                Get.to(()=>MyVehicleDetailsPage());
                              } else {
                                setState(() {
                                  isVisible = true;
                                });
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
        )),
      ),
    );
  }
}
