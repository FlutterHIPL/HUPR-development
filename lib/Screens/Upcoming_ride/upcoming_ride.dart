import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/homeController.dart';
import 'package:hupr_texibooking/Screens/Upcoming_ride/upcoming_ride_details.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingRide extends StatefulWidget {
  const UpcomingRide({super.key});

  @override
  State<UpcomingRide> createState() => _UpcomingRideState();
}

class _UpcomingRideState extends State<UpcomingRide> {

  var rideList=[];
  bool isLoading=false;
    HomeController homeController = Get.put(HomeController());

@override
  void initState() {
    super.initState();
  BookingsApi();
  }


  BookingsApi() async {
    isLoading=true;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    try{

      var response =await ApiProvider().getRequest1(apiUrl: AppConstants.getbooking,authToken:authToken);

    
      if(response["status"]==true){
        setState(() {
          
       rideList.clear();
       for (int x = 0; x < response["data"].length; x++) {
        if(response["data"][x]['pickup_time_indicator'].toString() == "greater"){
        setState(() {
        
        
           rideList.add(response["data"][x]);
        });
        }
       }
         isLoading = false;
    });

      }else{
        isLoading = false;
      }

    }catch(e){
       isLoading = false;
log("Responsecatch ${e.toString()}");
    }



  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Column(
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
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 15),
                  child: Text(
                    languages[choosenLanguage]['text_Upcoming_Rides'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
              
              Flexible(
                child: isLoading==true
                ? Expanded(
                           child: Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                        
                        )
                      : rideList.length==0? Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              languages[choosenLanguage]
                                  ['text_Upcoming_Rides_Not_Found'],
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                      )
                      :
                
                                   ListView.builder(
                                    physics: AlwaysScrollableScrollPhysics(),
                                        
                                        itemCount: rideList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return 
                                                rideList[index]["pickup_time_indicator"]=="less"?Container(): Container(
                                                width: Get.width*0.9,
                                                height: Get.height*0.19,
                                                margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                                               alignment: Alignment.center,
                                               
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: Get.width*0.72,
                                                         padding: EdgeInsets.only(
                                                            bottom: 13, top: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10)),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topRight,
                                                            end: Alignment
                                                                .bottomLeft,
                                                            stops: [
                                                              0.3,
                                                              0.8,
                                                            ],
                                                            colors: [
                                                              Color.fromARGB(255, 127, 108, 219),
                                                            Color.fromARGB(255, 100, 170, 235),
                                                            ],
                                                          ),
                                                        ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                           Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      Images
                                                                          .circlePickupPointICon,width: 30,height: 30,),
                                                                  widthSpace10,
                                                                  Column(
                                                                     mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        languages[choosenLanguage]['text_Pick-Up_Point'],
                                                                        style: TextStyle(
                                                                            color:
                                                                                whiteColor,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize:
                                                                                10.0),
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                      ),
                                                                      Container(
                                                                        width: Get
                                                                                .width *
                                                                            0.53,
                                                                        child:
                                                                            Text(
                                                                          "${rideList[index]["pickup_location"]}",
                                                                          style: TextStyle(
                                                                              color:
                                                                                  whiteColor,
                                                                              fontFamily:
                                                                                  "Poppins",
                                                                              fontWeight:
                                                                                  FontWeight.w300,
                                                                              fontSize: 10.0),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                             maxLines:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets.only(left:30.0,
                                                                          top: 4,
                                                                          bottom:4),
                                                                  child: SvgPicture.asset(Images.verticalIndicationbg),
                                                                )),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Row(
                                                                 mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  SvgPicture.asset(
                                                                      Images
                                                                          .circleDropPointIcon,
                                                                    width: 30,
                                                                    height: 30,
                                                                  ),
                                                                  widthSpace10,
                                                                  Column(
                                                                     mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        languages[ choosenLanguage]['text_Drop_Off_Point'],
                                                                        style: TextStyle( color: whiteColor,
                                                                            fontFamily:"Poppins",
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize:
                                                                                10.0),
                                                                        textAlign: TextAlign .start,
                                                                      ),
                                                                      Container(
                                                                        width: Get.width * 0.53,
                                                                        child: Text(
                                                                          "${rideList[index]["dropoff_location"]}",
                                                                          style: TextStyle(
                                                                              color:
                                                                                  whiteColor,
                                                                              fontFamily:
                                                                                  "Poppins",
                                                                              fontWeight:
                                                                                  FontWeight.w300,
                                                                              fontSize: 10.0),
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                              maxLines: 2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                                                                      
                                                            
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  Container(
                                                       padding: EdgeInsets.only(
                                                            bottom: 10, top: 5,right: 5),
                                                        width: Get.width * 0.2,
                                                         decoration: BoxDecoration(
                                                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular( 10)),
                                                          gradient:
                                                              // ignore: prefer_const_constructors
                                                              LinearGradient(
                                                            begin: Alignment .bottomRight,
                                                            end: Alignment .bottomLeft,
                                                            stops: [
                                                              0.3,
                                                              1.0,
                                                            ],
                                                            colors: [
                                                              Color.fromARGB(255, 100, 170, 235),
                                                              Color.fromARGB(255, 155, 141, 223),
                                                            ],
                                                          ),
                                                        ),
                                                        child: Column(
                                                           crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "${rideList[index]["currency"]} ${double.parse(rideList[index]["fare_price"].toString()).toStringAsFixed(0)} ",
                                                              style: TextStyle(
                                                                  color:
                                                                      whiteColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18.0),
                                                              textAlign: TextAlign
                                                                  .center,
                                                            ),
                                                            Text(
                                                              "${rideList[index]["distance_km"]} KM",
                                                              style: TextStyle(
                                                                  color:
                                                                      whiteColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 10.0),
                                                              textAlign: TextAlign
                                                                  .center,
                                                            ),
                                              
                                                heightSpace10,
                                                  GestureDetector(
                                                              onTap: () {
                                                                Get.to(()=>UpcomingRideDetails(ridedata: rideList[index]));
                                                              },
                                                    child: Container(
                                                      height: 30, width: 30,
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: whiteColor.withOpacity(0.5),
                                                                  borderRadius:
                                                                      BorderRadius.all(Radius.circular(50) ),
                                                              ),
                                                              child: Image.asset(Images.navigate_icon,color: Colors.white,),
                                                            ),
                                                  )  ],
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              );
                                        }),
                              
                              
              )
              
          ],
        ),
      ),
    );
  }
}