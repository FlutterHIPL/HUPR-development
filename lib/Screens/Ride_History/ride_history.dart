
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hupr_texibooking/Screens/Ride_History/ride_details.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RideHistory extends StatefulWidget {
  const RideHistory({super.key});

  @override
  State<RideHistory> createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  int currentIndex = 0;
  bool isLoading = false;
  var completehistory =[];
  var cancelhistory = [];
  var formatterDate = DateFormat('dd MMMM');
  var formatterTime = DateFormat('kk:mm');


  @override
  void initState() {
    
    rideHistoryApi();
    cancelrideApi();
    super.initState();
  }


  


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                  languages[choosenLanguage] ['text_Ride_History'],
                  style: TextStyle(
                      color: blackTextColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
              Expanded(
                child: 
                  isLoading == true
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        )
                      :  completehistory.length==0? Container(
                              alignment: Alignment.center,
                              child: Text(
                                languages[choosenLanguage] ['text_Ride_History_Not_Found'],
                                  style: TextStyle(
                                      color: blackTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.start,
                                ),
                            ):
                      
                      
                         historyListShow(completehistory)
                 
                                 
                
              ),
            ],
          ),
        ));
  }


  rideHistoryApi() async {
    try{
    setState(() {
      isLoading = true;
    });
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids = pref.getInt("id");

    final body = {"driver_id": ids.toString()};

    var response = await ApiProvider().postRequest(
        apiUrl: AppConstants.ridehistory,
        data: body,
        authToken: authToken);

    if (response["status"] == true) {
      setState(() {
        for (int i = 0; i < response["data"].length; i++) {
          if (response["data"][i]["status"].toString() == "completed") {
            setState(() {
              completehistory.add(response["data"][i]);
            });
          }
        }
        log("completed ${completehistory}");
        isLoading = false;
      });
    }
    else{
       setState(() {
        isLoading = false;
      });
    }
    }catch(e){
       setState(() {
        isLoading = false;
      });
    }

  }


cancelrideApi() async {
  try{
final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids=pref.getInt("id");

final body = {"driver_id": ids.toString()};

var response=await ApiProvider().postRequest(apiUrl: AppConstants.cancelridehistory,data: body,authToken: authToken);

    if (response["status"] == true) {
      setState(() {
        for (int i = 0; i < response["data"].length; i++) {
         
            cancelhistory.add(response["data"][i]);
            log("cancelhistory ${cancelhistory}");
            isLoading = false;
         
        }
      });
    }
 }catch(e){
       setState(() {
        isLoading = false;
      });
    }

}


