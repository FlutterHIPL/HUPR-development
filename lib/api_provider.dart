import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/Utils/consts.dart';

class ApiProvider {
  String BASE_URL = 'http://hupr.hipl-staging3.com/api/';
  Future<dynamic> getRequest(
      {required apiUrl, authToken ,data = const <String, String>{}}) async {
    var res2 = await http.get(Uri.parse('$BASE_URL$apiUrl'),
        headers: {'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    });
    var res = jsonDecode(res2.body);
    if (res2.statusCode == 200) {
      return res;
    } else if (res2.statusCode == 401) {
      return Future.error(res);
    } else if (res2.statusCode == 404) {
      return Future.error(res);
    } else if (res2.statusCode == 500) {
      return Future.error(res);
    } else {
      return Future.error('Network Problem');
    }
  }

  Future<dynamic> postRequest(
      {required apiUrl, authToken,data = const <String, String>{}}) async {
      var res2 = await http.post(Uri.parse('$apiUrl'),
        body: data, headers: {'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    });
     print("postRequest: ${res2.statusCode}");
     print("languageSelectcode: ${authToken}");
    var res = jsonDecode(res2.body);

    if (res2.statusCode == 200) {
      return res;
    } else if (res2.statusCode == 500) {
      return Future.error(res);
    } else if (res2.statusCode == 404) {
      return Future.error(res);
    } else if (res2.statusCode == 401) {
      return Future.error(res);
    } else {
      return Future.error('Network Problem');
    }
  }

  Future<dynamic> postRequest1(
         {required apiUrl, authToken,data = const <String, String>{}}) async {
      var res2 = await http.post(Uri.parse('$apiUrl'),
        body: data, headers: {
          'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    });
    print("apiUrl: ${languageSelectcode.toString()}");
      print("poststatusCode: ${res2.statusCode}");
    print("postRequest: ${res2.body}");
   
    var res = jsonDecode(res2.body);

    if (res2.statusCode == 200) {
      return res;
    } else if (res2.statusCode == 500) {
      return Future.error(res);
    } else if (res2.statusCode == 404) {
      return res;
    } else if (res2.statusCode == 401) {
      return res;
    } else if (res2.statusCode == 422) {
      return res;
    } else {
      return Future.error('Network Problem');
    }
         }


  Future<dynamic> getRequest1(
      {required apiUrl, authToken, data = const <String, String>{}}) async {
    var res2 = await http.get(Uri.parse('$apiUrl'), headers: {
      "Content-Type":"application/json",
      'Authorization': "Bearer $authToken",
     'Accept-Language': languageSelectcode.toString(),
    });
     log("statusCode:- ${res2.statusCode}");
      log("getRequest1:- ${apiUrl}");
    var res = jsonDecode(res2.body);
    if (res2.statusCode == 200) {
      return res;
    } else if (res2.statusCode == 401) {
      return Future.error(res);
    } else if (res2.statusCode == 404) {
      return Future.error(res);
    } else if (res2.statusCode == 500) {
      return Future.error(res);
    } else if (res2.statusCode == 403) {
      return Future.error(res);
    } else {
      return Future.error('Network Problem');
    }
  }
    Future<dynamic> getRequest2(
      {required apiUrl, authToken, data = const <String, String>{}}) async {
    var res2 = await http.get(Uri.parse('$apiUrl'), headers: {
      "Content-Type": "application/json",
      'Accept-Language': languageSelectcode.toString(),
    });
    log("statusCode:- ${res2.statusCode}");
    log("getRequest1:- ${apiUrl}");
    var res = jsonDecode(res2.body);
    if (res2.statusCode == 200) {
      return res;
    } else if (res2.statusCode == 401) {
      return Future.error(res);
    } else if (res2.statusCode == 404) {
      return Future.error(res);
    } else if (res2.statusCode == 500) {
      return Future.error(res);
    } else if (res2.statusCode == 403) {
      return Future.error(res);
    } else {
      return Future.error('Network Problem');
    }
  }
}
