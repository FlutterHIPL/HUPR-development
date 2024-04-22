import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Controller/driver_profile_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class MyEditProfilePage extends StatefulWidget {
  const MyEditProfilePage({super.key});

  @override
  State<MyEditProfilePage> createState() => _MyEditProfilePageState();
}

class _MyEditProfilePageState extends State<MyEditProfilePage> {
  bool isVisible = false;
  
  File? profileImage;

  DriverProfileController driverProfileController =
      Get.put(DriverProfileController());

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      if (mounted) {
        setState(() {
          this.profileImage = imageTemp;
          // driverAuthController.driverProfileImage = File(image.path);
        });
        // uploadProfilePic(File(image.path));
      }

    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }



  @override
  void initState() {
    super.initState();

    if (driverProfileController.driverProfileModel!.data!.profile!.gender ==
        "male") {
      driverProfileController.selectedOption = 0;
    } else if (driverProfileController
            .driverProfileModel!.data!.profile!.gender ==
        "female") {
      driverProfileController.selectedOption = 1;
    } else {
      driverProfileController.selectedOption = 2;
    }
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
      child: SafeArea(
          child: GetBuilder<DriverProfileController>(
        init: DriverProfileController(),
        builder: (controller) => ModalProgressHUD(
          inAsyncCall: controller.isLoading.value,
          child: Scaffold(
            body: 
                SingleChildScrollView(
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
                            languages[choosenLanguage]['text_Edit_Profile'],
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
                                border: Border.all(color: fillColor, width: 14),
                                borderRadius: BorderRadius.circular(50)),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: whiteColor, width: 14),
                                  borderRadius: BorderRadius.circular(50)),
                              child: profileImage == null
                                  ? controller.driverProfileModel!.data!.uploads!
                                          .isEmpty
                                      ? CircleAvatar(
                                          backgroundColor: whiteColor,
                                          radius: 26,
                                          child: Image.asset(Images.profileImage),
                                        )
                                      : controller.file_path.value !=
                                              "null"
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                controller.file_path.value
                                                    .toString(),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: whiteColor,
                                              radius: 26,
                                              child: Image.asset(
                                                  Images.profileImage),
                                            )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.file(
                                        File(profileImage!.path),
                                        fit: BoxFit.cover,
                                      )),
                            ),
                          ),
                          Positioned(
                              bottom: 1,
                              right: 5,
                              child: GestureDetector(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: SvgPicture.asset(Images.addImageIcon)))
                        ],
                      ),
                      heightSpace30,
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
                               Radio(
                                activeColor: appBackgroundColor,
                                value: 0,
                                groupValue: driverProfileController.selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    driverProfileController.selectedOption = value!;
                     
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
                                groupValue: driverProfileController.selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    driverProfileController.selectedOption = value!;
                                   
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
                                groupValue: driverProfileController.selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    driverProfileController.selectedOption = value!;
                                    
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
                      heightSpace20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomTextField(
                        controller: controller.driverFirstNameController,
                          inputFormat: [
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                          ],
                          capitalization: TextCapitalization.words,
                          AutovalidateModes: AutovalidateMode.onUserInteraction,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,
                          labelText: languages[choosenLanguage]['text_First_name'],
                  
                      
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return languages[choosenLanguage]['text_Last_name_is_required'];
                            }
                            return null;
                          },
                          obscureText: false,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage] ['text_First_name'],
                          onIconTap: () {},
                        ),
                      ),
                      heightSpace20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomTextField(
                         controller: controller.driverLastNameController,
                          inputFormat: [
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                          ],
                          capitalization: TextCapitalization.words,
                          AutovalidateModes: AutovalidateMode.onUserInteraction,
                          inputAction: TextInputAction.next,
                          inputType: TextInputType.text,    
                          labelText: languages[choosenLanguage]['text_Last_name'],
                  
                          // controller: controller.driverLastNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return languages[choosenLanguage]['text_Last_name_is_required'];
                            }
                            return null;
                          },
                          obscureText: false,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage]['text_Last_name'],
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
                          labelText: languages[choosenLanguage]['text_Mobile_Number'],
                          initialValue:
                              controller.driverProfileModel!.data!.mobileNumber,
                         readOnly: true,
                          isEnabled: true,
                          // controller: controller.driverAddressController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return languages[choosenLanguage]
                              ['text_Enter_Mobile_Number'];
                            }
                            return null;
                          },
                          obscureText: false,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage]
                          ['text_Mobile_Number'],
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
                          labelText: languages[choosenLanguage]
                          ['text_E-mail'],
                          readOnly: true,
                          initialValue:
                              controller.driverProfileModel!.data!.email,
                          obscureText: false,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage]['text_E-mail'],
                          onIconTap: () {},
                        ),
                      ),
                      heightSpace20,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: CustomTextField(
                          controller: controller.driverAddressController,
                          capitalization: TextCapitalization.words,
                          AutovalidateModes: AutovalidateMode.onUserInteraction,
                          inputAction: TextInputAction.done,
                          inputType: TextInputType.text,
                          labelText: languages[choosenLanguage]['text_Address'],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return languages[choosenLanguage]['text_Address_is_required'];
                            }
                            return null;
                          },
                          obscureText: false,
                          isTrue: true,
                          isPassword: true,
                          hintText: languages[choosenLanguage]['text_Address'],
                          onIconTap: () {},
                        ),
                      ),
                      heightSpace20,
                    
                      Container(
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: CustomButton(
                                  isVisible: true,
                                  btnName: languages[choosenLanguage]
                                  ['text_Save'],
                                  onPressed: () {
                                     if (controller.driverFirstNameController.text.isEmpty) {    
                                        }
                                      else  if (controller.driverLastNameController.text.isEmpty) {     
                                        }
                                        else{
                                          if (profileImage==null) {
                                              log("requestHeaders1");
                                            ProfileUdate1(); 
                                           
                                          }
                                          else{
                                             log("requestHeaders");
                                        ProfileUdate();
                                        
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
                ),
             
          ),
        ),
      )),
    );
  }
  
   Future ProfileUdate() async {
    log("requestHeaders1");
    setState(() {
       driverProfileController.isLoading.value=true;
    });
    
   final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids = pref.getInt("id");
    var language_id = pref.getInt("language_id");

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
       'Accept-Language': languageSelectcode.toString(),
    };
