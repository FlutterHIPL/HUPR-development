import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Screens/Driver_Details_Screens/document_screen.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/images.dart';

class MyPayoutInfoPage extends StatefulWidget {
  const MyPayoutInfoPage({super.key});

  @override
  State<MyPayoutInfoPage> createState() => _MyPayoutInfoPageState();
}

class _MyPayoutInfoPageState extends State<MyPayoutInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
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
                     padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 25),
                    child: Image.asset(Images.doumentsImages),
                  ),

                 
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
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Payout Information",
                  style: TextStyle(
                      color: blackTextColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0),
                ),
              
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    obscureText: true,
                    isTrue: true,
                    isPassword: true,
                    hintText: "Bank name",
                    onIconTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    obscureText: true,
                    isTrue: true,
                    isPassword: true,
                    hintText: "Bank routing number",
                    onIconTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    obscureText: true,
                    isTrue: true,
                    isPassword: true,
                    hintText: "Bank account number",
                    onIconTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: CustomTextField(
                    obscureText: true,
                    isTrue: true,
                    isPassword: true,
                    hintText: "SWIFT code",
                    onIconTap: () {},
                  ),
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomButton(
                      isVisible: true,
                      btnName: "Confirm",
                      onPressed: () {
                        Get.to(MyDocumentPage());
                      },
                    )),
                    SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