historyListShow( var datas){
  return  Container(
    margin: EdgeInsets.only(left: 15,right: 15,top: 15),
    child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: ListView.builder(
                                itemCount: datas.length,
                               // shrinkWrap: true,
                              
                                itemBuilder: (context, index) {
                                  var items = datas[index];
                          
                                  DateTime timestamp = DateTime.parse( datas[index] ["created_at"]) .toLocal();
                          
                         
                                  // Convert to Indian Standard Time (IST)
                                  DateTime istTime = timestamp.toUtc().add(Duration(hours: 5, minutes: 30));
                    
                                    
                                            DateTime timestamp1 =
                          DateTime.parse("${datas[index]["drop_off_date"]??"2024-03-20"}T${datas[index]["drop_off_time"]??"08:00:00"}.000000Z")
                              .toLocal();
                    
                      // Convert to Indian Standard Time (IST)
                      DateTime istTime1 = timestamp1
                          .toUtc()
                          .add(Duration(hours: 5, minutes: 30));
                          
                                  return GestureDetector(
                                    onTap: (){
                                      Get.to(()=>RideDetails(datas: datas[index]));
                                    },
                                    child: 
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 70,
                                              decoration:
                                                  const BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.only(
                                                        topLeft: Radius
                                                            .circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10)),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  stops: [
                                                    0.1,
                                                    0.5,
                                                    0.7,
                                                    0.9
                                                  ],
                                                  colors: [
                                                    Color(0xff5F4FB2),
                                                    Color(0xff5F4FB2),
                                                    Color(0xff5F4FB2),
                                                    Color(0xff4692D7),
                                                  ],
                                                ),
                                              ),
                                              child: 
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 15),
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          Images
                                                              .ridehistory),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                        if(items["user"]!=null)  Text(
                                                            "${items["user"]["first_name"]} ${items["user"]["last_name"]}",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    16.0),
                                                            textAlign:
                                                                TextAlign
                                                                    .start,
                                                          ),
                                                          Text(
                                                            "${formatterDate.format(istTime)} ${formatterTime.format(istTime)}",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    12.0),
                                                            textAlign:
                                                                TextAlign
                                                                    .start,
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "${items["currency"]} ${items["fare_price"]}",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    20.0),
                                                            textAlign:
                                                                TextAlign
                                                                    .start,
                                                          ),
                                                        if (currentIndex == 0)   Text(
                                                            "${items["transaction"]==null?"":items["transaction"]["type"]=="cash"?"Cash":"Online"}",
                                                            style: TextStyle(
                                                                color:
                                                                    whiteColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    12.0),
                                                            textAlign:
                                                                TextAlign
                                                                    .start,
                                                          ),
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                          
                                          
                                            ),
                                            heightSpace20,
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(Images
                                                      .circlePickupPointICon),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                     width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          languages[choosenLanguage] ['text_Pick-Up_Point'],
                                                          style: TextStyle(
                                                              color:
                                                                  blackTextColor,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                          "${items["pickup_location"]}",
                                                          style: TextStyle(
                                                              color:
                                                                  greyTextColor,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0,
                                                          top: 5,
                                                          bottom: 5),
                                                  child: SvgPicture.asset(Images
                                                      .verticalIndicationbg),
                                                )),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(Images
                                                      .circleDropPointIcon),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width *
                                                        0.7,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              languages[choosenLanguage] ['text_Drop_Off_Point'],
                                                              style: TextStyle(
                                                                  color:
                                                                      blackTextColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      12.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                           if(currentIndex==0) 
                                                           Text(
                                                              "${formatterTime.format(istTime1)}",
                                                              style: TextStyle(
                                                                  color:
                                                                      greyTextColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      12.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          "${items["dropoff_location"]}",
                                                          style: TextStyle(
                                                              color:
                                                                  greyTextColor,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  12.0),
                                                          textAlign:
                                                              TextAlign
                                                                  .start,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                       
                                    if (currentIndex == 1)   Container(
                                        width: Get.width,
                                         child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                              heightSpace20,
                                             Container(
                                              margin: EdgeInsets.only(left: 20),
                                               child: Text(languages[choosenLanguage] ['text_Reason'],
                                                                         style: TextStyle(
                                                                             color: blackTextColor,
                                                                             fontFamily: "Poppins",
                                                                             fontWeight: FontWeight.w600,
                                                                             fontSize: 12.0),
                                                                         textAlign: TextAlign.start,
                                                                       ),
                                             ),
                                       
                    
                                         
                                                                       Container(
                                                                          margin: EdgeInsets.only(left: 40),
                                                                         child: Text(
                                                                         "${datas[index]["booking_logs"][0]["reason"]}",
                                                                         style: TextStyle(
                                                                             color: greyTextColor,
                                                                             fontFamily: "Poppins",
                                                                             fontWeight: FontWeight.w400,
                                                                             fontSize: 12.0),
                                                                         textAlign: TextAlign.start,
                                                                                                                                                ),
                                                                       ),
                                           ],
                                         ),
                                       ),
                    
                      
                    
                                        
                                            heightSpace30
                                          ],
                                        ),
                                      ),
                                    ),
                               
                               
                                  );
                                },
                              ),
                  )
                ],
              ),
  );
             
             
}


}


















// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hupr_texibooking/Screens/Ride_History/ride_details.dart';
// import 'package:hupr_texibooking/Utils/app_constants.dart';
// import 'package:hupr_texibooking/Utils/colors.dart';
// import 'package:hupr_texibooking/Utils/costum_widget.dart';
// import 'package:hupr_texibooking/Utils/images.dart';
// import 'package:hupr_texibooking/api_provider.dart';
// import 'package:hupr_texibooking/language/language_option.dart';
// import 'package:hupr_texibooking/language/translete.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RideHistory extends StatefulWidget {
//   const RideHistory({super.key});

//   @override
//   State<RideHistory> createState() => _RideHistoryState();
// }

// class _RideHistoryState extends State<RideHistory> {
//   int currentIndex = 0;
//   bool isLoading = false;
//   var completehistory =[];
//   var cancelhistory = [];
//   var formatterDate = DateFormat('dd MMMM');
//   var formatterTime = DateFormat('kk:mm');


