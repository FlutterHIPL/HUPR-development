import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/language_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_indecator_widget.dart';
import 'package:hupr_texibooking/Element/common_language_widget.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/signup_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyLanguagePage extends StatefulWidget {
  const MyLanguagePage({super.key});

  @override
  State<MyLanguagePage> createState() => _MyLanguagePageState();
}

class _MyLanguagePageState extends State<MyLanguagePage> {

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder<LanguageController>(
            init: LanguageController(),
            builder: (controller) => Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                      color: fillColor,
                      image: DecorationImage(
                          image: AssetImage(
                        Images.languageImage,
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=>MySignUpPage());
                      },
                      child: Text(
                        languages[choosenLanguage]['text_Skip'],
                        style: TextStyle(
                            color: appBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                heightSpace10,
                Text(
                  languages[choosenLanguage]['text_Select_Language']
               ,
                  style: TextStyle(
                      color: blackTextColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0),
                ),
                heightSpace10,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextFormField(
                      controller: _searchController,
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
                          hintText:  languages[choosenLanguage]
                              ['text_Search_for_language'],
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
                       
                      }),
                ),
                heightSpace10,
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
                                          .contains(_searchController.text
                                              .toLowerCase())
                                      ? CommonLanguage(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CommonIndicatorWidget(),
                        const SizedBox(
                          width: 5,
                        ),
                        CommonIndicatorWidget(),
                        const SizedBox(
                          width: 5,
                        ),
                        CommonRunningCarIndicatorWidget(),
                        const SizedBox(
                          width: 5,
                        ),
                        CommonIndicatorWidget()
                      ],
                    ),
                    CustomButton(
                      isVisible: false,
                      btnName: languages[choosenLanguage]
                              ['text_Next'],
                      onPressed: () {
                        Get.to(()=>MySignUpPage());
                      },
                    )
                  ],
                ),
                heightSpace20,
              ],
            ),
          ),
        )

     
        );
  }
}
