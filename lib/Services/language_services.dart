import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageServices {
  static Future getLanguage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': 'en-US',

    };

    final res = await http.get(Uri.parse(AppConstants.language),
        headers: requestHeaders);

    var data = jsonDecode(res.body);

    if (kDebugMode) {
      print("******Language Api Call****");
      print(AppConstants.language);
      print(requestHeaders);
      print(jsonDecode(res.body));
      print(res.statusCode);
      print(data);
    }

    if (res.statusCode == 200) {
      if (data != null) {
        return data;
      } else {
        showSnackBar("Error!!", data['message'], Colors.redAccent);
        return null;
      }
    } else {
      showSnackBar("Error!!", data['message'], Colors.redAccent);
      return null;
    }
  }
}