//   @override
//   void initState() {
    
//     rideHistoryApi();
//     cancelrideApi();
//     super.initState();
//   }


  


//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                Container(
//                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: SvgPicture.asset(Images.backIcon)),
//                 heightSpace30,
//                 Text(
//                   languages[choosenLanguage] ['text_Ride_History'],
//                   style: TextStyle(
//                       color: blackTextColor,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//               Expanded(
//                 child: DefaultTabController(
//                   length: 2,
//                   child: Scaffold(
//                        // backgroundColor: whiteColor,
//                         appBar:  PreferredSize(
//                          preferredSize: Size.fromHeight(40.0), // Set your custom height here
//                         child: Container(
//                     color: Colors.grey[300],
                    
//                     child: TabBar(
//                        isScrollable: false,
//                        indicatorWeight: 4.0,
//                       indicatorSize: TabBarIndicatorSize.label,
//                                        // indicatorSize: TabBarIndicatorSize.tab,
//                       indicatorColor: Colors.transparent,
//                       labelColor: Colors.white,
//                       unselectedLabelColor: Colors.white,
//                       indicator: BoxDecoration(
//                           borderRadius: BorderRadius.circular(50),
//                           color: appBackgroundColor),
//                      onTap: (index) {
//                         setState(() {
//                           currentIndex = index;
//                         });
//                       },
                    
                      
//                                         tabs: [
//                                           Container(
//                                             width: Get.width*0.5,
//                                             height: 40,
//                                             alignment: Alignment.center,
//                                            // padding: EdgeInsets.only(left: 20,right: 20),
//                                             child: Text(languages[choosenLanguage] ['text_Completed'],
//                                                                         style: TextStyle(
//                                                                             color: currentIndex == 0
//                                     ? Colors.white
//                                     : blackTextColor,
//                                                                             fontFamily: "Poppins",
//                                                                             fontWeight: FontWeight.w600,
//                                                                             fontSize: 22.0),
//                                                                         textAlign: TextAlign.start,
//                                             ),
//                                           ),
//                                          Container(
//                                            height: 40,
//                                           width: Get.width * 0.5,
//                           alignment: Alignment.center,
//                                            child: Text(languages[choosenLanguage] ['text_Cancelled'],
//                                                                        style: TextStyle(
//                                                                            color: currentIndex == 1
//                                     ? Colors.white
//                                     : blackTextColor,
//                                                                            fontFamily: "Poppins",
//                                                                            fontWeight: FontWeight.w600,
//                                                                            fontSize: 22.0),
//                                                                        textAlign: TextAlign.start,
//                                             ),
//                                          ),
//                                         ],
//                                       ),
//                         ),
//                                   ), 
                         
//                         body: TabBarView(
//                            physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     isLoading == true
//                         ? Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Container(
//                                 alignment: Alignment.center,
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ],
//                           )
//                         :  completehistory.length==0? Container(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   languages[choosenLanguage] ['text_Ride_History_Not_Found'],
//                                     style: TextStyle(
//                                         color: blackTextColor,
//                                         fontFamily: "Poppins",
//                                         fontWeight: FontWeight.w400,
//                                         fontSize: 16.0),
//                                     textAlign: TextAlign.start,
//                                   ),
//                               ):
                        
                        
//                            historyListShow(completehistory)
//                      ,  isLoading == true
//                         ? Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Container(
//                                 alignment: Alignment.center,
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ],
//                           )
//                         : historyListShow(cancelhistory)
                 
//                   ],
//                 ),   
                        
                
//                       ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }


//   rideHistoryApi() async {
//     try{
//     setState(() {
//       isLoading = true;
//     });
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     var authToken = pref.getString("token");
//     var ids = pref.getInt("id");

//     final body = {"driver_id": ids.toString()};

//     var response = await ApiProvider().postRequest(
//         apiUrl: AppConstants.ridehistory,
//         data: body,
//         authToken: authToken);

//     if (response["status"] == true) {
//       setState(() {
//         for (int i = 0; i < response["data"].length; i++) {
//           if (response["data"][i]["status"].toString() == "completed") {
//             setState(() {
//               completehistory.add(response["data"][i]);
//             });
//           }
//         }
//         log("completed ${completehistory}");
//         isLoading = false;
//       });
//     }
//     else{
//        setState(() {
//         isLoading = false;
//       });
//     }
//     }catch(e){
//        setState(() {
//         isLoading = false;
//       });
//     }