log("requestHeaders1 ${requestHeaders}");
    Map<String, dynamic> body = {
     
     "language_id": languageID().toString(),
      "gender": driverProfileController.selectedOption==0?"male":driverProfileController.selectedOption==1?"female":"neutral/unknown",
      "first_name": driverProfileController.driverFirstNameController.text,
      "last_name": driverProfileController.driverLastNameController.text,
      "address": driverProfileController.driverAddressController.text,
     
    };
log("requestHeaders1 ${body}");
    var request =
        new http.MultipartRequest("POST", Uri.parse("${AppConstants.updateProfile}$ids"));

    body.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    request.files.add(
      await http.MultipartFile.fromPath(
      "driver_image",
      profileImage!.path,
      filename: profileImage!.path.split("/").last,
    ),
       );
   
    request.headers.addAll(requestHeaders);
    print("${AppConstants.updateProfile}$ids");
    print(request.files);
   

    await request.send().then((value) async {
      var res = await value.stream.toBytes();
      var alldata = String.fromCharCodes(res);
      var data = jsonDecode(alldata);
    

    
      if (value.statusCode == 200) {
          print("data12 $data");
        setState(() {
            driverProfileController.getDriverProfileCall();
         pref.setString("first_name", driverProfileController.driverFirstNameController.text);
          pref.setString("last_name", driverProfileController.driverLastNameController.text);
          showSnackBar(languages[choosenLanguage]['text_Congratulations'], data['message'],
            Colors.greenAccent);
            driverProfileController.isLoading.value=false;
          driverProfileController.getLoginData();
           Navigator.pop(context);
        });
        
 
      } else {
        setState(() {
          driverProfileController.isLoading.value=false;
           showSnackBar( languages[choosenLanguage]['text_Error'], data['message'], Colors.redAccent, );
        
      
        });
       
      }
    });
   
  }

  
  
   Future ProfileUdate1() async {
    
    // log("ProfileUdate1 ${driverProfileController.selectedOption==0?"male":driverProfileController.selectedOption==1?"female":"neutral/unknown"}");
    setState(() {
       driverProfileController.isLoading.value=true;
    });
    
   final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids = pref.getInt("id");
    var language_id = pref.getInt("language_id");

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
       'Accept-Language': languageSelectcode.toString(),
    };

   var body = {
     "language_id": languageID().toString(),
      "gender": driverProfileController.selectedOption==0?"male":driverProfileController.selectedOption==1?"female":"neutral/unknown",
      "first_name": driverProfileController.driverFirstNameController.text,
      "last_name": driverProfileController.driverLastNameController.text,
      "address": driverProfileController.driverAddressController.text,
    };
    log("requestHeaders ${body}");
  final res = await http.post(Uri.parse("${AppConstants.updateProfile}$ids"),
        body: body, headers: requestHeaders);
  print("${AppConstants.updateProfile}$ids");
      log("requestHeaders ${requestHeaders}");
   
   
        var data = jsonDecode(res.body);
     
      if (res.statusCode == 200) {
       
        setState(() {
            driverProfileController.getDriverProfileCall();
         pref.setString("first_name", driverProfileController.driverFirstNameController.text);
          pref.setString("last_name", driverProfileController.driverLastNameController.text);
          showSnackBar(languages[choosenLanguage]['text_Congratulations'], data['message'],
            Colors.greenAccent);
            driverProfileController.isLoading.value=false;
          driverProfileController.getLoginData();
           Navigator.pop(context);
        });
        
 
      } else {
        setState(() {
          driverProfileController.isLoading.value=false;
           showSnackBar(languages[choosenLanguage]['text_Error'], data['message'],Colors.redAccent,);
        
      
        });
       
  
    }
   
  }

  
}
