

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Controller/homeController.dart';
import 'package:hupr_texibooking/Screens/Announcements/announcement.dart';
import 'package:hupr_texibooking/Screens/Earnings_Screen/Earnings.dart';
import 'package:hupr_texibooking/Screens/Home_Screens/webview_map.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/profile_screen.dart';
import 'package:hupr_texibooking/Screens/Ride_History/ride_history.dart';
import 'package:hupr_texibooking/Screens/Settings_Screens/setting_screen.dart';
import 'package:hupr_texibooking/Screens/Upcoming_ride/upcoming_ride.dart';
import 'package:hupr_texibooking/Screens/Wallet/my_wallet.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MySideMenuDrawer extends StatefulWidget {
  MySideMenuDrawer({super.key});

  @override
  State<MySideMenuDrawer> createState() => _MySideMenuDrawerState();
}

class _MySideMenuDrawerState extends State<MySideMenuDrawer> {
  HomeController homeController = Get.put(HomeController());


@override
  void initState() {
    // TODO: implement initState
    super.initState();
     languageSelectcode = language() == "" ? "en" : language();
     print("Pawan ${language()}");
  }
 

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: const BoxDecoration(
                      color: Color(0xffF2F4F8),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
      child: Drawer(
       
        child: 
                  
                  GetBuilder<DriverAuthController>(
                builder: (controller) =>LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
                    return SingleChildScrollView(
                          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child:  
                         Column(
                                               children: [
                         Container(
                           
                           width: MediaQuery.of(context).size.width,
                           margin: const EdgeInsets.only(left: 1),
                           padding: const EdgeInsets.only(left: 20, top: 30, bottom: 30),
                           decoration: const BoxDecoration(
                               image: DecorationImage(
                                   image: AssetImage(Images.sideMenuBg),
                                   fit: BoxFit.cover)),
                           child: Stack(
                             alignment: Alignment.centerLeft,
                             children: [
                               Container(
                                 margin: const EdgeInsets.only(left: 60, right: 20),
                                 height: 70,
                                 width: 209,
                              
                                alignment: Alignment.center,
                                 decoration: BoxDecoration(
                                     color: lightBlueColor,
                                     borderRadius: const BorderRadius.only(
                                         topRight: Radius.circular(25),
                                         bottomRight: Radius.circular(25))),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       controller.driverName,
                                       style: TextStyle(
                                           color: blackTextColor,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w600),
                                     ),
                                     const SizedBox(
                                       height: 5,
                                     ),
                                     Text(
                                       '(${controller.countryCodeValues}) ${controller.mobileNumber}',
                                       style: TextStyle(
                                           color: greyTextColor,
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ],
                                 ),
                               ),
                               Container(
                                  width: 95,
                                   height: 95,
                                 decoration: BoxDecoration(
                                     border: Border.all(color: const Color(0xfff9f9f9), width: 14),
                                     borderRadius: BorderRadius.circular(50)),
                                 child: Container(
                                   width: 81,
                                   height: 81,
                                   decoration: BoxDecoration(
                                       border:
                                           Border.all(color: whiteColor, width: 14),
                                       borderRadius: BorderRadius.circular(50)),
                                   child: controller.driverPP == ""
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
                                         ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         heightSpace10,
                         Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                           height: 50,
                           padding: const EdgeInsets.only(left: 15,right: 15),
                           decoration: BoxDecoration(
                               color: lightBlueColor,
                               borderRadius: BorderRadius.circular(10)),
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                   homeController.isSwitch ? "Online" : "Offline",
                                   style: TextStyle(
                                       color: blackTextColor,
                                       fontFamily: "Poppins",
                                       fontWeight: FontWeight.w500,
                                       fontSize: 18.0),
                                   textAlign: TextAlign.start,
                                 ),
                                 FlutterSwitch(
                                   width: 55.0,
                                   height: 28.0,
                                   value: homeController.isSwitch,
                                   inactiveColor: Colors.white,
                                   activeColor: greenColor,
                                   activeToggleColor: lightBlueColor,
                                   toggleColor: lightBlueColor,
                                   onToggle: (value) {
                                     setState(() {
                                      homeController.driverStatusApi(value==true?"online":"offline");
                                       homeController.isSwitch = value;
                                       homeController.acceptOrderKey=false;
                                        homeController.userDetails=false;
                                        box.write("SwitchValues", homeController.isSwitch);
                                        if(value==true){

                                          print("object  ${rideaccept().toString()}");
                                        //  homeController.acceptOrderKey =
                                        //       rideaccept().toString() == ""
                                        //           ? false
                                        //           : rideaccept().toString() ==
                                        //                   "false"
                                        //               ? false
                                        //               : true;
                                        //                print(
                                        //         "object11  ${homeController.acceptOrderKey}");
                                        }else{
                                           homeController.markers.clear();
                                        }
                                         Get.back();
                                     
                                       homeController.update();
                                     });
                                   },
                                 ),
                               ]),
                         ),
                         heightSpace10,
                        
                         info(
                                title: languages[choosenLanguage]
                                    ['text_Earnings'],
                                images: Images.earningsIcon,
                                action: () {
                                  Get.back();
                                  Get.to(() => const Earnings());
                                }),
                         
                        info(
                                title: languages[choosenLanguage]
                                    ['text_Profile'],
                                images: Images.profileIcon,
                                action: () {
                                  Get.back();
                                 Get.to(() => MyProfilePage(
                                        driverName: controller.driverName,
                                        mobileNumber: controller.mobileNumber,
                                        languageID:
                                            controller.countryCodeValues,
                                        driverPP: controller.driverPP,
                                      ));
                                }),

                                ListTile(
                                contentPadding: const EdgeInsets.only(left: 30),
                                onTap: () {
                                                            Get.back();
                                                            Get.to(() => const Announcements());
                                                          },
                                leading: Image.asset(
                                  Images.notification,color: Color(0xff5b758f),height: 25,width: 26,
                                ),
                                title: Text(languages[choosenLanguage]
                                    ['text_Notifications'], style: TextStyle(
                                                        color: blackTextColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "Roboto",
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                dense: true,
                              ),
                        // info(
                        //         title: languages[choosenLanguage]
                        //             ['text_Notifications'],
                        //         images: Images.announcementsIcon,
                        //         action: () {
                        //           Get.back();
                        //           Get.to(() => const Announcements());
                        //         }),
                            info(
                                title: languages[choosenLanguage]
                                    ['text_Wallet'],
                                images: Images.walletIcon,
                                action: () {
                                  Get.back();
                                   Get.to(() => const MyWallet());
                                }),
                         info(
                                title: languages[choosenLanguage]
                                    ['text_Upcoming_Rides'],
                                images: Images.upcoming_ride,
                                action: () {
                                  Get.back();
                                 
                                 Get.to(() => const UpcomingRide());
                                }),
                              info(
                                title: languages[choosenLanguage]
                                    ['text_Ride_History'],
                                images: Images.rideHistoryIcon,
                                action: () {
                                  Get.back();
                                 Get.to(() => const RideHistory());
                                }),

                            info(
                                title: languages[choosenLanguage]
                                    ['text_Settings'],
                                images: Images.settingIcon,
                                action: () {
                                  Get.back();
                                   Get.to(() => const MySettingPage());
                                }),

                               info(
                                title: languages[choosenLanguage]
                                    ['text_Logout'],
                                images: Images.logoutIcon,
                                action: () {
                                  Get.back();
                                 showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        //   insetPadding: EdgeInsets.zero,
                                        // contentPadding: EdgeInsets.zero,
                                        title: Text(
                                               languages[choosenLanguage]
                                                   ['text_Are_you_sure'],
                                               style: const TextStyle(
                                                 fontSize: 20,
                                                 fontWeight: FontWeight.bold,
                                               )),
                                        content: Text(
                                            languages[choosenLanguage]
                                                ['text_Do_you_want_to_Logout'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                            )),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text(
                                                languages[choosenLanguage]
                                                    ['text_No'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: appBackgroundColor)),
                                            onPressed: () => Get.back(),
                                          ),
                                          TextButton(
                                            child: Text(
                                                languages[choosenLanguage]
                                                    ['text_Yes'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: appBackgroundColor)),
                                            onPressed: () =>
                                                controller.logoutCall(),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }),
                        
                       
                                                        //  Spacer(),
                                                   
                                                         Expanded(
                          child: Container()),
                                                         // Expanded(child: Container()),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisSize: MainAxisSize.max,
                           children: [
                             ListTile(
                               contentPadding: const EdgeInsets.only(left: 30),
                               title: Text(
                                 '${languages[choosenLanguage]['text_App_Version']} - ${appVersion()}',
                                 style: TextStyle(
                                   color: appVersionTextColor,
                                   fontWeight: FontWeight.w400,
                                   fontFamily: "Roboto",
                                   fontSize: 16.0,
                                 ),
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
                )
              ),
           
      ),
    );
  }

  info({required title, required images, required action}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 30),
      onTap: action,
      leading: SvgPicture.asset(
        images,
      ),
      title: Text(title, style: TextStyle(
                               color: blackTextColor,
                               fontWeight: FontWeight.w500,
                               fontFamily: "Roboto",
                               fontSize: 16.0,
                             ),
                           ),
      dense: true,
    );
  }
}