//   }


// cancelrideApi() async {
//   try{
// final SharedPreferences pref = await SharedPreferences.getInstance();
//     var authToken = pref.getString("token");
//     var ids=pref.getInt("id");

// final body = {"driver_id": ids.toString()};

// var response=await ApiProvider().postRequest(apiUrl: AppConstants.cancelridehistory,data: body,authToken: authToken);

//     if (response["status"] == true) {
//       setState(() {
//         for (int i = 0; i < response["data"].length; i++) {
         
//             cancelhistory.add(response["data"][i]);
//             log("cancelhistory ${cancelhistory}");
//             isLoading = false;
         
//         }
//       });
//     }
//  }catch(e){
//        setState(() {
//         isLoading = false;
//       });
//     }

// }


// historyListShow( var datas){
//   return  Container(
//     margin: EdgeInsets.only(left: 15,right: 15,top: 15),
//     child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Flexible(
//                     child: ListView.builder(
//                                 itemCount: datas.length,
//                                // shrinkWrap: true,
                              
//                                 itemBuilder: (context, index) {
//                                   var items = datas[index];
                          
//                                   DateTime timestamp = DateTime.parse( datas[index] ["created_at"]) .toLocal();
                          
                         
//                                   // Convert to Indian Standard Time (IST)
//                                   DateTime istTime = timestamp.toUtc().add(Duration(hours: 5, minutes: 30));
                    
                                    
//                                             DateTime timestamp1 =
//                           DateTime.parse("${datas[index]["drop_off_date"]??"2024-03-20"}T${datas[index]["drop_off_time"]??"08:00:00"}.000000Z")
//                               .toLocal();
                    
//                       // Convert to Indian Standard Time (IST)
//                       DateTime istTime1 = timestamp1
//                           .toUtc()
//                           .add(Duration(hours: 5, minutes: 30));
                          
//                                   return GestureDetector(
//                                     onTap: (){
//                                       Get.to(()=>RideDetails(datas: datas[index]));
//                                     },
//                                     child: 
//                                     Card(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Column(
                                          
