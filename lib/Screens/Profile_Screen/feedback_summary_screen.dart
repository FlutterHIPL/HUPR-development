import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

class MyFeedbackSummaryPage extends StatefulWidget {
  const MyFeedbackSummaryPage({super.key});

  @override
  State<MyFeedbackSummaryPage> createState() => _MyFeedbackSummaryPageState();
 }

class _MyFeedbackSummaryPageState extends State<MyFeedbackSummaryPage> {
double _volumeValue = 0;
  var feedbackList = [];
    var formatterDate = DateFormat('dd MMMM');
    var formatterTime = DateFormat('kk:mm');
  void onVolumeChanged(double value) {
    setState(() {
      _volumeValue = value;
    });
  }

    bool  isLoading = false;
  @override
  void initState() {
    super.initState();
     feedbackApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
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
            heightSpace10,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    languages[choosenLanguage]['text_Feedbacks_Summary'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
           
         
        
            
        SingleChildScrollView(
          child: Stack(
            children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: Get.height*0.3,
              width: Get.width,
              child: Transform.rotate(
                          angle: 4.64, // Rotate by 45 degrees (convert to radians)
                          child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(minimum: 0,
                          maximum: 5,
                          startAngle: 270,
                          endAngle: 100,
                          showLabels: false,
                          showTicks: false,
                          radiusFactor: 0.7,
                          axisLineStyle: AxisLineStyle(
                              cornerStyle: CornerStyle.bothFlat,
                              color: Colors.black12,
                              thickness: 13),
                          pointers: <GaugePointer>[
                            RangePointer(
                                value: _volumeValue,
                                cornerStyle: CornerStyle.bothFlat,
                                width: 13,
                                sizeUnit: GaugeSizeUnit.logicalPixel,
                                color:  greenColor,
                               ),
                            MarkerPointer(
                               value: _volumeValue,
                                enableDragging: true,
                              //  onValueChanged: onVolumeChanged,
                                markerHeight: 20,
                                markerWidth: 20,
                                markerType: MarkerType.circle,
                                color: Color(0xFFF8BBD0),
                                borderWidth: 2,
                                borderColor: Colors.white54)
                          ],
                      )
                    ]
                ),
              ),
            ),
         
                          Container(
                            margin: EdgeInsets.only(bottom: 30),
                            padding: EdgeInsets.only(left: 7,right: 7,top: 3,bottom: 3),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1,color: outlineColor),
                              borderRadius: BorderRadius.circular(5)
        
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              SvgPicture.asset(Images.starIcon),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "${_volumeValue.toStringAsFixed(1)}",
                                                                style: TextStyle(
                                                                    color: greyTextColor,
                                                                    fontFamily: "Poppins",
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 18.0),
                                                                textAlign: TextAlign.center,
                                                              ),
                                                             
                                                            ],
                                                          ),
                                    )
                                     
                                     
                                     
                                 
                                     
                                      ],
                                    ),
             Container(
                                margin: EdgeInsets.only(top:Get.height*0.2 ),
                               
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                  
                                                    ExpansionTile(
                                                        shape: Border(),
                                                        childrenPadding: EdgeInsets.symmetric(horizontal: 20.0),
                                                        title: Text(
                                                          languages[choosenLanguage]['text_Some_good_points_about_you'],
                                                          style: TextStyle(
                                    color: blackTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                                        ),
                                                        children: <Widget>[
                                                          Container(
                                  child: 
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      reverse: true,
                                      itemCount: feedbackList.length,
                                      itemBuilder: (context, index) {
                                         DateTime timestamp = DateTime.parse(
                                                feedbackList[index]["booking"]
                                                    ["created_at"])
                                            .toLocal();
                                    
                                        // Convert to Indian Standard Time (IST)
                                        DateTime istTime = timestamp
                                            .toUtc()
                                            .add(Duration(hours: 5, minutes: 30));
                                        return  feedbackList[index]["star_rating"]!=5?Container():
                                        
                                        Card(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 60,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topRight,
                                                          end: Alignment
                                                              .bottomLeft,
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
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
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
                                                                  Text(
                                                                    "${feedbackList[index]["customer"]["first_name"]} ${feedbackList[index]["customer"]["last_name"]}",
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
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                          Images
                                                                              .starIcon),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                        "${double.parse(feedbackList[index]["star_rating"].toString())}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                whiteColor,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontSize: 18.0),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              )
                                                            ]),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        heightSpace20,
                                                        Container(
                                                          width: Get.width,
                                                          child: Text(
                                                            "${feedbackList[index]["feedback"].toString()}",
                                                            style: TextStyle(
                                                                color:
                                                                    blackTextColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18.0),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    heightSpace20
                                                  ],
                                                ),
                                              )
                                      
                                      
                                       ;
                                      }),
                                                        
                                                        
                                                        
                                                          )
                                                        ] // Some list of List Tile's or widget of that kind,
                                                        ),
                                                    ExpansionTile(
                                                        shape: Border(),
                                                        childrenPadding:
                                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                        title: Text(
                                                          languages[choosenLanguage]['text_Some_earlier_reviews'],
                                                          style: TextStyle(
                                    color: blackTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                                                        ),
                                                        children: <Widget>[
                                                          Container(
                                                               // height: Get.height * 0.2,
                                  child:  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: feedbackList.length   ,
                                      reverse: true,
                                      itemBuilder: (context, index) {
                                         DateTime timestamp = DateTime.parse(
                                                feedbackList[index]["booking"]
                                                    ["created_at"])
                                            .toLocal();
                                    
                                        // Convert to Indian Standard Time (IST)
                                        DateTime istTime = timestamp
                                            .toUtc()
                                            .add(Duration(hours: 5, minutes: 30));
                                      //  if (index==4) {
                                        return index>4?Container(): 
                                        
                                        Card(
                                           color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    height: 60,
                                                    decoration:
                                                        const BoxDecoration(
                                                           color: Colors.white,
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
                                                                Text(
                                                                  "${feedbackList[index]["customer"]["first_name"]} ${feedbackList[index]["customer"]["last_name"]}",
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
                                                               Row(
                                                              mainAxisSize:
                                                                  MainAxisSize.min,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    Images
                                                                        .starIcon),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  "${double.parse(feedbackList[index]["star_rating"].toString())}",
                                                                  style: TextStyle(
                                                                      color:
                                                                          whiteColor,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          18.0),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                               
                                                              ],
                                                            )
                                                          ]),
                                                    ),
                                                  ),
                                                  
                                                  Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                     
                                                     heightSpace20,
                                                     Container(
                                                    width: Get.width,
                                                        
                                                        child: Text(
                                                                                                  "${feedbackList[index]["feedback"].toString()}",
                                                                                                  style: TextStyle(
                                                          color: blackTextColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 18.0),
                                                                                                  textAlign: TextAlign.center,
                                                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                              
                                                  heightSpace20
                                                ],
                                              ),
                                            )
                                      
                                      
                                       ;
                                     // }
                                      })
                                                        
                                        ,
                                                          )
                                                        ] // Some list of List Tile's or widget of that kind,
                                                        ),
                                       
                                  
                                    ],
                                   ),
                                ),
                              )  
                                 
                                 
            
            ],
          ),
        ),
        
        
              
          ],
        ),
      ),
    ));
  }




