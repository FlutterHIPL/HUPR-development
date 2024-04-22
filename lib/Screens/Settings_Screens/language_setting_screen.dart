import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/language_controller.dart';
import 'package:hupr_texibooking/Element/common_language_widget.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyLanguageSettingPage extends StatefulWidget {
  const MyLanguageSettingPage({super.key});

  @override
  State<MyLanguageSettingPage> createState() => _MyLanguageSettingPageState();
}

class _MyLanguageSettingPageState extends State<MyLanguageSettingPage> {


    TextEditingController searchController = TextEditingController();
 @override
  Widget build(BuildContext context) {
   
    return  SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GetBuilder<LanguageController>(
            init: LanguageController(),
            builder: (controller) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(Images.backIcon)),
                  heightSpace20,
                  Row(
                    children: [
                      Text(
                        languages[choosenLanguage]['text_Language_Settings'],
                        style: TextStyle(
                            color: blackTextColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  heightSpace20,
          
                 TextFormField(
                      controller:searchController,
                      cursorColor: Colors.black,
                      autofocus: false,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF5F5FF),
                          // contentPadding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: outlineColor,
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: outlineColor,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: outlineColor,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: outlineColor,
                              )),
                          hintText: languages[choosenLanguage]['text_Search_for_language'],
                          errorStyle: TextStyle(height: 1),
                          hintStyle: TextStyle(
                              color: Color(0xff616065),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins"),
                          prefixIcon: Image.asset(
                            "assets/images/Search.png",
                            scale: 3,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: outlineColor,
                              ))),
                      onChanged: (value) {
                      setState(() {
                        
                      });
                      }),
                 heightSpace20,
                  Expanded(
                    child: Obx(
                      () => controller.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: appBackgroundColor,
                              ),
                            )
                          : controller.languageModel != null
                              ? ListView.builder(
                                  itemCount:
                                      controller.languageModel!.data!.length,
                                  itemBuilder: (context, index) {


                                    
                                    return controller
                                            .languageModel!.data![index].name!
                                            .toLowerCase()
                                            .contains( searchController.text
                                              .toLowerCase()
                                                )
                                        ? 
                                        CommonLanguage(
                                            selectedValue:
                                                controller.selectedValue,
                                            index: index,
                                            languageList: controller
                                                .languageModel!.data![index])
                                        : SizedBox();
                                  },
                                )
                              : SizedBox(),
                    ),
                  ),
                 
                ],
              ),
            ))),
    );
  }
}