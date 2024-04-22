
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Screens/Otp_Screen/set_password_screen.dart';
import 'package:hupr_texibooking/Services/driver_auth_services.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MyOtpPage extends StatefulWidget {

  var otp,countryCode,phoneNumber;
 

   MyOtpPage( {super.key,required this.otp,
   required this.countryCode,required this.phoneNumber});

  @override
  State<MyOtpPage> createState() => _MyOtpPageState();
}

class _MyOtpPageState extends State<MyOtpPage> {

static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 static final TextEditingController pinController=TextEditingController();

    var isLoading = false;
     var isButtonLoading = false;
    String verificationId="";

// Timer? countdownTimer;
//   Duration myDuration = Duration(seconds: 20);
//   bool countDown = true;


// @override
//   void initState() {

//     super.initState();
//    startTimer();
//   }


// void startTimer() {
//     countdownTimer =
//         Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
//   }
//   void setCountDown() {
//     const reduceSecondsBy = 1;
//     setState(() {
//       final seconds = myDuration.inSeconds - reduceSecondsBy;
//       countDown = true;
//       if (seconds < 0) {
//         log("Duration1 $seconds");
//         countdownTimer!.cancel();
//         countDown = false;
//       } else {
//         myDuration = Duration(seconds: seconds);
//          log("Duration $seconds");
//       }
//     });
//   }

  
//    @override
//    void dispose(){
//    super.dispose();

//         countdownTimer!.cancel();
//        countDown=false;

// }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
                  slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Form(
             key: _formKey,  
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: fillColor),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: SvgPicture.asset(Images.backIcon))
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2 * 0.5,
                  decoration: BoxDecoration(color: fillColor),
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset(Images.otpImage),
                  ),
            
                  // SvgPicture.asset(Images.signInImage),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: appBackgroundColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            "1",
                            style: TextStyle(
                                color: whiteColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SvgPicture.asset(Images.dotImage),
                      Container(
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            "2",
                            style: TextStyle(
                                color: hintTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SvgPicture.asset(Images.dotImage),
                      Container(
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            "3",
                            style: TextStyle(
                                color: hintTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SvgPicture.asset(Images.dotImage),
                      Container(
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            "4",
                            style: TextStyle(
                                color: hintTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SvgPicture.asset(Images.dotImage),
                      Container(
                        decoration: BoxDecoration(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            "5",
                            style: TextStyle(
                                color: hintTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
               Text(
                  languages[choosenLanguage]['text_Enter_OTP'],
                  style: TextStyle(
                      color: blackTextColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    languages[choosenLanguage]['text_verification_code_has_been_sent_phone_number'],
                    style: TextStyle(
                        color: greyTextColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                heightSpace20,
                
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50),
                  child: PinCodeTextField(
                    animationType: AnimationType.none,
                    appContext: context,
                    controller:pinController,
                    length: 6,
                  obscureText: false,
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.number,
                    autoDismissKeyboard: false,
                    cursorColor: blackTextColor,
                    enableActiveFill: true,
                    validator: (value) {
                      if (value == null) {
                        return languages[choosenLanguage]['text_The_Pin_is_required'] ;
                      }
                      if ( value.isEmpty) {
                        return languages[choosenLanguage]
                            ['text_The_Pin_is_required'];
                      }
                      return null;
                    },
                    inputFormatters: [
                     FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      fieldHeight: 55,
                      fieldWidth: 38,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      selectedFillColor: fillColor,
                      activeFillColor: fillColor,
                      inactiveFillColor: fillColor,
                      inactiveColor: outlineColor,
                      selectedColor: outlineColor,
                      activeColor: outlineColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              
               isLoading==false
                      ?  GestureDetector(
                  onTap: (){
                    setState(() {
                      
                        varifyContactNumberCall();
                    pinController.clear();
                    });
                   
                  },
                  child: Text(
                    languages[choosenLanguage]['text_Resend_code'],
                    style: TextStyle(
                        color: appBackgroundColor,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  ),
                ): Center(
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                        strokeWidth: 3, color: appBackgroundColor),
                  ),
                ),
               
                Spacer(),
               isButtonLoading==false? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CustomButton(
                    isVisible: true,
                    btnName: languages[choosenLanguage]['text_Confirm'],
                    onPressed: () async {
              
                         if (_formKey.currentState!.validate()) {  
            
                                      if(pinController.text.length==6)
                                      {
                   
                                      
                                setState(() {
                                    isButtonLoading=true;
                                });
              
                                if(widget.otp.toString()==pinController.text.toString()){
                                setState(() {
                                    isButtonLoading=false;
                                    Get.to(()=>MySetPasswordPage());
                                });
                               
                                }else{
                                isButtonLoading=false;
                                   showSnackBar(languages[choosenLanguage]['text_Error'],
                                   languages[choosenLanguage]['text_OTP_entered_is_incorrect'], Colors.redAccent);
                                }
                                    }
                    
                                    else{
                                      
                                    }
                         }
                
                    },
                  ),
                ):
                
                
                Container(
                          height: 50,
                           margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            color: appBackgroundColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 12.0),
                            child: Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                    strokeWidth: 3, color: whiteColor),
                              ),
                            ),
                          )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
                  ],
                ),
      ),
    );
  }

  varifyContactNumberCall() async {
     isLoading=true;
  
    try {
      await DriverAuthServices.verifyContactNumber(widget.phoneNumber,
        widget.countryCode,
      ).then((value) {
       
        if (value != null) {
           log("isVarifyContactNumberLoading $value");
          if (value["status"]==true) {
          }
          else{
            setState(() {
              
                widget.otp=value["otp"];
              isLoading=false;
            showSnackBar(languages[choosenLanguage]['text_Success'], 
            languages[choosenLanguage]['text_OTP_send_Successfully'], Colors.greenAccent);
      
            });
                }
        }
       
      });
    } catch (e) {
      isLoading=false;
    }
  }


}
