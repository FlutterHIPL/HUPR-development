
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:ui' as ui;

class HomeController extends GetxController {
  final StreamController controller = StreamController();
  TextEditingController cancelController=TextEditingController();
  bool isSwitch = false;
  bool acceptOrderKey = false;
   bool userDetails = false;
  bool confirmRide = false;
  var bookingList = [];
  var isLoading = false;
  var isStatusLoding=false;
  double values = 0.0, values1 = 0.0;
  late SharedPreferences prefs;
  List<Marker> markers = <Marker>[];
  bool ridestartstatus=false;
  var box=GetStorage();

  @override
  void onInit() {
    super.onInit();
    if(dravierData()!=""){ 
      dravier.addAll(dravierData());
      confirmRide = rideconfirm().toString() == ""
          ? false
          : rideconfirm().toString() == "false"
              ? false
              : true;
    }
    else{

    }
      print("dravierData ${dravierData()}");
  
    isSwitch = SwitchValues().toString()==""?false:SwitchValues().toString()=="false"?false:true;
    print("SwitchValues ${SwitchValues()}");
  
   acceptOrderKey=rideaccept().toString()==""?false:rideaccept().toString() == "false"? false: true;
   print("rideaccept ${rideaccept()}");
  
  
  }


  @override
  void dispose() {
    super.dispose();

   
  }







