
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDocumentPage extends StatefulWidget {
  const MyDocumentPage({super.key});

  @override
  State<MyDocumentPage> createState() => _MyDocumentPageState();
}

class _MyDocumentPageState extends State<MyDocumentPage> {
  File? profileImage;
  File? idImage;
  File? dlImage;
  File? ownwershipIdImage;
  bool isVisible = false;
  DriverAuthController driverAuthController = Get.put(DriverAuthController());

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      if (image == null) return;
      final imageTemp = File(image.path);
      if (mounted) {
        setState(() {
          this.profileImage = imageTemp;
          driverAuthController.driverProfileImage = File(image.path);
        });
        // uploadProfilePic(File(image.path));
      }

     
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }


  Future pickID() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      if (image == null) return;
      final imageTemp = File(image.path);
      if (mounted) {
        setState(() {
          this.idImage = imageTemp;
          driverAuthController.driverIDImage = File(image.path);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

 

  Future pickDL() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,
          maxHeight: 480,
          maxWidth: 640,
          imageQuality: 50);
      if (image == null) return;
      final imageTemp = File(image.path);
      if (mounted) {
        setState(() {
          this.dlImage = imageTemp;
          driverAuthController.driverDrivingLicenceLImage = File(image.path);
        });
      }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

 
  Future pickOwnershipID() async {
    try {
      final result = await FilePicker.platform.pickFiles(
       type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result == null) return;
   
        PlatformFile file = result.files.first;

        print(file.name);
        print(file.bytes);
        print(file.size);
        print(file.extension);
        print(file.path);
        final imageTemp = File(file.path.toString());
        if (mounted) {
          setState(() {
            this.ownwershipIdImage = imageTemp;
            driverAuthController.driverOwnershipIdImage = File(file.path.toString());
          });
        }
        
     

     
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GetX<DriverAuthController>(
        init: DriverAuthController(),
        builder: (controller) => CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
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
                          horizontal: 30.0, vertical: 25),
                      child: Image.asset(Images.doumentsImages),
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
                        SvgPicture.asset(Images.indecatorBg),
                        Container(
                          decoration: BoxDecoration(
                              color: appBackgroundColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Text(
                              "4",
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
                              "5",
                              style: TextStyle(
                                  color: whiteColor,
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
                    languages[choosenLanguage]['text_Documents'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                  heightSpace15,
                  Text(
                    languages[choosenLanguage]['text_Your_face_should_recognizable_image'],
                    style: TextStyle(
                        color: greyTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                 heightSpace10,
                  Container(
                    width: 100,
                    height: 100,
                     padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: isVisible ? redColor : uploadDocBorderColor,
                            width: isVisible ? 1 : 7),
                        borderRadius: BorderRadius.circular(50)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: profileImage == null
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child:
                                  SvgPicture.asset(Images.documentUploadIcon))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(profileImage!.path),
                                fit: BoxFit.cover,
                              )),
                    ),
                  ),
                heightSpace10,
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: outlineColor, width: 1)),
                      child: Text(
                        languages[choosenLanguage]['text_Upload_image'],
                        style: TextStyle(
                            color: hintTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                 heightSpace10,
                  Text(
                     languages[choosenLanguage]['text_Required_Documents'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                  heightSpace10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      languages[choosenLanguage]['text_verify_above_documents_we_require'],
                      style: TextStyle(
                          color: hintTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0),
                    ),
                  ),
                 heightSpace10,
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "1 - ${languages[choosenLanguage]['text_ID_Card']}\n2 - ${languages[choosenLanguage]['text_Driving_License']} ${controller.driverTypeID.value == "driver"?"":"\n3 - ${languages[choosenLanguage]['text_Ride_ownership_document']}"}",
                          style: TextStyle(
                              color: hintTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  heightSpace20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 103,
                            height: 95,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isVisible
                                        ? redColor
                                        : uploadDocBorderColor,
                                    width: isVisible ? 1 : 7),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: fillColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: GestureDetector(
                                  onTap: () {
                                    pickID();
                                  },
                                  child: idImage == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SvgPicture.asset(
                                              Images.documentUploadIcon),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            File(idImage!.path),
                                            fit: BoxFit.cover,
                                          )),
                                ),
                              ),
                            ),
                          ),
                          heightSpace10,
                          Text(
                            languages[choosenLanguage]['text_ID_Card'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 103,
                            height: 95,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isVisible
                                        ? redColor
                                        : uploadDocBorderColor,
                                    width: isVisible ? 1 : 7),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  pickDL();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: dlImage == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SvgPicture.asset(
                                              Images.documentUploadIcon),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.file(
                                            File(dlImage!.path),
                                            fit: BoxFit.cover,
                                          )),
                                ),
                              ),
                            ),
                          ),
                         heightSpace10,
                          Text(
                            languages[choosenLanguage]['text_Driving_License'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                     if(controller.driverTypeID.value == "owner") Column(
                        children: [
                          Container(
                            width: 103,
                            height: 95,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: isVisible
                                        ? redColor
                                        : uploadDocBorderColor,
                                    width: isVisible ? 1 : 7),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  pickOwnershipID();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: fillColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ownwershipIdImage == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SvgPicture.asset(
                                              Images.documentUploadIcon),
                                        )
                                      : Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.asset(
                                              Images.pdf,
                                            )),
                                      ),
                                ),
                              ),
                            ),
                          ),
                         heightSpace10,
                          Text(
                            languages[choosenLanguage] ['text_Ownership_ID'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
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
                              btnName: languages[choosenLanguage] ['text_Confirm'],
                              onPressed: () async {
                               SharedPreferences prefs = await SharedPreferences.getInstance();
                               var fcmToken = prefs.getString("fcm_token");
                                Map<String, dynamic> fields = {
                                  'country_code':controller.countryCode.value,
                                  'language_id': controller.driverLanguageId.value,
                                  'gender': controller.driverGender.value,
                                  'first_name':
                                      controller.driverFirstNameController.text,
                                  'last_name': controller
                                      .driverLastNameController.text,
                                  'dl_number':
                                      controller.driverDLNumberController.text ,
                                  'email': controller.driverEmailController.text,
                                  'mobile_number': controller.driverMobileNumberController.text,
                                  'address': controller.driverAddressController.text,
                                  'plate_number': controller.vehiclePlateNumberController.text,
                                  'production_year': controller.vehicleProducationYearController.text,
                                  'vehicle_model_id': controller.vehicleModelID.value,
                                  'vehicle_color_id': controller.vehicleColorID.value,
                                  'password': controller.driverPasswordController.text,
                                  "fcm_token": fcmToken,
                                  "ownership_type":controller.driverTypeID
                                };
                               if(controller.driverTypeID.value=="owner"){
                                  if (profileImage == null &&
                                      ownwershipIdImage == null &&
                                      dlImage == null &&
                                      idImage == null) {
                                    setState(() {
                                      isVisible = true;
                                    });
                                  } else {
                                  
                                   controller.registerDriver(fields, context);
                                  }
                                   }
                                else {
                                  if (profileImage == null &&
                                      dlImage == null &&
                                      idImage == null) {
                                    setState(() {
                                      isVisible = true;
                                    });
                                  } else {
                                    controller.registerDriver(fields, context);
                                  }
                                }
                              },
                            )),
                  heightSpace20
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
