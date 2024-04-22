
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class AddPaymentMethods extends StatefulWidget {
  const AddPaymentMethods({super.key});

  @override
  State<AddPaymentMethods> createState() => _AddPaymentMethodsState();
}

class _AddPaymentMethodsState extends State<AddPaymentMethods> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
      
        body: Container(
           padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                
                
                 GestureDetector(
                 onTap: () {
           Get.back();
                 },
                 child: SvgPicture.asset(Images.backIcon)),
                            
                            heightSpace30,

                            Row(
                          children: [
                            Padding(
                               padding: const EdgeInsets.only(right: 20,bottom: 20,top: 15),
                              child: Text(
                                languages[choosenLanguage]['text_Payout_Methods'],
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                          
                
              
          Text(
            languages[choosenLanguage]['text_Select_Cards'],
            style: TextStyle(
                color: blackTextColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
                 heightSpace10,
                             Text(
                              languages[choosenLanguage]['text_You_can_Select_the_card_numbers_you'],
                               style: TextStyle(
                                   color: greyTextColor,
                                   fontSize: 14,
                                   fontWeight: FontWeight.w400),
                             ),
heightSpace40,

                               GestureDetector(
                          onTap: (){
                           AddPayment();
                          },
                           child: Container(
                            height: 55,
                            
                                decoration: BoxDecoration(
                                //  color: btnColor,
                                border: Border.all(width: 2,color: appBackgroundColor),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 12.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                         SvgPicture.asset(Images.stripe),
                                         widthSpace10,
                                        Text(
                                          languages[choosenLanguage]['text_Add_Card'],
                                          style: TextStyle(
                                              color: appBackgroundColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Poppins'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                         ),
                          heightSpace20,
                          
                
          ],),
        ),
      ),
    );
  }

int? selectedRadio;

AddPayment(){
  
  showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState ) {
            return  Container(
                        margin: EdgeInsets.only(top: 20,bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                                              
                            SvgPicture.asset(Images.wallet),
                            SizedBox(height: 15,),
                           Text(
                            languages[choosenLanguage]['text_Add_Payout_Method'],
                                     style: TextStyle(
                                                  color: blackTextColor,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22.0),
                                                   textAlign: TextAlign.center,
                                         ),
                                               heightSpace10,
                                         Text(
                                          languages[choosenLanguage]['text_Add_a_new_payment_method_to_your_account'],
                                     style: TextStyle(
                                                  color: greyTextColor,
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0),
                                                   textAlign: TextAlign.center,
                                         ),


                                          Container(
                                              margin: EdgeInsets.only(top: 20,bottom: 5,left: 20),
                                            child: Row(
                                              children: [
                                                Text(languages[choosenLanguage]['text_Select_payment_method'],
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
                       
                           Container(
                            margin: EdgeInsets.only(left: 20,right: 20),
                             child: GestureDetector(
                               onTap: () {
                               
                                },
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
                                 setSelectedRadio(val!);
                              });
                            },
                                        ),
                                 ],
                               ),
                             ),
                           ),
                         
                        heightSpace20,
                                              
                         GestureDetector(
                          onTap: (){
                           
                          },
                           child: Container(
                             margin: EdgeInsets.only(left: 20,right: 20),
                                decoration: BoxDecoration(
                                  color: appBackgroundColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 12.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [ 
                                        Text(
                                          languages[choosenLanguage]['text_Confirm'],
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                         ),
                         
                         heightSpace20,
                          GestureDetector(
                          onTap: (){
                           
                          },
                           child: Container(
                             margin: EdgeInsets.only(left: 20,right: 20),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(width: 2,color: outlineColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 12.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [ 
                                        Text(
                                          languages[choosenLanguage]['text_Cancel'],
                                          style: TextStyle(
                                              color: hintTextColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Poppins'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                         ),
                         
                         
                          heightSpace20,
                          ],
                        ),
                      );
                    }
                  );
                                                                         },
                                                                           );
}

setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
}