  getCurrentPosition() async {
    await Geolocator.getCurrentPosition().then((Position position) {

       values = position.latitude;
        values1 = position.longitude;
      update();

    }).catchError((e) {
      debugPrint(e);
    });
  }
 


Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}
  Future BookingApi(var count) async {

      languageSelectcode = language() == "" ? "en" : language();
    if (count.toString()!="1") {
       isLoading = true;
    }
   
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/car.png', 200);


    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    };


    try {
           final res = await http.get(Uri.parse(AppConstants.getbooking),
          headers: requestHeaders);
           print("statusCode  :- ${res.statusCode}");
    print("BookingResponse  :- ${res.body}");
      var data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if(data["data"]!=null && data["data"].length != 0){

        bookingList.clear();
        markers.clear();
       
        var radius;
         for (int x = 0; x < data["data"].length; x++) {
    radius =calculateDistance(
              values, values1, double.parse(data["data"][x]['pickup_latitude'].toString()),
        double.parse(data["data"][x]['pickup_longitude'].toString()));
            update(); print("radius ${radius.toInt()}");

            if(data["data"][x]['pickup_time_indicator'].toString()=="less"){
        
      //  if(radius.toInt()<1){

           if (data["data"][x]['status'].toString() == "pending" ||
              data["data"][x]['status'].toString() == "cancelled"){
               
           
           
       bookingList.add(data["data"][x]); 
        print("statusCode1  :- ${bookingList.length}");
        update();
   
       if (isSwitch==true) {
         
       
             markers.add(Marker(
                markerId: MarkerId("Marker $x"),
                icon: BitmapDescriptor.fromBytes(markerIcon),
                position: LatLng(
                    double.parse(data["data"][x]['pickup_latitude'].toString()),
                    double.parse(
                        data["data"][x]['pickup_longitude'].toString())),
                infoWindow: InfoWindow(title: "Text$x")));
                 isLoading = false;
                 update();
                 }else{
                   markers.clear();
                    update();
                 }
       // }
              }
        }
        else {
              isLoading = false;
              update();
            }
      }
          isLoading = false;
          update();
          }
          else{
            bookingList.clear();
              markers.clear();
            isLoading = false;

          update();
          }
     
        isLoading = false;
        update();
      } else if (res.statusCode == 500) {
        isLoading = false;
        update();
        showSnackBar(languages[choosenLanguage]['text_Error'], data["error"].toString(), Colors.redAccent);
      } else if (res.statusCode == 401) {
        isLoading = false;
         update();
      } else {
        isLoading = false;
         update();
       // showSnackBar(languages[choosenLanguage]['text_Error'], res.statusCode.toString(), Colors.redAccent);
      }
    } catch (e) {
      isLoading = false;
       update();
    }
  }




  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

 

  AcceptedRideApi(String Status, String booking_id) async {
    isStatusLoding=true;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var driver_id = pref.getInt("id");


          final body;
          if (Status.toString() == "cancelled") {
              body = {
                "booking_id": booking_id.toString(),
                "driver_id": driver_id.toString(),
                "status": Status.toString(),
                "reason":cancelController.text.trim(),
              };
          }else{
            body = {
                "booking_id": booking_id.toString(),
                "driver_id": driver_id.toString(),
                "status": Status.toString(),
              };
          }
   
    print("bookingstatus ${body}");
    try {

    var response =await ApiProvider().postRequest1(apiUrl: AppConstants.bookingstatus,data: body,authToken: authToken);

    if(response["status"]==true){
        if(Status.toString()=="accepted"){
            acceptOrderKey = true;
            userDetails = false; 
            print("acceptOrderKey ${acceptOrderKey}");
            box.write("rideaccept", acceptOrderKey);
           
             update();
        }
         if (Status.toString() == "confirmed") {
            confirmRide = true;
            box.write("rideconfirm", confirmRide);
              update();
          }
         if (Status.toString() == "completed") {
           ridestartstatus=false;
           box.write("dravier", "");
          box.write("rideaccept", acceptOrderKey);
            BookingApi("0");
          //   confirmRide = false;
          //   acceptOrderKey = false;
          //  userDetails = false;
             update();
          }
           if (Status.toString() == "cancelled") {
          confirmRide = false;
          acceptOrderKey = false;
           box.write("dravier", "");
           box.write("rideaccept", acceptOrderKey);
          userDetails = false;
           update();

            BookingApi("0");
            update();
          }
         
          isStatusLoding = false;
         update();
           showSnackBar(languages[choosenLanguage]['text_Success'], response["message"].toString(), Colors.greenAccent);
     
        }
        else{
        isStatusLoding = false;
        update();
        showSnackBar(languages[choosenLanguage]['text_Error'],
            response["message"].toString(), Colors.redAccent);
     
          
        }  
    } catch (e) {
      isStatusLoding = false;
       update();
    showSnackBar(languages[choosenLanguage]['text_Error'], e.toString(), Colors.redAccent);
    }
  }


  wallatApi() async {
   
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {
        "user_id": ids.toString(),
      };
     
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.walletlist, data: body, authToken: authToken);
      print("walletlist ${response}");
      if (response["status"] == true) {
       box.write("amount", double.parse(response["currentBalance"].toString()).toStringAsFixed(2));
         update();
      
      } else {
       
      }
    } catch (e) {
     
    }
  }


 

   ridearrivalApi() async {
    try {
      print("riderequest");
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");
      var fcm_token = pref.getString("fcm_token");

      final body = {
        "driver_id": ids.toString(),
        "fcm_token": fcm_token.toString(),
      };
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.ridearrival, data: body, authToken: authToken);
    } catch (e) {}
  }

  ridestartApi() async {
    try {
      print("riderequest");
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");
      var fcm_token = pref.getString("fcm_token");

      final body = {
        "driver_id": ids.toString(),
        "fcm_token": fcm_token.toString(),
      };
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.ridestart, data: body, authToken: authToken);
          if(response['status']=true){
            ridestartstatus=true;
             update();
          }
    } catch (e) {}
  }


   driverStatusApi(var status) async {
    try {
      print("changeuserstatus");
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");


      final body = {
        "driver_id": ids.toString(),
        "status": status.toString(),
      };
        print("changeuserbody  $body");
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.changeuserstatus, data: body, authToken: authToken);
      print("changeuserstatus  $response");
      if (response["status"]==true) {
        if(status=="online"){
         showSnackBar(languages[choosenLanguage]['text_Success'], languages[choosenLanguage]['text_Online_success'], Colors.greenAccent);
        } else {
          showSnackBar(languages[choosenLanguage]['text_Success'], languages[choosenLanguage]['text_Offline_success'], Colors.greenAccent);
        }
      }
      

    } catch (e) {

    }
  }

}
