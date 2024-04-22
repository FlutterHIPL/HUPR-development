// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Controller/driver_profile_controller.dart';
import 'package:hupr_texibooking/Controller/homeController.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Screens/Announcements/announcement.dart';
import 'package:hupr_texibooking/Screens/Home_Screens/payment_succes.dart';
import 'package:hupr_texibooking/Screens/Side_Menu_Bar_Screen/side_menu_bar_screen.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:new_version_plus/new_version_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_action/slide_action.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DriverAuthController driverAuthController = Get.put(DriverAuthController());
  HomeController homeController = Get.put(HomeController());

  void getLoginData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    driverAuthController.countryCodeValues = preferences.getString("country_code") != null
        ? preferences.getString("country_code")!
        : "";
    driverAuthController.driverName = preferences.getString("first_name")! +
        " " +
        preferences.getString("last_name")!;
    driverAuthController.mobileNumber =
        preferences.getString("mobile_number") != null
            ? preferences.getString("mobile_number")!
            : "";

    driverAuthController.driverPP =
        preferences.getString("Driver_Image") != null
            ? preferences.getString("Driver_Image")!
            : "";
    driverAuthController.update();
  }

 
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();



  LatLng? _currentP;

  Position? _currentPosition;
 

  late CameraPosition currentPosition;
  Timer? _timer;
  var period = const Duration(seconds: 30);


  @override
  void initState() {
    super.initState();
  
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
          if (message.data["type"].toString() == "Announcement") {
          Get.to(() => Announcements());
        }
      }
    });

        homeController.BookingApi("0");
        homeController.wallatApi();

    currentPosition = const CameraPosition(
      target: LatLng(26.905344, 75.7387577),
      zoom: 14,
    );

    getLoginData();

    getUserCurrentLocation().then((value) async {
      setState(() {
        _currentPosition = value;
        homeController.values=value.latitude;
        homeController.values1=value.longitude;
         _currentP =
            LatLng(value.latitude, value.longitude);

             box.write("latitude", value.latitude);
            box.write("longitude", value.longitude);
  
      });
      // specified current users location
      currentPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 15,
      );
      
    
      final GoogleMapController controller = await _controller.future;
    
      controller.animateCamera(CameraUpdate.newCameraPosition(currentPosition));
      setState(() {});
    });

final newVersion = NewVersionPlus(
      iOSId: 'com.example.hupr_texibooking',
      androidId: 'com.example.hupr_texibooking',
    );
    basicStatusCheck(newVersion);
