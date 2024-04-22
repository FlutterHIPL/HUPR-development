import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverAuthServices {

  static Future verifyContactNumber(var mobileNumber,countryCode) async {
   // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // var deviceId = prefs.getString("DeviceID");

    if (kDebugMode) {
      print('Verify Contact Number api called');
    }

    final body = {
        "mobile_number": mobileNumber,
      "country_code":countryCode,
    
    };

    if (kDebugMode) {
      print('Verify Contact Number api called');
    }

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept-Language': languageSelectcode.toString(),
    };

   
      print("**********1  $requestHeaders");


    final res = await http.post(Uri.parse(AppConstants.verifyMobileNumber),
        body: jsonEncode(body), headers: requestHeaders);

    if (kDebugMode) {
      print('Verify Contact Number api called');

      print(AppConstants.verifyMobileNumber);
      print(requestHeaders);
      print(body);
      print(jsonDecode(res.body));
      print(res.statusCode);
    }

    var data = jsonDecode(res.body);

    if (kDebugMode) {
      print(data);
    }

    if (res.statusCode == 200) {
      if (data != null) {
        return data;
      } else {
        showSnackBar(data["status"], data["message"], Colors.redAccent);
        return null;
      }
      
    } else {
      
      return data;
    }
   
  }












  static Future driverLogin(var mobileNumber, password ,key,otp,country_code, fcmToken) async {

  final body;

        if(key=="password"){
            body = {
              "mobile_number": mobileNumber,
              "password": password,
              "login_method":key,
              "country_code":country_code,
               "language": languageSelect.toString(),
              "fcm_token":fcmToken
              
            };
        }else{
            body = {
              "mobile_number": mobileNumber,
              "login_method":key,
              "otp": otp,
              "country_code":country_code,
              "language": languageSelect.toString(),
               "fcm_token": fcmToken
            };
        }

    

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept-Language': languageSelectcode.toString(),
    };

    if (kDebugMode) {
      print("********** $body");
    }

    final res = await http.post(Uri.parse(AppConstants.driverLogin),
        body: jsonEncode(body), headers: requestHeaders);
    var data = jsonDecode(res.body);


    if (kDebugMode) {
      print(AppConstants.driverLogin);
       print(res.statusCode);
   
     
    }

    


    if (res.statusCode == 200) {
     
      if (data != null) {
           print("statusCode${res.body}");
       
        return data;
      } else {
        showSnackBar(data["status"].toString(), data["message"], Colors.redAccent);
        return null;
      }
    } else {
      if (data["status"] == false) {
        showSnackBar(languages[choosenLanguage]['text_Error'], data["message"], Colors.redAccent);
      } else {
        showSnackBar(languages[choosenLanguage]['text_Error'], data["error"]['password'][0], Colors.redAccent);
      }
      return null;
    }
  }


static Future driverOTP(var mobileNumber,contrycode) async {
  
  if (kDebugMode) {
      print("******Driver OTP api called******");
    }
    final body = {
      "mobile_number": mobileNumber,
      "country_code":contrycode
    };

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept-Language': languageSelectcode.toString(),
    };

    final res = await http.post(Uri.parse(AppConstants.driverSendOTP),
        body: jsonEncode(body), headers: requestHeaders);

    var data = jsonDecode(res.body);
    
    if (res.statusCode == 200) {
      if (data["status"]==true) {
        return data;
      } else {
        showSnackBar(data["status"], data["message"], Colors.redAccent);
        return data;
      }
    } else {
         return res.statusCode;
    }
  }


 

  static Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    };

    final res = await http.get(Uri.parse(AppConstants.driverLogout),
        headers: requestHeaders);
    if (kDebugMode) {
      print("******Logout Api Call****");
      print(AppConstants.driverLogout);
      print(requestHeaders);
      print(res.statusCode);
      print(res.body);
    }

    var data = jsonDecode(res.body);

    if (kDebugMode) {
      print(data);
    }
    if (res.statusCode == 200) {
      if (data != null) {
        showSnackBar(
            data['message'], "Successfully Logout.", Colors.greenAccent);

        return data;
      } else {
        showSnackBar(languages[choosenLanguage]['text_Error'], data['error'], Colors.redAccent);
        return null;
      }
    }else if(res.statusCode==401){
      return data;
    }
    
     else {
      showSnackBar(languages[choosenLanguage]['text_Error'], data['message'], Colors.redAccent);
      return null;
    }
  }

  
}
