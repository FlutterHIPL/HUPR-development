import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  var announcementsList = [];
  bool isLoading = false;
  var formatterDate = DateFormat('dd MMMM');
  var formatterTime = DateFormat('kk:mm');
  @override
  void initState() {
    super.initState();
  announscementApi();
    box.write("firebase", "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
         
      backgroundColor: whiteColor,
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 00),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(Images.backIcon)),
                    heightSpace20,
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 20, bottom: 20, top: 15),
                          child: Text(
                            languages[choosenLanguage]['text_Notifications'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          isLoading==true?Expanded(
            child: Container(
             
            alignment: Alignment.center,
              child: CircularProgressIndicator(),),
          ):announcementsList.length==0?
           noDataMethod():
          Flexible(
            child: ListView.builder(
              itemCount: announcementsList.length,
              itemBuilder: (BuildContext context, int index) {
                var items = announcementsList[index];
                   var formatterTime = DateFormat('hh:mm');
                          var formatterDay = DateFormat('EEE');
                          var data;
                          if(items['type'] == "notifications"){
                                    data=jsonDecode(items["notification_data"]);
                          }
         
               
                
                         DateTime  timestamp = DateTime.parse( items["created_at"].toString()).toLocal();
                         DateTime  istTime = timestamp.toUtc().add(Duration(hours: 5, minutes: 30));

                            var formatterDate = DateFormat('dd-MM-yyyy')
                                .parse(items["created_at"]);
                            var currentDate = DateFormat('dd-MM-yyyy')
                                .parse(DateTime.now().toString());

                return  GestureDetector(
                  onTap: ()  {   
                    if(items['type'] == "announcements"){
                    showDialogPopup(
                      items["announcement"]["title"].toString(),
                        items["announcement"]["description"].toString(),
                        items["created_at"].toString(),
                         "announcements",
                         ""
                         );
                    }else{
                       showDialogPopup(
                                   data["title"].toString(),
                                    data["description"]
                                        .toString(),
                                    items["created_at"]
                                        .toString(),
                                    "notifications",
                                    data["customer_name"].toString()
                                    );
                    }
                                     
                  },
                  child: Container(
                     //height: Get.height*0.11,
                    margin: EdgeInsets.only(bottom: 15, left: 12, right: 12),
                    
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: items['type'] == "announcements1"
                                      ? Color.fromARGB(255, 196, 180, 41)
                                      : appBackgroundColor),
                    padding: EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Container(
                                    alignment: Alignment.center,
                                    width: 39,
                                    height: 39,
                                 
                                    // decoration: BoxDecoration(
                                    //     shape: BoxShape.circle,
                                    //     border: Border.all(
                                    //         color: whiteColor, width: 1)),
                                    child: items['type'] == "announcements"? 
                                    SvgPicture.asset(Images.announcementsIcon,color: whiteColor,
                                              height: 28,
                                              width: 28,
                                            ):
                                    Image.asset(Images.notification,color: whiteColor,height: 28,width: 28,)
                                    
                                  ),
                                  widthSpace10,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: Get.width*0.6,
                                  child: Text( 
                                    items['type'] =="announcements" ?"${items["announcement"]["title"]}": data["title"],
                                    style:  TextStyle(
                                       color: whiteColor,
                                        fontWeight: FontWeight.w700, fontSize: 15,fontFamily: "Poppins"),
                                         maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                   width: Get.width * 0.13,
                                   alignment: Alignment.centerRight,
                                  child: Text(
                                             currentDate == formatterDate
                                                  ? "${formatterTime.format(istTime)}"
                                                  : "${formatterDay.format(istTime)}",
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  fontFamily: "Poppins"),
                                            ),
                                ),
                              ],
                            ),
                            heightSpace5,          
                             Container(
                                width: Get.width * 0.7,
                               child: Text(
                                         items['type'] ==
                                              "announcements" ? "${items["announcement"]["description"]}": "${data["description"]}",
                                          style: TextStyle(
                                             color: whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
                                               overflow: TextOverflow.ellipsis,
                                              fontFamily: "Poppins"),
                                              maxLines: 2,
                                        ),
                             ),
                          
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }


 
  showDialogPopup(var title, description,dateTime,type,name) {
      DateTime timestamp = DateTime.parse(dateTime) .toLocal();
       DateTime istTime = timestamp.toUtc().add(Duration(hours: 5, minutes: 30));
    return   showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.only(left: 15,right: 15),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
             shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              padding: EdgeInsets.only(bottom: 20,left: 15,top: 20,right: 15),
            child: Container(
              width: Get.width*0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Row(
                      children: [
                        // Container(
                        //   height: 20,width: 50,
                        //   child: SvgPicture.asset(Images.appLogo,fit: BoxFit.fill,)),
                        //   widthSpace10,
                        Text(
                          "${formatterDate.format(istTime)} ${formatterTime.format(istTime)}",
                          style: TextStyle(
                              color: blackTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontFamily: "Poppins"),
                        ),
                      ],
                    ),  
                    heightSpace10,
                  Text(
                      title,
                      style: TextStyle(
                          color: blackTextColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          fontFamily: "Poppins"),
                    ),
                  
                    heightSpace10,
                    Text(
                                      "${description}",
                                      style: TextStyle(
                                          color: hintTextColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          fontFamily: "Poppins"),
                                     
                                    ), 

                                     heightSpace10,
                    Text(
                      "${name}",
                      style: TextStyle(
                          color: hintTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: "Poppins"),
                    ), 
                ],
              ),
            ),
            ),
          );
        });
  }

    


  noDataMethod() {
    return Column(
      children: [
        Stack(
         
          children: [
          
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: Get.height * 0.25),
                child: Image.asset(Images.announcements)),
            Container(
               margin: EdgeInsets.only(top: Get.height * 0.15),
              height: Get.height * 0.3,
              alignment: Alignment.topLeft,
              child: Transform.rotate(
                  angle: 3.13, // Rotate by 45 degrees (convert to radians)
                  child: Image.asset(Images.mask)),
            ),
    
            Container(
              width: Get.width,
              height: Get.height * 0.3,
              alignment: Alignment.topRight,
              child: Transform.rotate(
                  angle: 6.25, // Rotate by 45 degrees (convert to radians)
                  child: Image.asset(Images.mask)),
            ),
          
          ],
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            languages[choosenLanguage]['text_No_Notifications'],
            style: TextStyle(
                fontFamily: "Poppins",
                color: blackTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }


  announscementApi() async {
    setState(() {
      isLoading = true;
    });

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {"id": ids.toString()};



      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.announcementlist,
          data: body,
          authToken: authToken);

      if (response["status"] == true ) {
      
        setState(() {
          announcementsList.clear();
       announcementsList.addAll(response["data"]);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }






}
