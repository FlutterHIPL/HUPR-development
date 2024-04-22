import 'package:flutter/material.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class PaymentFailWidget extends StatelessWidget {
  const PaymentFailWidget({super.key, required this.error});
  final String error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.only(top: 230),
        child: Column(
          children: [
            Image.asset(
              'assets/images/failed.gif',
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
              width: 100,
              // height: 60,
            ),
           heightSpace10,
             Text(
              languages[choosenLanguage]['text_Failed'],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
             heightSpace10,
            Text(
              "${languages[choosenLanguage]['text_Error']} - $error",
              style: const TextStyle(fontSize: 10),
            ),
             heightSpace40,
            ElevatedButton(
                onPressed: () {
                  //   AppNavigator.gotoLanding(context);
                  Navigator.pop(context);
                },
                child:  Text(languages[choosenLanguage]['text_Back']))
          ],
        ),
      )),
    );
  }
}
