import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportIssue extends StatefulWidget {
  const ReportIssue({super.key});

  @override
  State<ReportIssue> createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {

TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
         onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Form(
              key: formKey,
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
                    languages[choosenLanguage]['text_Report_An_Issue'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 22,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600),
                  ),
              
                   heightSpace20,
                  
              
                 
                  TextFormField(
                  controller: subjectController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                  
                       filled: true,
                       fillColor: Color(0xffF5F5FF),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: outlineColor),
                      ),
                      border: OutlineInputBorder(
                        
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: outlineColor),
                      ),
                       focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: outlineColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: outlineColor,
                    )),
                      hintText: languages[choosenLanguage]['text_Type_the_subject_of_the_issue'],
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return languages[choosenLanguage]['text_Subject_issue_is_required'];
                      }
                      return null;
                    },
                  ),
                   heightSpace20,
                   TextFormField(
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    minLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF5F5FF),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: outlineColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: outlineColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: outlineColor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: outlineColor,
                          )),
                      hintText: languages[choosenLanguage]
                          ['text_Type_the_description_of_the_issue'],
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return languages[choosenLanguage]
                            ['text_description_issue_is_required'];
                      }
                      return null;
                    },
                  ),
                  Spacer(),
                    GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()){
                       FocusScope.of(context).requestFocus(FocusNode());
                      reportissueApi();
                      }
                    },
                    child: Container(
                        height: 55,
                        width: Get.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: redColor,
                          shape: BoxShape.rectangle,
                          border: Border.all(width: 2, color: outlineColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          languages[choosenLanguage]
                            ['text_Report_This_Issue'],
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        )),
                  ),
                    
                    ],),
            ),
          ),),
      ),
    );
  }


  reportissueApi() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var authToken = pref.getString("token");
    var ids = pref.getInt("id");

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Authorization': "Bearer $authToken",
      'Accept-Language': languageSelectcode.toString(),
    };

    var body = {
      "title": subjectController.text.trim(),
      "description":descriptionController.text.trim(),
      "user_id": ids.toString()
    
    };
    print("body $body");
    print("requestHeaders $requestHeaders");
    try {
      final res = await http.post(Uri.parse(AppConstants.reportissue),
          body: body, headers: requestHeaders);

      if (kDebugMode) {
        print(res.statusCode);
        print(requestHeaders);
        print(res.body);
      }

      var data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        if (data["status"] == true) {
          setState(() {
              Navigator.of(context).pop();
              subjectController.clear();
              descriptionController.clear();
              showSnackBar(languages[choosenLanguage]['text_Success'], data["message"].toString(), Colors.greenAccent);
          });
        }
      } else if (res.statusCode == 500) {
        setState(() {
           Navigator.of(context).pop();
          showSnackBar(languages[choosenLanguage]['text_Error'], data["error"].toString(), Colors.redAccent);
        });
      } else {
          Navigator.of(context).pop();
        showSnackBar(languages[choosenLanguage]['text_Error'], res.statusCode.toString(), Colors.redAccent);
      }
    } catch (e) {
       Navigator.of(context).pop();
    }
  }


}