WidgetsBinding.instance.addObserver(this);
  }

  basicStatusCheck(NewVersionPlus newVersion) async {
   
   
    // final version = await newVersion.getVersionStatus();
    // if (version != null) {
      box.write("appVersion", "1.0.0");
   // }
  }


   @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        log('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        log('appLifeCycleState resumed');
        _timer = Timer.periodic(period, (arg) {
          setState(() {
           
          
            log('appLifeCycleState ${languageSelectcode.toString()}');
           
            if(homeController.isSwitch==true){
             
           homeController.BookingApi("1");
           // homeController.getCurrentPosition();
            }
          
          });
        });
        break;
      case AppLifecycleState.paused:
        log('appLifeCycleState paused');
        setState(() {
          _timer?.cancel();
        });
        break;
      case AppLifecycleState.detached:
        log('appLifeCycleState detached');
         setState(() {
          _timer?.cancel();
        });
        break;
        case AppLifecycleState.hidden:
         log('appLifeCycleState hidden');
        setState(() {
          _timer?.cancel();
        });
       
        break;
    
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


 

 
  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    // await Geolocator.requestPermission()
    //     .then((value) {})
    //     .onError((error, stackTrace) async {
    //  await Geolocator.requestPermission();
    //   print("Geolocator" + error.toString());
    // });
    return await Geolocator.getCurrentPosition();
  }

 

 

  getCurrentPosition() async {
    await Geolocator.getCurrentPosition().then((Position position) {
      setState(() => _currentPosition = position);
      setState(() {
        _currentP = LatLng(position.latitude, position.longitude);
        currentPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
        );
        homeController.values = position.latitude;
        homeController.values1 = position.longitude;
      });

      log("getCurrentPosition  $position");
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: MySideMenuDrawer(),
        body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) => Stack(
            children: [
              GoogleMap(
                mapType: mapType()==2 || mapType() == ""?MapType.normal: MapType.hybrid,
                initialCameraPosition: currentPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                
                },
                zoomControlsEnabled: false,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                rotateGesturesEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                compassEnabled: true,
                markers: Set.of(controller.markers),
                circles: Set.from([
                  if (homeController.values != "0.0" || homeController.values != "")
                    Circle(
                      circleId: CircleId("circle_1"),
                      center: LatLng(
                          homeController.values, homeController.values1), // Circle center (San Francisco, CA)
                      radius: 1000, // Radius in meters
                      fillColor: Colors.blue.withOpacity(0.2),
                      strokeWidth: 2,
                      strokeColor: Colors.blue,
                    ),
                ]),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(children: [
                      GestureDetector(
                          onTap: () {
                            controller.BookingApi("0");
                            scaffoldKey.currentState!.openDrawer();
                          },
                          child: SvgPicture.asset(Images.menuIcon)),
                      Expanded(
                        child: Text(
                          controller.isSwitch ? languages[choosenLanguage]['text_Online'] :languages[choosenLanguage]['text_Offline'],
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ),
                 
               
                 
                  Spacer(),
                  if (controller.confirmRide == false)
                    FirstPopup(controller.isSwitch),
                  if (controller.confirmRide == false)
                    controller.bookingList.length == 0
                        ? Container()
                        : Visibility(
                            visible: controller.userDetails == true
                                ? false
                                : controller.acceptOrderKey == true
                                    ? false
                                    : controller.isSwitch 
                                        ? true
                                        : false,
                     child: 
                            Container(
                            //  margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              height: Get.height * 0.6,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: controller.isLoading == true
                                  ? Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: appBackgroundColor),
                                      ),
                                    )
                                  : 
                                  
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.bookingList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return 
                                                controller.bookingList[index]
                                                        ["status"] ==
                                                    "completed"
                                            ? Container()


                                            : Container(
                                              width: Get.width*0.9,
                                              height: Get.height*0.19,
                                              margin: EdgeInsets.only(left: 15,right: 15,top: 15),
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
                                                                        "${controller.bookingList[index]["pickup_location"]}",
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
                                                                        "${controller.bookingList[index]["dropoff_location"]}",
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
                                                            "${controller.bookingList[index]["currency"]} ${double.parse(controller.bookingList[index]["fare_price"].toString()).toStringAsFixed(0)} ",
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
                                                            "${controller.bookingList[index]["distance_km"]} KM",
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
                                                              setState(() {
                                                                dravier
                                                                    .clear();
                                                                dravier.add(
                                                                    controller
                                                                            .bookingList[
                                                                        index]);
                                            
                                                                log("item ${controller.bookingList[index]}");
                                            
                                                                controller
                                                                        .userDetails =
                                                                    true;
                                                              });
                                            
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
                            
                            
                            ),
                        
                        
                        
                          ),
                  if (controller.confirmRide == false)
                    Visibility(
                      visible: controller.userDetails ? true : false,
                      child: dravier.length == 0
                          ? Container()
                          : 
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidget().CustomBack(onPressed: () {
                                  setState(() {
                                    controller.userDetails = false;
                                  });
                                }),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 15, top: 5),
                                  // padding: EdgeInsets.symmetric(vertical: 20),
                                  width: MediaQuery.of(context).size.width,
                                  // height: 430,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      color: whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: SvgPicture.asset(
                                                      Images.profileCircleIcon),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${dravier[0]["user"]["first_name"]} ${dravier[0]["user"]["last_name"]}",
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      languages[choosenLanguage]['text_Cash'],
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontFamily: "Poppins",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                dravier != 0
                                                    ? Text(
                                                        "${dravier[0]["currency"]} ${double.parse(dravier[0]["fare_price"].toString()).toStringAsFixed(0)}",
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20.0),
                                                        textAlign:
                                                            TextAlign.start,
                                                      )
                                                    : Text(
                                                        "",
                                                        style: TextStyle(
                                                            color: whiteColor,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20.0),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: whiteColor,
                                                  border: Border.all(
                                                      color: fillColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${dravier[0]["distance_km"]} KM",
                                                    style: TextStyle(
                                                        color: greyTextColor,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  SvgPicture.asset(
                                                      Images.distanceTraveled,
                                                      color: Color(0xff90A4BA)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: whiteColor,
                                                  border: Border.all(
                                                      color: fillColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${dravier[0]["duration_minutes"]} ${languages[choosenLanguage]['text_Minutes']}",
                                                    style: TextStyle(
                                                        color: greyTextColor,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14.0),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  SvgPicture.asset(
                                                      Images.clockIcon,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          height: 2,
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: fillColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                Images.circlePickupPointICon),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]['text_Pick-Up_Point'],
                                                  style: TextStyle(
                                                      color: blackTextColor,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Container(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "${dravier[0]["pickup_location"]}",
                                                    style: TextStyle(
                                                        color: greyTextColor,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                            child: SvgPicture.asset(
                                                Images.verticalIndicationbg),
                                          )),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                Images.circleDropPointIcon),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  languages[choosenLanguage]['text_Drop_Off_Point'],
                                                  style: TextStyle(
                                                      color: blackTextColor,
                                                      fontFamily: "Poppins",
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Container(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "${dravier[0]["dropoff_location"]}",
                                                    style: TextStyle(
                                                        color: greyTextColor,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Container(
                                          height: 2,
                                          width: double.infinity,
                                          decoration:
                                              BoxDecoration(color: fillColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
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
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SvgPicture.asset(Images.bagIcon),
                                          ],
                                        ),
                                      ),

                                      controller.isStatusLoding
                                          ? CustomWidget()
                                              .CustomButtonLoader(vertical: 20)
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 15),
                                              child: CustomButton(
                                                isVisible: true,
                                                btnName: languages[choosenLanguage]['text_Accept_Order'],
                                                onPressed: () {
                                                  setState(() {
                                                  
                                                    //      showDialog(
                                                    //   context: context,
                                                    //   builder: (context) =>WebViewMapScreen(),
                                                    // );

                                                    controller.AcceptedRideApi(
                                                        "accepted",
                                                        dravier[0]["id"]
                                                            .toString());

                                                            box.write("dravier", dravier);
                                                  });
                                                },
                                              )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                   
                   
                    ),
                  Visibility(
                    visible: controller.acceptOrderKey == true ? true : false,
                    // visible: isRide ? true : false,
                    child: dravier.length == 0
                        ? Container()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    controller.confirmRide == false
                                        ? MainAxisAlignment.spaceBetween
                                        : MainAxisAlignment.end,
                                children: [
                                  controller.confirmRide == false ||
                                          controller.acceptOrderKey == true
                                      ? Container()
                                      : CustomWidget().CustomBack(
                                          onPressed: () {
                                          setState(() {
                                            controller.acceptOrderKey = false;
                                            controller.userDetails = true;
                                          });
                                        }),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        getCurrentPosition();
                                        if (controller.confirmRide == true) {
                                          _launchUrl(
                                              true,
                                              double.parse(dravier[0]
                                                      ["pickup_latitude"]
                                                  .toString()),
                                              double.parse(dravier[0]
                                                      ["pickup_longitude"]
                                                  .toString()),
                                              double.parse(dravier[0]
                                                      ["dropoff_latitude"]
                                                  .toString()),
                                              double.parse(dravier[0]
                                                      ["dropoff_longitude"]
                                                  .toString()));
                                                  if (homeController.ridestartstatus==false) {
                                                     homeController.ridestartApi();
                                                  }
                                               
                                        } else {
                                          _launchUrl(
                                              true,
                                              _currentPosition!.latitude,
                                              _currentPosition!.longitude,
                                              double.parse(dravier[0]
                                                      ["pickup_latitude"]
                                                  .toString()),
                                              double.parse(dravier[0]
                                                      ["pickup_longitude"]
                                                  .toString()));

                                                // homeController.ridearrivalApi();
                                        }
                                      },
                                      child: Container(
                                        width: 134,
                                        height: 45,
                                        margin: EdgeInsets.only(right: 15),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: appBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 2),
                                                child: SvgPicture.asset(
                                                    Images.Navigate),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                languages[choosenLanguage]
                                                    ['text_Navigate'],
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.start,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              heightSpace10,
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: darkAppBackgroundColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        height: 11,
                                      ),
                                  
                                      Container(
                                        // alignment: Alignment.center,
                                        // margin: EdgeInsets.only(top: 3),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                  color: whiteColor,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Spacer(),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 2),
                                              decoration: BoxDecoration(
                                                  color: whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12)),
                                              child: Text(
                                                " ${dravier[0]["pickup_time"]} ",
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
                                        height: 11,
                                      ),
                                  
                                      SingleChildScrollView(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30))),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    height: 5,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: fillColor,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 16.0),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: fillColor),
                                                              color: whiteColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(8)),
                                                          child: SvgPicture.asset(
                                                              Images
                                                                  .profileCircleIcon),
                                                        ),
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
                                                              "${dravier[0]["user"]["first_name"]} ${dravier[0]["user"]["last_name"]}",
                                                              style: TextStyle(
                                                                  color:
                                                                      blackTextColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 16),
                                                              textAlign:
                                                                  TextAlign.start,
                                                            ),
                                                            Text(
                                                              "Economy",
                                                              style: TextStyle(
                                                                  color:
                                                                      blackTextColor,
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
                                                        Spacer(),
                                                        Spacer(),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              UrlLauncher.launch(
                                                                  "tel:${dravier[0]["user"]["country_code"]}${dravier[0]["user"]["mobile_number"]}");
                                                            },
                                                            child: SvgPicture.asset(
                                                                Images
                                                                    .contactIcon,width: 39,height: 39,)),
                                                      ]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          vertical: 11),
                                                  child: Container(
                                                    height: 1,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: fillColor),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 14),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(Images
                                                          .circlePickupPointICon),
                                                     widthSpace10,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            languages[choosenLanguage]
                                                        ['text_Pick-Up_Point'],
                                                            style: TextStyle(
                                                                color:
                                                                    blackTextColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Container(
                                                            width: Get.width * 0.78,
                                                            child: Text(
                                                              "${dravier[0]["pickup_location"]} ",
                                                              style: TextStyle(
                                                                  color:
                                                                      greyTextColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12),
                                                              textAlign:
                                                                  TextAlign.start,
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30.0,
                                                              top: 4,
                                                              bottom: 4),
                                                      child: SvgPicture.asset(Images
                                                          .verticalIndicationbg),
                                                    )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 14),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(Images
                                                          .circleDropPointIcon),
                                                      widthSpace10,
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            languages[choosenLanguage]
                                                        ['text_Drop_Off_Point'],
                                                            style: TextStyle(
                                                                color:
                                                                    blackTextColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 12),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Container(
                                                            width: Get.width * 0.78,
                                                            child: Text(
                                                              "${dravier[0]["dropoff_location"]} ",
                                                              style: TextStyle(
                                                                  color:
                                                                      greyTextColor,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 12),
                                                              textAlign:
                                                                  TextAlign.start,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                heightSpace5,
                                                Padding(
                                                  padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                                                  child: Container(
                                                   
                                                    padding: EdgeInsets.all(10),
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: fillColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15)),
                                                    child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            
                                                            decoration:
                                                                BoxDecoration(
                                                                    color:
                                                                        whiteColor,
                                                                 
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8)),
                                                            child: SvgPicture.asset(
                                                                Images.cashride),
                                                          ),
                                                          widthSpace10,
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                 languages[choosenLanguage]['text_Cash'],
                                                                style: TextStyle(
                                                                    color:
                                                                        blackTextColor,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize: 14),
                                                                textAlign:
                                                                    TextAlign.start,
                                                              ),
                                                              Text(
                                                                languages[choosenLanguage]['text_Ride_fee_hasn’t_been_paid_yet'],
                                                                style: TextStyle(
                                                                    color: redColor,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize: 12),
                                                                textAlign:
                                                                    TextAlign.start,
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            "${dravier[0]["currency"]} ${double.parse(dravier[0]["fare_price"].toString()).toStringAsFixed(0)}",
                                                            style: TextStyle(
                                                                color:
                                                                    appBackgroundColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w600,
                                                                fontSize: 14),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 15,
                                                      right: 15,
                                                      bottom: 15),
                                                  height: 1,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: fillColor),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(Images
                                                              .rideOptionIcon),
                                                          widthSpace10,
                                                          Text(
                                                             languages[choosenLanguage]['text_Ride_options'],
                                                            style: TextStyle(
                                                                color:
                                                                    appBackgroundColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                fontSize: 14),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              Images.rideSaftyIcon),
                                                         widthSpace10,
                                                          Text(
                                                             languages[choosenLanguage]['text_Ride_safety'],
                                                            style: TextStyle(
                                                                color:
                                                                    appBackgroundColor,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight.w400,
                                                                fontSize: 14),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                controller.confirmRide == true
                                                    ? controller.isStatusLoding
                                                        ? CustomWidget()
                                                            .CustomButtonLoader(
                                                                vertical: 19)
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 18,
                                                                    horizontal: 15),
                                                             child: CustomButton(
                                                              isVisible: true,
                                                              btnName:languages[choosenLanguage]['text_Complete_Drop'],
                                                              onPressed: () {
                                                                setState(() {
                                                                  controller.AcceptedRideApi(
                                                                      "completed",
                                                                      dravier[0]
                                                                              ["id"]
                                                                          .toString());
                                        
                                        
                                                                            showDialog(
                                                                      context:
                                                                          context,
                                                                      builder: (context) =>
                                                                          PaymentSuccess(
                                                                            currency:
                                                                                dravier[0]["currency"].toString(),
                                                                            amount:
                                                                                dravier[0]["fare_price"].toString(),
                                                                            name:
                                                                                "${dravier[0]["user"]["first_name"].toString()} ${dravier[0]["user"]["last_name"].toString()}",
                                                                            customer_id:
                                                                                dravier[0]["customer_id"].toString(),
                                                                            booking_id:
                                                                                dravier[0]["id"].toString(),
                                                                                country_code:
                                                                                dravier[0]["user"]["country_code"].toString(),
                                                                                mobile_number:
                                                                                dravier[0]["user"]["mobile_number"].toString(),
                                                                          )).then(
                                                                      (value) {
                                                                    setState(() {
                                                                      if (value ==
                                                                          true) {
                                                                           box.write(
                                                                            "dravier",
                                                                            "");
                                                                        controller.confirmRide =
                                                                            false;
                                                                        controller
                                                                                .acceptOrderKey =
                                                                            false;
                                                                        controller
                                                                                .userDetails =
                                                                            false;
                                                                            setState(() {
                                                                              dravier.clear();
                                                                            });
                                                                      }
                                                                    });
                                                                  });
                                                                });
                                                              },
                                                            ))
                                                    : Container(
                                                        height: 54,
                                                        margin:
                                                            const EdgeInsets.only(
                                                                left: 16,right: 16,top: 17,bottom: 19),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                appBackgroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(10)),
                                                        child: SlideAction(
                                                          trackBuilder:
                                                              (context, state) {
                                                            return Container(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      left: 80),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                state.isPerformingAction
                                                                    ? languages[choosenLanguage]['text_Loading']
                                                                    : languages[choosenLanguage]['text_Slide_To_Confirm_Your_Arrival'],
                                                                style: TextStyle(
                                                                    color:
                                                                        whiteColor,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize: 16.0),
                                                                textAlign:
                                                                    TextAlign.start,
                                                              ),
                                                            );
                                                          },
                                                          thumbBuilder:
                                                              (context, state) {
                                                            return Center(
                                                                // Show loading indicator if async operation is being performed
                                                                child: state
                                                                        .isPerformingAction
                                                                    ? const CupertinoActivityIndicator(
                                                                        color: Colors
                                                                            .white,
                                                                      )
                                                                    : SvgPicture
                                                                        .asset(Images
                                                                            .rightArrowBoxIcon));
                                                          },
                                                          action: () async {
                                                            setState(() {
                                                              controller
                                                                  .AcceptedRideApi(
                                                                      "confirmed",
                                                                      dravier[0]
                                                                              ["id"]
                                                                          .toString());
                                                            });
                                                            // Async operation
                                                            await Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              setState(() {


                                                                
                                                                _launchUrl(
                                                                    true,
                                                                    double.parse(dravier[0]
                                                                            [
                                                                            "pickup_latitude"]
                                                                        .toString()),
                                                                    double.parse(dravier[
                                                                                0][
                                                                            "pickup_longitude"]
                                                                        .toString()),
                                                                    double.parse(dravier[
                                                                                0][
                                                                            "dropoff_latitude"]
                                                                        .toString()),
                                                                    double.parse(dravier[0]
                                                                            ["dropoff_longitude"]
                                                                        .toString()));
                                        
                                                                
                                                                if (homeController.ridestartstatus==false) {
                                                                  homeController.ridestartApi();
                                                                }
                                                                        
                                                              });
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.cancelController
                                                        .clear();
                                                    showAlertDialog(
                                                        context,
                                                        dravier[0]["id"]
                                                            .toString());
                                                  },
                                                  child: Container(
                                                      height: 53,
                                                      margin: EdgeInsets.only(
                                                          left: 16, right: 16),
                                                      decoration: BoxDecoration(
                                                        color: whiteColor,
                                                        shape: BoxShape.rectangle,
                                                        border: Border.all(
                                                            width: 2,
                                                            color: outlineColor),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                12),
                                                      ),
                                                      child: Container(
                                                        width: Get.width,
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          languages[choosenLanguage]['text_Cancel'],
                                                          style: TextStyle(
                                                              color: redColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Poppins'),
                                                        ),
                                                      )),
                                                ),
                                                heightSpace20
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
               
               
               
               
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(


      bool isDir, double lat, double lon, double clat, double clon) async {
    String url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';

    if (isDir) {
      url =
          'https://www.google.com/maps/dir/?api=1&origin=$lat,$lon&destination=$clat,$clon';
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  FirstPopup(isSwitch) {
    return Visibility(
      // visible: true,
      visible: isSwitch ? false : true,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 155,
        decoration: BoxDecoration(
            color: darkAppBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.rideCarIcon),
                SizedBox(
                  width: 10,
                ),
                Text(
                  languages[choosenLanguage]['text_Get_online_to_start_receiving_requests'],
                  style: TextStyle(
                      color: whiteColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0),
                  textAlign: TextAlign.start,
                )
              ],
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Images.walletBalanceIcon),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        languages[choosenLanguage]
                            ['text_Your_Balance'],
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                        textAlign: TextAlign.start,
                      )
                    ],
                  ),
                  Text(
                    "EUR ${amount()==""?"0.0": amount()}",
                    style: TextStyle(
                        color: blackTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final formkey = GlobalKey<FormState>();
  showAlertDialog(BuildContext context, var driverId) {
    return 
    
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.all(10),
        title: Text(
          '  ${languages[choosenLanguage]['text_Cancelled_Reason']}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        content: Form(
          key: formkey,
          child: Container(
            width: Get.width*0.9,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              controller: homeController.cancelController,
              keyboardType: TextInputType.multiline,
              maxLines: 30,
              minLines: 4,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: appBackgroundColor, width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: outlineColor, width: 2.0),
                ),
                hintText: languages[choosenLanguage]['text_Enter_reason'],
                hintStyle: TextStyle(
                  fontSize: 14,
                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return languages[choosenLanguage]['text_Cancel_reason_is_required'];
                }
                return null;
              },
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  height: 40,
                  width: Get.width * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    languages[choosenLanguage]['text_Cancel'],
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (formkey.currentState!.validate()) {
                    homeController.AcceptedRideApi("cancelled", driverId);
                    Navigator.pop(context, true);
                  }
                },
                child: Container(
                  height: 40,
                  width: Get.width * 0.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: appBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    languages[choosenLanguage]['text_Ok'],
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