//                                           children: [
//                                             Container(
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               height: 70,
//                                               decoration:
//                                                   const BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.only(
//                                                         topLeft: Radius
//                                                             .circular(10),
//                                                         topRight:
//                                                             Radius.circular(
//                                                                 10)),
//                                                 gradient: LinearGradient(
//                                                   begin: Alignment.topRight,
//                                                   end: Alignment.bottomLeft,
//                                                   stops: [
//                                                     0.1,
//                                                     0.5,
//                                                     0.7,
//                                                     0.9
//                                                   ],
//                                                   colors: [
//                                                     Color(0xff5F4FB2),
//                                                     Color(0xff5F4FB2),
//                                                     Color(0xff5F4FB2),
//                                                     Color(0xff4692D7),
//                                                   ],
//                                                 ),
//                                               ),
//                                               child: 
//                                               Padding(
//                                                 padding: const EdgeInsets
//                                                     .symmetric(
//                                                     horizontal: 15),
//                                                 child: Row(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                           Images
//                                                               .ridehistory),
//                                                       SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       Column(
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                         if(items["user"]!=null)  Text(
//                                                             "${items["user"]["first_name"]} ${items["user"]["last_name"]}",
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     whiteColor,
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 fontSize:
//                                                                     16.0),
//                                                             textAlign:
//                                                                 TextAlign
//                                                                     .start,
//                                                           ),
//                                                           Text(
//                                                             "${formatterDate.format(istTime)} ${formatterTime.format(istTime)}",
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     whiteColor,
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontSize:
//                                                                     12.0),
//                                                             textAlign:
//                                                                 TextAlign
//                                                                     .start,
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Spacer(),
//                                                       Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Text(
//                                                             "${items["currency"]} ${items["fare_price"]}",
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     whiteColor,
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 fontSize:
//                                                                     20.0),
//                                                             textAlign:
//                                                                 TextAlign
//                                                                     .start,
//                                                           ),
//                                                         if (currentIndex == 0)   Text(
//                                                             "${items["transaction"]==null?"":items["transaction"]["type"]=="cash"?"Cash":"Online"}",
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     whiteColor,
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w400,
//                                                                 fontSize:
//                                                                     12.0),
//                                                             textAlign:
//                                                                 TextAlign
//                                                                     .start,
//                                                           ),
//                                                         ],
//                                                       )
//                                                     ]),
//                                               ),
                                          
                                          
//                                             ),
//                                             heightSpace20,
//                                             Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: Row(
//                                                 children: [
//                                                   SvgPicture.asset(Images
//                                                       .circlePickupPointICon),
//                                                   SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Container(
//                                                      width: MediaQuery.of(context)
//                                                 .size
//                                                 .width *
//                                             0.7,
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Text(
//                                                           languages[choosenLanguage] ['text_Pick-Up_Point'],
//                                                           style: TextStyle(
//                                                               color:
//                                                                   blackTextColor,
//                                                               fontFamily:
//                                                                   "Poppins",
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontSize: 12.0),
//                                                           textAlign:
//                                                               TextAlign.start,
//                                                         ),
//                                                         Text(
//                                                           "${items["pickup_location"]}",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   greyTextColor,
//                                                               fontFamily:
//                                                                   "Poppins",
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               fontSize: 12.0),
//                                                           textAlign:
//                                                               TextAlign.start,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             Align(
//                                                 alignment:
//                                                     Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 25.0,
//                                                           top: 5,
//                                                           bottom: 5),
//                                                   child: SvgPicture.asset(Images
//                                                       .verticalIndicationbg),
//                                                 )),
//                                             Padding(
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 10),
//                                               child: Row(
//                                                 children: [
//                                                   SvgPicture.asset(Images
//                                                       .circleDropPointIcon),
//                                                   SizedBox(
//                                                     width: 10,
//                                                   ),
//                                                   Container(
//                                                     width: MediaQuery.of(
//                                                                 context)
//                                                             .size
//                                                             .width *
//                                                         0.7,
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Text(
//                                                               languages[choosenLanguage] ['text_Drop_Off_Point'],
//                                                               style: TextStyle(
//                                                                   color:
//                                                                       blackTextColor,
//                                                                   fontFamily:
//                                                                       "Poppins",
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w600,
//                                                                   fontSize:
//                                                                       12.0),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .start,
//                                                             ),
//                                                            if(currentIndex==0) 
//                                                            Text(
//                                                               "${formatterTime.format(istTime1)}",
//                                                               style: TextStyle(
//                                                                   color:
//                                                                       greyTextColor,
//                                                                   fontFamily:
//                                                                       "Poppins",
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   fontSize:
//                                                                       12.0),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .start,
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         Text(
//                                                           "${items["dropoff_location"]}",
//                                                           style: TextStyle(
//                                                               color:
//                                                                   greyTextColor,
//                                                               fontFamily:
//                                                                   "Poppins",
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               fontSize:
//                                                                   12.0),
//                                                           textAlign:
//                                                               TextAlign
//                                                                   .start,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
                                       
//                                     if (currentIndex == 1)   Container(
//                                         width: Get.width,
//                                          child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                               heightSpace20,
//                                              Container(
//                                               margin: EdgeInsets.only(left: 20),
//                                                child: Text(languages[choosenLanguage] ['text_Reason'],
//                                                                          style: TextStyle(
//                                                                              color: blackTextColor,
//                                                                              fontFamily: "Poppins",
//                                                                              fontWeight: FontWeight.w600,
//                                                                              fontSize: 12.0),
//                                                                          textAlign: TextAlign.start,
//                                                                        ),
//                                              ),
                                       
                    
                                         
//                                                                        Container(
//                                                                           margin: EdgeInsets.only(left: 40),
//                                                                          child: Text(
//                                                                          "${datas[index]["booking_logs"][0]["reason"]}",
//                                                                          style: TextStyle(
//                                                                              color: greyTextColor,
//                                                                              fontFamily: "Poppins",
//                                                                              fontWeight: FontWeight.w400,
//                                                                              fontSize: 12.0),
//                                                                          textAlign: TextAlign.start,
//                                                                                                                                                 ),
//                                                                        ),
//                                            ],
//                                          ),
//                                        ),
                    
                      
                    
                                        
//                                             heightSpace30
//                                           ],
//                                         ),
//                                       ),
//                                     ),
                               
                               
//                                   );
//                                 },
//                               ),
//                   )
//                 ],
//               ),
//   );
             
             
// }


// }
