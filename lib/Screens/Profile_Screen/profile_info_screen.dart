

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_profile_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/edit_profile_screen.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyProfileInfoPage extends StatefulWidget {
  const MyProfileInfoPage({super.key});

  @override
  State<MyProfileInfoPage> createState() => _MyProfileInfoPageState();
}

class _MyProfileInfoPageState extends State<MyProfileInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<DriverProfileController>(
      init: DriverProfileController(),
      builder: (controller) => ModalProgressHUD(
        inAsyncCall: controller.isLoading.value,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: 
              LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                          children: [
                            Row(
                              children: [
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
                           
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 15),
                                  child: Text(
                                    languages[choosenLanguage]['text_Profile_Info'],
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),

                             Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xfff9fafc), width: 14),
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: whiteColor, width: 14),
                                borderRadius: BorderRadius.circular(50)),
                            child: controller
                                            .driverProfileModel!.data!.uploads!.isEmpty
                                        ? CircleAvatar(
                                            backgroundColor: whiteColor,
                                            radius: 26,
                                            child: Image.asset(Images.profileImage),
                                          )
                                        : controller.file_path.value!=
                                                null
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  controller.file_path.value
                                                      .toString(),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundColor: whiteColor,
                                                radius: 26,
                                                child: Image.asset(Images.profileImage),
                                              ),
                               
                          ),
                        ),
                    
                      ],
                    ),
                          
                            heightSpace30,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(Images.profileInfoImage),
                                        widthSpace20,
                                        Text(
                                          languages[choosenLanguage]['text_Full_Name'],
                                          style: TextStyle(
                                              color: hintTextColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      controller.driverProfileModel!.data!.firstName! +
                                          " " +
                                          controller
                                              .driverProfileModel!.data!.lastName!,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 70, right: 20),
                              height: 2,
                              width: double.infinity,
                              decoration: BoxDecoration(color: fillColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(Images.contactImage),
                                       widthSpace20,
                                        Text(
                                          languages[choosenLanguage]['text_Mobile_Number'],
                                          style: TextStyle(
                                              color: hintTextColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "(${controller.driverProfileModel!.data!.countryCode!}) ${controller.driverProfileModel!.data!.mobileNumber!}",
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 70, right: 20),
                              height: 2,
                              width: double.infinity,
                              decoration: BoxDecoration(color: fillColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                                           mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(Images.emailImage),
                                       widthSpace20,
                                        Text(
                                          languages[choosenLanguage]['text_E-mail'],
                                          style: TextStyle(
                                              color: hintTextColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                        SizedBox(
                                          width: 20,
                                        ),
                        
                                      
                                    Container(
                                      width: Get.width*0.55,
                                       alignment: Alignment.centerRight,
                                      child: FittedBox( 
                                       fit: BoxFit.scaleDown,
                                                        child: Text(
                                            controller.driverProfileModel!.data!.email!,
                                            style: TextStyle(
                                                color: blackTextColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                
                                               fontSize: 16  ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                          ),
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 70, right: 20),
                              height: 2,
                              width: double.infinity,
                              decoration: BoxDecoration(color: fillColor),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(Images.genderImage),
                                            widthSpace20,
                                            Text(
                                              languages[choosenLanguage]['text_Gender'],
                                              style: TextStyle(
                                                  color: hintTextColor,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          allWordsCapitilize1(allWordsCapitilize("${language()=="en" ||language()=="" ? 
                                          controller.driverProfileModel!.data!.profile!.gender:
                                          controller.driverProfileModel!.data!.profile!.gender=="male"?"Man":
                                          controller.driverProfileModel!.data!.profile!.gender=="female"?"Vrouw":"Neutraal/Onbekend"
                                          
                                          }"))
                                          ,
                                          style: TextStyle(
                                              color: blackTextColor,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 70, right: 20),
                              height: 2,
                              width: double.infinity,
                              decoration: BoxDecoration(color: fillColor),
                            ),
                            Spacer(),
                           heightSpace10,
                          
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                      ),
                                      child: CustomButton(
                                        isVisible: true,
                                        btnName: languages[choosenLanguage]['text_Edit_Profile'],
                                        onPressed: () {
                                          Get.to(()=>MyEditProfilePage());
                                          
                                        },
                                      )),
                                  heightSpace10,
                                  GestureDetector(
                                    onTap: () {
                                      Get.dialog(AlertDialog(
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        content: Container(
                                            height: 150,
                                            color: whiteColor,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0, vertical: 15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                   Text(
                                                languages[choosenLanguage]
                                                    ['text_Are_you_sure'],
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                   Text(
                                                      languages[choosenLanguage]
                                                    ['text_Do_you_want_to_Delete_Your_Account'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        child: Text(
                                                      languages[choosenLanguage]
                                                          ['text_No'],
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    appBackgroundColor)),
                                                        onPressed: () => Get.back(),
                                                      ),
                                                      TextButton(
                                                        child: Text(
                                                      languages[choosenLanguage]
                                                          ['text_Yes'],
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color:
                                                                    appBackgroundColor)),
                                                        onPressed: () {
                                                          Get.back();
                                                         
                                                         controller. DeleteAccountApi();
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ));
                                    },
                                    child: Container(
                                      height: 50,
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: outlineColor, width: 2)),
                                      child: Center(
                                          child: Text(
                                        languages[choosenLanguage]['text_Delete_Account'],
                                        style: TextStyle(
                                            color: redColor,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      )),
                                    ),
                                  ),
                                  heightSpace20
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            
        ),
      ),
    ));
  }

  String allWordsCapitilize (String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
}
  String allWordsCapitilize1 (String str) {
    return str.toLowerCase().split('/').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join('/');
}
}
