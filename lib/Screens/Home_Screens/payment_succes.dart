import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PaymentSuccess extends StatefulWidget {
  var currency,amount,name,customer_id,booking_id,country_code,mobile_number;
   PaymentSuccess({super.key,required this.currency,required this.amount,
      required this.name,
      required this.customer_id,
      required this.booking_id,
       required this.country_code,
        required this.mobile_number});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
   bool isLoading = false;
 @override
  Widget build(BuildContext context) {
    int? selectedRadio;
   


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:  StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
            return Container(
                    margin: EdgeInsets.only(left: 40,right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: 
                        MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/success.gif',
                fit: BoxFit.fill,
                alignment: Alignment.bottomCenter,
                width: 100,
                // height: 60,
              ),
                heightSpace40,
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languages[choosenLanguage]['text_Customer_Name'],
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                heightSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        languages[choosenLanguage]['text_Fare_Price'],
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                     Text(
                      "${widget.currency} ${widget.amount}",
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                      
                     
                    ],
                ),
                  heightSpace30,

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 15,),
                  child: Row(
                    children: [
                      Text(
                         languages[choosenLanguage]['text_Select_payment_method'],
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                 GestureDetector(
                   onTap: () {},
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Row(
                         children: [
                           Image.asset(
                            Images.cash,
                            width: 28,
                            height: 28,
                          ),
                           SizedBox(
                             width: 20,
                           ),
                           Text(
                            languages[choosenLanguage]['text_Cash'],
                             style: TextStyle(
                                 color: blackTextColor,
                                 fontFamily: "Poppins",
                                 fontWeight: FontWeight.w500,
                                 fontSize: 14.0),
                             textAlign: TextAlign.center,
                           ),
                         ],
                       ),
                        
                       Radio(
                         value: 1,
                         groupValue: selectedRadio,
                         activeColor: greenColor,
                         onChanged: (val) {
                        
                        setState(() {
                         print("object  $val");
                          selectedRadio = int.parse(val.toString());
                         
                        });
                           
                         
                         },
                       ),
                     ],
                   ),
                 ),
              Container(
                  margin: EdgeInsets.only(left: 48, top: 10, right: 20),
                  height: 2,
                  color: outlineColor),
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Images.stripe),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          languages[choosenLanguage]['text_Stripe'],
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: greenColor,
                      onChanged: (val) {
                        
                         setState(() {
                         selectedRadio = int.parse(val.toString());
                        
                        });
                      
                      },
                    ),
                  ],
                ),
              ),
                         

                         heightSpace40,
                         isLoading==true?
                  Padding(
                  padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                    child: Container(
     
                          height: 50,
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
):
                          Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: CustomButton(
                      isVisible: true,
                      btnName: languages[choosenLanguage]['text_Confirm_Payment'],
                      onPressed: () {
                        setState(() {

                          if(selectedRadio!=null){
                            if(selectedRadio==1){
                             makePayementApi();
                            }
                          else{
                            generatepaymentApi();
                           
                          }

                          }else{
                            showSnackBar(
                                languages[choosenLanguage]
                                    ['text_Error'], languages[choosenLanguage]['text_Please_select_the_payment_method'],
                                Colors.redAccent);
                          }
                        
                        });
                      },
                    )),
              
            ],
                      ),
                    );
          }
        ),
      ),
    );
  }

  makePayementApi() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString("token");
      var ids = prefs.getInt("id");
   isLoading = true;
   
    var body = {
      "booking_id": widget.booking_id.toString(),
      "customer_id": widget.customer_id.toString(),
     "driver_id": ids.toString(),
      "amount": widget.amount.toString(),
      "type":"cash",
      "status": "Succeeded"
    };
     print("body $body ");
    try {
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.makePayement, data: body, authToken: authToken);

      print("makePayement $response");

      if (response["status"] = true) {
        setState(() {
           isLoading = false;
          Navigator.pop(context, true);
        });
          showSnackBar(languages[choosenLanguage]['text_Success'], response["message"], Colors.greenAccent);
      } else {
         isLoading = false;
        showSnackBar(languages[choosenLanguage]['text_Success'], response["message"], Colors.greenAccent);
      }
    } catch (e) {
       isLoading = false;
      print("Payementcatch ${e.toString()} ");
     
    }
  }


   generatepaymentApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString("token");
    var ids = prefs.getInt("id");
    var fcm_token = prefs.getString("fcm_token");

    isLoading=true;
    var body = {
      "booking_id": widget.booking_id.toString(),
      "amount": double.parse(widget.amount.toString()).toInt().toString(),
      "mobile_number": "${widget.country_code}${widget.mobile_number}",
       "driver_id": ids.toString(),
        "fcm_token": fcm_token.toString(),
     
    };
    print("generatepaymentlink1 $body ");
    try {
      var response = await ApiProvider().postRequest1(
          apiUrl: AppConstants.generatepaymentlink, data: body, authToken: authToken);

      print("generatepaymentlink $response");

      if (response["status"] == true) {
        setState(() {
           isLoading = false;
      Navigator.pop(context, true);
        });
       showSnackBar(languages[choosenLanguage]['text_Success'], response["message"], Colors.greenAccent);
      } else {
         setState(() {
           isLoading = false;
                  showSnackBar(languages[choosenLanguage]['text_Error'],
              response["error"].toString(), Colors.redAccent);

         // Navigator.pop(context, false);
        });
      }
    } catch (e) {
       isLoading = false;
      print("Payementcatch ${e.toString()} ");
    }
  }

}
