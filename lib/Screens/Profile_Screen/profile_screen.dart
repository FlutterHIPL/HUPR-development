import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Controller/driver_profile_controller.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/Payout_Methods/Payment_method.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/Payout_Methods/payout_methods.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/feedback_summary_screen.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/profile_info_screen.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyProfilePage extends StatefulWidget {
  var languageID;
  String driverName, mobileNumber,driverPP;
  MyProfilePage(
      {super.key,
      required this.languageID,
      required this.driverName,
      required this.mobileNumber,
      required this.driverPP});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  DriverProfileController controller1 = Get.put(DriverProfileController());



 

  @override
  void initState() {
    super.initState();
    controller1.getDriverProfileCall();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: 
        
                 GetBuilder<DriverAuthController>(
                builder: (controller) =>
                      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
                    return
                           SingleChildScrollView(
                          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Stack(
                                                                       fit: StackFit.loose,
                                                   // alignment: Alignment.bottomCenter,
                                                                       children: [
                                                                       Container(
                                                                             margin: EdgeInsets.only(bottom: 50),
                                                                             width: MediaQuery.of(context).size.width,
                                                                             height: 330,
                                                                             decoration: BoxDecoration(
                                                                                 image: DecorationImage(
                                                                                     image: AssetImage(Images.profileBackground),
                                                                                     fit: BoxFit.cover)),
                                                                             child: Column(
                                                                               // alignment: Alignment.bottomCenter,
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
                                                                                 Stack(
                                                                                   children: [
                                                                                     Align(
                                              //alignment: Alignment.bottomCenter,
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                height: 135,
                                                margin: EdgeInsets.only(
                                                    left: 30, right: 30, bottom: 50,top: 70),
                                                decoration: BoxDecoration(
                                                    color: whiteColor.withOpacity(0.8),
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      controller.driverName,
                                                      style: TextStyle(
                                                          color: appBackgroundColor,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '(${widget.languageID}) ${widget.mobileNumber}',
                                                      style: TextStyle(
                                                          color: greyTextColor,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                                                                     ),
                                             
                                              Align(
                                                                                  // alignment: Alignment.topCenter,
                                                                                   child: Container(
                                                                                   //  margin: EdgeInsets.only(top: 70),
                                                                                     decoration: BoxDecoration(
                                                border: Border.all(color:Color(0xfff6f6f6), width: 14),
                                                borderRadius: BorderRadius.circular(50)),
                                                                                     child: Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: whiteColor, width: 14),
                                                  borderRadius: BorderRadius.circular(50)),
                                              child: widget.driverPP == ""
                                                ? CircleAvatar(
                                                    backgroundColor: whiteColor,
                                                    radius: 26,
                                                    child:
                                                    Image.asset(Images.profileImage),
                                                    )
                                                : CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                       controller.driverPP,
                                                    ),
                                                  )
                                                                                     ),
                                                                                   ),
                                                                                 ),
                                                                              
                                                                                   ],
                                                                                 ),
                                                                               
                                                                              
                                                                               ],
                                                                             )),
                                             
                                                                         
                                                                        
                                                                         Container(
                                                                           margin: EdgeInsets.only(top: 300),
                                                                           child: Container(
                                                                               width: MediaQuery.of(context).size.width,
                                                                               height: 80,
                                                                               margin: EdgeInsets.symmetric(horizontal: 20),
                                                                               decoration: BoxDecoration(
                                                                                   color: whiteColor,
                                                                                   borderRadius: BorderRadius.circular(25),
                                                                                   border: Border.all(color: outlineColor, width: 2)),
                                                                               child: Container(
                                                                                 height: 70,
                                                                                 margin: EdgeInsets.all(8),
                                                                                 decoration: BoxDecoration(
                                                                                     color: whiteColor,
                                                                                     borderRadius: BorderRadius.circular(20),
                                                                                     border: Border.all(color: outlineColor, width: 2)),
                                                                                 child: Row(
                                                                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                                                   children: [
                                                                                     Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]['text_Total_rides'],
                                                  style: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(Images.totalRideIcon),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "${totalBookings()==""?0: totalBookings()}",
                                                      style: TextStyle(
                                                          color: greyTextColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18.0),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                                                                     ),
                                                                                     Container(
                                                width: 2,
                                                decoration: BoxDecoration(
                                                  color: outlineColor,
                                                )),
                                                                                     Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]['text_Distance_traveled'],
                                                  style: TextStyle(
                                                      color: hintTextColor,
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(Images.distanceTraveled),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "${totalDistance()==""?0: double.parse(totalDistance().toString()).toStringAsFixed(0)}",
                                                      style: TextStyle(
                                                          color: greyTextColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18.0),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                                                                     ),
                                                                                     Container(
                                                width: 2,
                                                decoration: BoxDecoration(
                                                  color: outlineColor,
                                                )),
                                                                                     GestureDetector(
                                              onTap: () {
                                              Get.to(()=>MyFeedbackSummaryPage());
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    languages[choosenLanguage]['text_Rating'],
                                                    style: TextStyle(
                                                        color: hintTextColor,
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 12.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(Images.starIcon),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "${starRating()=="" || starRating() == "null" ?0.0: double.parse(starRating().toString()).toStringAsFixed(1)}",
                                                        style: TextStyle(
                                                            color: greyTextColor,
                                                            fontFamily: "Poppins",
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 18.0),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      SvgPicture.asset(Images.arrowRightIcon),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                                                                     )
                                                                                   ],
                                                                                 ),
                                                                               )),
                                                                         ),
                                                   
                                                   
                                             
                                                                       Column(
                                                                       children: [
                                             
                                                   SizedBox(
                                                                       height: 390,
                                             ),
                                             Padding(
                                                                       padding:
                                                                           const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                                                       child: GestureDetector(
                                                                         onTap: () {
                                                                           Get.to(()=>MyProfileInfoPage());
                                                                         },
                                                                         child: Row(
                                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                           children: [
                                                                             Row(
                                                                               children: [
                                                                                 SvgPicture.asset(Images.profileInfoImage),
                                                                                 SizedBox(
                                                                                   width: 20,
                                                                                 ),
                                                                                 Text(
                                                                                  languages[choosenLanguage]['text_Profile_Info'],
                                                                                   style: TextStyle(
                                                                          color: blackTextColor,
                                                                          fontFamily: "Poppins",
                                                                          fontWeight: FontWeight.w500,
                                                                          fontSize: 16.0),
                                                                                   textAlign: TextAlign.center,
                                                                                 ),
                                                                               ],
                                                                             ),
                                                                             SvgPicture.asset(Images.arrowRightIcon)
                                                                           ],
                                                                         ),
                                                                       ),
                                             ),
                                             Padding(
                                                                       padding:
                                                                           const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                                                       child: GestureDetector(
                                                                        onTap: (){
                                                                          Get.to(()=>PayoutMethods());
                                                                        },
                                                                         child: Container(
                                                                          color: Colors.white,
                                                                           child: Row(
                                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                             children: [
                                                                               Row(
                                                                                 children: [
                                                                                   SvgPicture.asset(Images.payoutMethodsImage),
                                                                                   widthSpace20,
                                                                                   Text(
                                                                                    languages[choosenLanguage]['text_Payout_Methods'],
                                                                                     style: TextStyle(
                                                                                         color: blackTextColor,
                                                                                         fontFamily: "Poppins",
                                                                                         fontWeight: FontWeight.w500,
                                                                                         fontSize: 16.0),
                                                                                     textAlign: TextAlign.center,
                                                                                   ),
                                                                                 ],
                                                                               ),
                                                                               SvgPicture.asset(Images.arrowRightIcon)
                                                                             ],
                                                                           ),
                                                                         ),
                                                                       ),
                                             ),
                                            //  Padding(
                                            //                            padding:
                                            //                                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                            //                            child: GestureDetector(
                                            //                             onTap: (){
                                            //                                Get.to(()=>AddPaymentMethods());
                                            //                             },
                                            //                              child: Row(
                                            //                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //                                children: [
                                            //                                  Row(
                                            //                                    children: [
                                            //                                      SvgPicture.asset(Images.paymentMethodImage),
                                            //                                      widthSpace20,
                                            //                                      Text(
                                            //                                       languages[choosenLanguage]['text_Payment_Methods'],
                                            //                                        style: TextStyle(
                                            //                                            color: blackTextColor,
                                            //                                            fontFamily: "Poppins",
                                            //                                            fontWeight: FontWeight.w500,
                                            //                                            fontSize: 16.0),
                                            //                                        textAlign: TextAlign.center,
                                            //                                      ),
                                            //                                    ],
                                            //                                  ),
                                            //                                  SvgPicture.asset(Images.arrowRightIcon)
                                            //                                ],
                                            //                              ),
                                            //                            ),
                                            //  ),
                                            //  Padding(
                                            //                            padding:
                                            //                                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                                            //                            child: Row(
                                            //                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //                              children: [
                                            //                                Row(
                                            //                                  children: [
                                            //                                    SvgPicture.asset(Images.appSettingsImages),
                                            //                                    widthSpace20,
                                            //                                    Text(
                                            //                                     languages[choosenLanguage]['text_App_Settings'],
                                            //                                      style: TextStyle(
                                            //                                          color: blackTextColor,
                                            //                                          fontFamily: "Poppins",
                                            //                                          fontWeight: FontWeight.w500,
                                            //                                          fontSize: 16.0),
                                            //                                      textAlign: TextAlign.center,
                                            //                                    ),
                                            //                                  ],
                                            //                                ),
                                            //                                SvgPicture.asset(Images.arrowRightIcon)
                                            //                              ],
                                            //                            ),
                                            //  )
                                                                                    
                                                                       ],
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
    );
  }

 

}
