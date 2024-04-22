// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hupr_texibooking/Screens/Ride_History/report_issue.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:intl/intl.dart';

class RideDetails extends StatefulWidget {
  var datas;
   RideDetails({super.key,required this.datas});

  @override
  State<RideDetails> createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {

    var formatterDate = DateFormat('dd MMMM');
  var formatterTime = DateFormat('kk:mm');


  CustomInfoWindowController customInfoWindowController =CustomInfoWindowController();
  CustomInfoWindowController customInfoWindowController1 =
      CustomInfoWindowController();





 
 
  @override
  Widget build(BuildContext context) {

    log("Pawan ${widget.datas}");
       DateTime timestamp = DateTime.parse(widget.datas["created_at"]).toLocal();
   // Convert to Indian Standard Time (IST)
    DateTime istTime = timestamp.toUtc().add(Duration(hours: 5, minutes: 30));
    return SafeArea(
      child: Scaffold(
        body:Container(
           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(Images.backIcon)),
              heightSpace30,
              Text(
                languages[choosenLanguage] ['text_Ride_Details'],
                style: TextStyle(
                    color: blackTextColor,
                    fontSize: 22,
                     fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
              heightSpace20,
              Container(
                height: 368,
                child: 
              Stack(
                children: [
                  GoogleMap(
                    gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                            mapType: mapType() == 2 || mapType() == "" ? MapType.normal : MapType.hybrid,
                           
                            initialCameraPosition: CameraPosition(
                          target: LatLng(
                            double.parse(
                                widget.datas["pickup_latitude"].toString()), double.parse(
                                widget.datas["pickup_longitude"].toString())),
                          zoom: 14,
                        ),
                         onTap: (position) {

                        customInfoWindowController.hideInfoWindow!();
                         customInfoWindowController1.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        customInfoWindowController.onCameraMove!();
                          customInfoWindowController1.onCameraMove!();
                      },
                      onMapCreated: (GoogleMapController controller) async {
                        customInfoWindowController.googleMapController =
                            controller;
                            customInfoWindowController1.googleMapController =
                            controller;
                      },
                           zoomControlsEnabled: false,
                           myLocationButtonEnabled: false,
                           myLocationEnabled: false,
                           mapToolbarEnabled: false,
                           tiltGesturesEnabled: false,
                            compassEnabled: false,     
                          markers: <Marker>{
                            Marker(
                          markerId: MarkerId("1"),
                          position: LatLng(
                              double.parse( widget.datas["pickup_latitude"].toString()),
                              double.parse( widget.datas["pickup_longitude"].toString())),
                          onTap: () {
                            customInfoWindowController.addInfoWindow!(
                              Stack(
                                children: [
                                  Container(
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.6,
                                     padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.pickup),
                                        widthSpace10,
                                        Column(
                                          children: [
                                             Container(
                                              width: Get.width * 0.4,
                                              child: Text(
                                                "Pick-Up Point",
                                                style: TextStyle(
                                                    color: blackTextColor,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.4,
                                              child: Text(
                                                "${widget.datas["pickup_location"].toString()}",
                                                style: TextStyle(
                                                    color: blackTextColor,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  
                                  ),
                                Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 20,
                                      child: Image.asset(
                                        Images.triangle,
                                        height: 15,
                                        width: 15,
                                        fit: BoxFit.fill,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                
                                ],
                              ),
                              LatLng(
                                  double.parse(widget.datas["pickup_latitude"]
                                      .toString()),
                                  double.parse(widget.datas["pickup_longitude"]
                                      .toString())),
                            );
                          },
                        ),
                         
                          Marker(
                          markerId: MarkerId("2"),
                          position:  LatLng(
                              double.parse(
                                  widget.datas["dropoff_latitude"].toString()),
                              double.parse(widget.datas["dropoff_longitude"]
                                  .toString())),
                          onTap: () {
                            customInfoWindowController1.addInfoWindow!(
                              Stack(
                              
                                children: [
                                
                                  Container(
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.6,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                     color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.drop),
                                        widthSpace10,
                                        Column(
                                          children: [
                                             Container(
                                              width: Get.width * 0.4,
                                              child: Text(
                                                "Drop-Off Point",
                                                style: TextStyle(
                                                    color: blackTextColor,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.0),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                            Container(
                                               width: Get.width * 0.4,
                                              child: Text(
                                                widget.datas["dropoff_location"].toString(),
                                                style: TextStyle(
                                                    color: blackTextColor,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                               
                                Container(
                                  
                                   alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 20,
                                    child: Image.asset(
                                      Images.triangle,
                                      height: 15,
                                      width: 15,
                                      fit: BoxFit.fill,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                ],
                              ),
                              LatLng(
                                  double.parse(widget.datas["dropoff_latitude"]
                                      .toString()),
                                  double.parse(widget.datas["dropoff_longitude"]
                                      .toString())),
                            );
                          },
                        ),
                         
                         
                         
                         
                        },
                              
                  ),
                    CustomInfoWindow(
                      controller: customInfoWindowController,
                      height: Get.height * 0.1,
                      width: Get.width * 0.6,
                      offset: 30,
                    ),
                    CustomInfoWindow(
                      controller: customInfoWindowController1,
                      height: Get.height * 0.1,
                      width: Get.width * 0.6,
                      offset: 30,
                    ),
                ],
              ),
              
              ),
            
            heightSpace30,
              Container(
                height: 68,
                decoration: BoxDecoration(
                  color: outlineColor,
                  border: Border.all(width: 1,color: outlineColor),
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SvgPicture.asset(Images.ridehistory),
                  widthSpace10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     if(widget.datas["user"]!=null) Text(
                        "${widget.datas["user"]["first_name"]} ${widget.datas["user"]["last_name"]}",
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "${formatterDate.format(istTime)} ${formatterTime.format(istTime)}",
                        style: TextStyle(
                            color: hintTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.datas["currency"]} ${widget.datas["fare_price"]}",
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                        textAlign: TextAlign.start,
                      ),
                    if(widget.datas["status"] == "completed")  Text(
                        "${widget.datas["transaction"]==null?"":widget.datas["transaction"]["type"] == "cash" ? "Cash" : "Online"}",
                        style: TextStyle(
                            color: hintTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  )
                ]),
              ),
            
                               heightSpace20,                 
            Divider(height: 1,color: outlineColor,),
             heightSpace20,
              Text(
                 languages[choosenLanguage] ['text_Trip_Details'],
                style: TextStyle(
                    color: blackTextColor,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
            
            
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(Images.circlePickupPointICon),
                   widthSpace10,
                    Container(
                       width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languages[choosenLanguage] ['text_Pick-Up_Point'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "${widget.datas["pickup_location"]}",
                            style: TextStyle(
                                color: greyTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, top: 5, bottom: 5),
                    child: SvgPicture.asset(Images.verticalIndicationbg),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(Images.circleDropPointIcon),
                    widthSpace10,
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                languages[choosenLanguage] ['text_Drop_Off_Point'],
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                             if (widget.datas["booking_logs"][0]["reason"] ==
                                  null) Text(
                                "${formatterTime.format(istTime)}",
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Text(
                            "${widget.datas["dropoff_location"]}",
                            style: TextStyle(
                                color: greyTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
                                            
            
              heightSpace20,
              Divider(
                height: 1,
                color: outlineColor,
              ),
              heightSpace20,
                Text(
                  languages[choosenLanguage] ['text_Preferences'],
                style: TextStyle(
                    color: blackTextColor,
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
              heightSpace20,
              Divider(
                height: 1,
                color: outlineColor,
              ),
              heightSpace20,
               GestureDetector(
                onTap: () {
                  Get.to(()=>ReportIssue());
            
                },
                child: Container(
                    height: 55,
                    width: Get.width,
                    alignment: Alignment.center,
                 
                    decoration: BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2, color: outlineColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      languages[choosenLanguage] ['text_Report_This_Issue'],
                          style: TextStyle(
                              color: redColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        )),
              ),
                                 
                                 
            
            ],),
          ),
        ) ,
        
        
        ));
  }
}

