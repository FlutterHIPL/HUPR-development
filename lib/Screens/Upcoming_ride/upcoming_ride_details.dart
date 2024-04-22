import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/homeController.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Screens/Home_Screens/home_screen.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';

import '../../language/translete.dart';

class UpcomingRideDetails extends StatefulWidget {
  var ridedata;
  UpcomingRideDetails({super.key, required this.ridedata});

  @override
  State<UpcomingRideDetails> createState() => _UpcomingRideDetailsState();
}

class _UpcomingRideDetailsState extends State<UpcomingRideDetails> {
 
  HomeController homeController = Get.put(HomeController());
  bool isLoding=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                      onTap: () {
                        dravier.clear();
                        Get.back();
                      },
                      child: SvgPicture.asset(Images.backIcon)),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 15),
                  child: Text(
                    languages[choosenLanguage]['text_Upcoming_Rides_Details'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          Color(0xff4692D7),
                          Color(0xff5F4FB2),
                          Color(0xff4692D7),
                          Color(0xff4692D7),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: SvgPicture.asset(Images.profileCircleIcon),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${widget.ridedata["user"]["first_name"]} ${widget.ridedata["user"]["last_name"]}",
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  languages[choosenLanguage]['text_Cash'],
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "${widget.ridedata["currency"]} ${double.parse(widget.ridedata["fare_price"].toString()).toStringAsFixed(0)}",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                              textAlign: TextAlign.start,
                            )
                          ]),
                    ),
                  ),
                  heightSpace15,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 3,
                        ),
                        SvgPicture.asset(Images.clockIcon),
                        widthSpace5,
                        Text(
                          languages[choosenLanguage]
                              ['text_Picking_up_the_rider'],
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            " ${widget.ridedata["pickup_time"]} ",
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: fillColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(
                                "${widget.ridedata["distance_km"]} KM",
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(Images.distanceTraveled,
                                  color: Color(0xff90A4BA)),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: fillColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Text(
                                "${widget.ridedata["duration_minutes"]} ${languages[choosenLanguage]['text_Minutes']}",
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(Images.clockIcon,
                                  color: Color(0xff90A4BA)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      decoration: BoxDecoration(color: fillColor),
                    ),
                  ),
                  heightSpace20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.circlePickupPointICon),
                       widthSpace10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              languages[choosenLanguage]['text_Pick-Up_Point'],
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              width: Get.width * 0.7,
                              child: Text(
                                "${widget.ridedata["pickup_location"]}",
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 5, bottom: 5),
                        child: SvgPicture.asset(Images.verticalIndicationbg),
                      )),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.circleDropPointIcon),
                       widthSpace10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              languages[choosenLanguage]['text_Drop_Off_Point'],
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              width: Get.width * 0.7,
                              child: Text(
                                "${widget.ridedata["dropoff_location"]}",
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                 heightSpace20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      decoration: BoxDecoration(color: fillColor),
                    ),
                  ),
                  heightSpace20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Text(
                          languages[choosenLanguage]['text_Preferences'],
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                          textAlign: TextAlign.start,
                        ),
                        Spacer(),
                        SvgPicture.asset(Images.printIcon),
                      widthSpace10,
                        SvgPicture.asset(Images.bagIcon),
                      ],
                    ),
                  ),

                  heightSpace20,


                  Container(
                      height: 53,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 2, color: outlineColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    
                    child: Container(
                          width: Get.width,
                          alignment: Alignment.center,
                          child: Text("We will notify you once the driver is assigned",
                           style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                              textAlign: TextAlign.start))),


                           heightSpace20,
                  // isLoding
                  //   ? CustomWidget()
                  //       .CustomButtonLoader(vertical: 20)
                  //   :
                  // Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 20, horizontal: 15),
                  //     child: CustomButton(
                  //       isVisible: true,
                  //       btnName: languages[choosenLanguage]
                  //           ['text_Accept_Order'],
                  //       onPressed: () {
                  //         isLoding=true;
                  //         if (homeController.isSwitch == true) {
                  //           setState(() {
                  //             homeController.AcceptedRideApi(
         
                  //                  "accepted", widget.ridedata["id"].toString());
                  //             box.write("dravier", widget.ridedata);
                             

                  //             Navigator.pop(context, true);

                  //           });
                  //         } else {
                  //           isLoding = false;
                  //         }
                  //       },
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
