import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Controller/language_controller.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Model/LanguageModel.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:hupr_texibooking/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonLanguage extends StatefulWidget {

  int index;
  int selectedValue;
  Data languageList;

  CommonLanguage(
      {super.key,
      required this.index,
      required this.selectedValue,
      required this.languageList});

  @override
  State<CommonLanguage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CommonLanguage> {
  DriverAuthController authController = Get.put(DriverAuthController());



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: GetBuilder<LanguageController>(
        builder: (controller) =>
        
         Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.selectedValue = widget.index;
                          authController.driverLanguageId.value =
                              widget.languageList.id!.toInt();
                              box.write("languageCode", widget.index);
                              if (controller.selectedValue==0) {
                                 languageSelect = "1";
                                 languageSelectcode="en";
                                   controller.changeLanguage("en");
                                    controller.update();
                                      if (DriverID() != "") setlanguageApi("en");
                              }
                              if (controller.selectedValue ==1) {
                                languageSelect="82";
                                languageSelectcode = "nl";
                            controller.changeLanguage("nl");
                             controller.update();
                            if (DriverID() != "") setlanguageApi("nl");
                          }
                            
                          controller.update();
                        });
                      },
                      child: controller.selectedValue == widget.index
                          ? SvgPicture.asset(Images.circleRightIcon)
                          : SvgPicture.asset(Images.langUnselectedIcon)),

                  widthSpace20,
                  Text(
                    widget.languageList.name!,
                    style: TextStyle(
                        color: blackTextColor,
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: dividerColor,
              thickness: 1,
            )
          ],
        ),
     
     
      ),
    );
  }

  setlanguageApi(var language) async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {
        "language":language.toString(),
        "user_id": ids.toString(),
      };

      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.setlanguage, data: body, authToken: authToken);
      print("walletlist ${response}");
      if (response["status"] == true) {
        showSnackBar(languages[choosenLanguage]['text_Success'],
            response["message"], Colors.greenAccent);
      
      } else {}
    } catch (e) {}
  }


}