feedbackApi() async {
    isLoading = true;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids = pref.getInt("id");

    Map<String, String> requestHeaders = {
      //'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': 'en',
    };

    final body = {"driver_id": ids.toString()};
      log("rideHistoryApi ${body}");
    try {
      final res = await http.post(Uri.parse(AppConstants.feedback),
          body: body, headers: requestHeaders);

      var data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (data["status"] == true) {
         
          feedbackList.addAll(data["data"]);
          int sum=0;
          for(int i=0;i<data["data"].length;i++){
           setState(() {
          sum=sum+int.parse(data["data"][i]["star_rating"].toString());
       
             
            });

          }
           
          setState(() {
            var ddd= sum / int.parse(data["data"].length.toString());
             _volumeValue = double.parse(ddd.toString());
          });
        }
      } else if (res.statusCode == 500) {
        setState(() {
          isLoading = false;
          showSnackBar(languages[choosenLanguage]['text_Error'], data["error"].toString(), Colors.redAccent);
        });
      } else if (res.statusCode == 404) {
        setState(() {
          isLoading = false;
          showSnackBar(languages[choosenLanguage]['text_Error'], data["message"].toString(), Colors.redAccent);
        });
      } else {
        showSnackBar(languages[choosenLanguage]['text_Error'], res.statusCode.toString(), Colors.redAccent);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


}
