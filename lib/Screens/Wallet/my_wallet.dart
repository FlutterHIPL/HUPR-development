import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Screens/Profile_Screen/Payout_Methods/payout_methods.dart';
import 'package:hupr_texibooking/Screens/Wallet/payment_fail_widget.dart';
import 'package:hupr_texibooking/Screens/Wallet/payment_succes_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/consts.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:http/http.dart' as http;
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  int? selectedRadio;
  TextEditingController amountController=TextEditingController();
  TextEditingController couponcodeController=TextEditingController();
  bool isError = false;
  var walletList = [];
  var formatterDate = DateFormat('dd MMMM');
  var formatterTime = DateFormat('kk:mm');
  bool isLoading = false;
  var total_amount;
  @override
  void initState() {
    super.initState();
    wallatApi();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 204,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.profileBackground),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(Images.backIcon)),
                  ),
                  heightSpace10,
                  Text(
                    languages[choosenLanguage]['text_Wallet_Balance'],
                    style: TextStyle(
                        color: hintTextColor,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  heightSpace10,
                  Text(
                    "EUR ${total_amount==null?"0": total_amount}",
                    style: TextStyle(
                        color: appBackgroundColor,
                        fontSize: 26,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 170),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: outlineColor, width: 2)),
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: outlineColor, width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){ 
                            
                           
                            setState(() {
                              isError=false;
                               couponcodeController.clear();
                                RedeemGiftCard();
                            });
                            
                            },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.gift),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: Get.width * 0.28,
                                child: Text(
                                  languages[choosenLanguage]['text_Redeem_Gift_Card'],
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                      maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 80,
                          color: lightBlueColor,
                        ),
                        GestureDetector(
                          onTap: () {
                           setState(() {
                            isError = false;
                            amountController.clear();
                              AddCredit();
                              
                           });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(Images.addCredit),
                              SizedBox(
                                width: 5,
                              ),
                            Container(
                              width: Get.width * 0.2,
                              child: Text(
                                languages[choosenLanguage]['text_Add_Credit'],
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                                    maxLines: 2,
                               // textAlign: TextAlign.center,
                              ),
                            ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 259, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => PayoutMethods());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Images.paymentMethodImage),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                languages[choosenLanguage]['text_Payout_Methods'],
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SvgPicture.asset(Images.arrowRightIcon)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        languages[choosenLanguage]['text_Activities'],
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Expanded(
                
                    child:  isLoading == true
                          ? Container(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : walletList.length==0? Container(
                              alignment: Alignment.center,
                              child: Text(
                                languages[choosenLanguage]['text_Activities_Not_Found'],
                                            style: TextStyle(
                                                color: blackTextColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center,
                                          ),
                            ):  ListView.builder(
                        itemCount: walletList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                           DateTime timestamp =
                                DateTime.parse(walletList[index]["created_at"])
                                    .toLocal();

                            // Convert to Indian Standard Time (IST)
                            DateTime istTime = timestamp
                                .toUtc()
                                .add(Duration(hours: 5, minutes: 30));
                    
                          return
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: lightBlueColor)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      walletList[index]["type"].toString() != "deposit"
                                          ? SvgPicture.asset(
                                              Images.cashride,
                                              width: 28,height: 28,
                                            )
                                          :  Image.asset(Images.addmoney,width: 28,height: 28,),
                                      widthSpace20,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            languageSelectcode.toString()=="en"? allWordsCapitilize1(allWordsCapitilize("${walletList[index]["type"]}"))
                                            :walletList[index]["type"].toString()=="deposit"?
                                            languages[choosenLanguage]['text_Deposit']:languages[choosenLanguage]['text_Coupon'],
                                           
                                         
                                            style: TextStyle(
                                                color: blackTextColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                          "${formatterDate.format(istTime)} ${formatterTime.format(istTime)}",
                                            style: TextStyle(
                                                color: hintTextColor,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "EUR ${walletList[index]["amount"]}",
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
   }) )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AddCredit() {
     final formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Form(
                    key: formKey ,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SvgPicture.asset(Images.card),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          languages[choosenLanguage]['text_Add_Credit_To_Wallet'],
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0),
                          textAlign: TextAlign.center,
                        ),
                        heightSpace10,
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 5, left: 20),
                          child: Row(
                            children: [
                              Text(
                                languages[choosenLanguage]['text_Select_amount'],
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
                          height: 50,
                          width: Get.width * 0.7,
                          decoration: BoxDecoration(
                              // color: whiteColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: outlineColor, width: 2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState((){

                                 
                                  amountController.text="100";
                                  isError = false;
                                   });
                                },
                                child: Text(
                                  "  EUR 100",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 80,
                                color: lightBlueColor,
                              ),
                              GestureDetector(
                                onTap: () {
                                   setState((){
                                   amountController.text = "200";
                                   isError = false;
                                   });
                                },
                                child: Text(
                                  "EUR 200",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 80,
                                color: lightBlueColor,
                              ),
                            GestureDetector(
                                onTap: () {
                                   setState((){
                                  amountController.text = "500";
                                  isError = false;
                                   });
                                },
                                child: Text(
                                  "EUR 500  ",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        heightSpace10,
                        Container(
                          width: 175,
                          height: 50,
                          child: TextFormField(
                            controller: amountController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: outlineColor, width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: languages[choosenLanguage]['text_Enter_amount'],
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  textBaseline: TextBaseline.alphabetic,
                                )),
                                 onChanged: (value) {
                                  if (value == "null" || value.isNotEmpty) {
                                  isError = false;
                              }
                                 },
                            
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: isError,
                                child: Text(
                                  languages[choosenLanguage]['text_Amount_is_required'],
                                  style: TextStyle(
                                      color: redColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 5, left: 20),
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
                    
                      
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(Images.stripe),
                                   widthSpace10,
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
                          onTap: () {
                             if (amountController.text.isNotEmpty) {
                            if (selectedRadio.toString()=="1") {
                               print("selectedRadio $selectedRadio");
                              showSnackBar(
                                    languages[choosenLanguage]
                                        ['text_Error'], languages[choosenLanguage]['text_PayPal_Payment_not_Working'],
                                  Colors.redAccent);
                            }
                           else if  (selectedRadio.toString() == "2") {

                            if (int.parse(amountController.text.toString())  <100) {
                                showSnackBar(
                                      languages[choosenLanguage]['text_Error'],
                                     languages[choosenLanguage]['text_Minimum_amount_100'],
                                      Colors.redAccent);
                             } else{
                                 setState((){

                                     Navigator.pop(context);
                                   createPaymentIntent("TEST");
                                    // createcustomer();
                                  });
                             }
                           
                            } else{
                             showSnackBar(
                                    languages[choosenLanguage]['text_Error'], languages[choosenLanguage]
                                        ['text_Select_payment_method'],
                                  Colors.redAccent);
                            }
                             }else{
                             setState((){
                               isError=true;
                             });
                             }
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              height: 55,
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
                                        languages[choosenLanguage]['text_Redeem'],
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins'),
                                      ),
                                      heightSpace10,
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        heightSpace20,
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  RedeemGiftCard() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SvgPicture.asset(
                        Images.gift,
                        color: appBackgroundColor,
                      ),
                      heightSpace15,
                      Text(
                        languages[choosenLanguage]['text_Redeem_Gift_Card'],
                        style: TextStyle(
                            color: blackTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0),
                        textAlign: TextAlign.center,
                      ),
                      heightSpace10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            languages[choosenLanguage]['text_Enter_your_gift_card_code_to_redeem_it'],
                            style: TextStyle(
                                color: greyTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      heightSpace20,
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: 50,
                        child: TextFormField(
                          controller: couponcodeController,
                          //textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                              prefixIcon: Container(
                                  height: 5,
                                  child: SvgPicture.asset(Images.gift,
                                      height: 5,
                                      width: 5,
                                      fit: BoxFit.scaleDown)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: outlineColor, width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: languages[choosenLanguage]['text_Enter_gift_card_code'],
                              hintStyle: TextStyle(
                                fontSize: 14,
                                textBaseline: TextBaseline.alphabetic,
                              )),
                              onChanged: (value) {
                                  if (value == "null" || value.isNotEmpty) {
                                     setState(() {
                                isError = false;
                              });
                                 
                              }
                                 },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: isError,
                                child: Text(
                                  languages[choosenLanguage]['text_Gift_card_code_is_required'],
                                  style: TextStyle(
                                      color: redColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      heightSpace30,
                      GestureDetector(
                        onTap: () {
                     if (couponcodeController.text.isNotEmpty) {
                          couponCodeApi(couponcodeController.text.trim());
                     }
                     else{
                       setState(() {
                              isError = true;
                            });
                     }
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: 55,
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
                                      languages[choosenLanguage]
                                ['text_Pay_Now'],
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins'),
                                    ),
                                   heightSpace10,
                                  ],
                                ),
                              ),
                            )),
                      ),
                      heightSpace20,
                      GestureDetector(
                        onTap: () {
                          
                            setState(() {
                               Navigator.pop(context);
                            isError = false;
                          });
                        },
                        child: Container(
                            height: 55,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              shape: BoxShape.rectangle,
                              border: Border.all(width: 2, color: outlineColor),
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
                                    heightSpace10,
                                  ],
                                ),
                              ),
                            )),
                      ),
                      heightSpace20,
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }













Future<void> createcustomer() async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var mobile_number = prefs.getString("mobile_number");
    var first_name = prefs.getString("first_name");
    var last_name = prefs.getString("last_name");

    try {
      final url = Uri.parse('https://api.stripe.com/v1/customers');
      final response = await http.post(
        url,
        headers: {
          "Authorization":
              "Bearer sk_test_51HolFdGgnK7D16sBRszOc1l7LXSlMN3ufEpLvFGOgEhV4Jna6mzg9YaX4Uo8eWtycDqGZvRCO75QGvPBb4kWI6xV00Q7rTEev0",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          "email":email,
          "name": "${first_name}${last_name}",
          "phone": mobile_number,   },
      );

      final responseData = jsonDecode(response.body);
     createPaymentIntent(responseData);
      print(responseData);
    } catch (e) {
      print('Error creating customer: $e');
    }
  }

  
  Future<void> createPaymentIntent(var responseData) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
   
       final SharedPreferences prefs = await SharedPreferences.getInstance();
        var userId = prefs.getInt("id");
      var email = prefs.getString("email");
        var mobile_number = prefs.getString("mobile_number");
          var first_name = prefs.getString("first_name");
          var last_name = prefs.getString("last_name");
          var authToken = prefs.getString("token");
    try {
      print("body $authToken");
  
       // 1. create payment intent on the server
      Map<String, dynamic> body = {
        'amount': (int.parse(amountController.text.toString()) * 100).toString(),
        'currency': "eur",
        'payment_method_types[]':"card"
        // 'customer':responseData['id'],
        //  'automatic_payment_methods[enabled]': "true"
      };

      Map<String, String> headers = {
        'Authorization':
            'Bearer sk_test_51HolFdGgnK7D16sBRszOc1l7LXSlMN3ufEpLvFGOgEhV4Jna6mzg9YaX4Uo8eWtycDqGZvRCO75QGvPBb4kWI6xV00Q7rTEev0',
        'content-type': 'application/x-www-form-urlencoded'
      };
      print("payment Header: ${headers}");
      var response = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: headers,
          body: body);

      var data = jsonDecode(response.body);

      
    

      // 2. initialize the payment sheet
      Random objectname = Random();
      int number = objectname.nextInt(54657616);
      print("payment_intents ${data}");
      int amount = double.parse(amountController.text.toString()).toInt();
     
      //Amount is in Cent

      // create some billingdetails
      final billingDetails = BillingDetails(
        name: "${first_name}${last_name}",
        email: email,
        phone: mobile_number,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Enable custom flow
          customFlow: await Stripe.instance.isPlatformPaySupported(),
          // Main params
          merchantDisplayName: 'HUPR',
          //   allowsDelayedPaymentMethods: false,
          paymentIntentClientSecret: data['client_secret'],
         // customerEphemeralKeySecret: data['id'],
          customerId: "$number",
          style: ThemeMode.dark,
          applePay: await Stripe.instance.isPlatformPaySupported()
              ? PaymentSheetApplePay(
                  merchantCountryCode: 'eur',
                  cartItems: [
                    ApplePayCartSummaryItem.immediate(
                      label: 'Cart Payment',
                      amount: amount.toString(),
                    ),
                  ],
                )
              : null,
          googlePay: await Stripe.instance.isPlatformPaySupported()
              ? const PaymentSheetGooglePay(
                  merchantCountryCode: 'eur',
                  testEnv: true,
                )
              : null,
          billingDetails: billingDetails,
        ),
      );


    //  Present the Payment Sheet
  

//  3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet().then((value) async {
        // 4. Confirm the payment sheet.
       
       
       setState(() {
      
           makePayementApi(userId,amount,authToken, data['id'].toString());
          print("presentPaymentSheet ${value}");
       });
       await Stripe.instance.confirmPaymentSheetPayment();

      }).onError((error, stackTrace) {
        setState(() {
          Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) => PaymentFailWidget(
              error: languages[choosenLanguage]['text_The_payment_option_selection_flow_has_been_canceled']),
        );
        print("error11 ${error.toString()}");
        print("stackTrace ${stackTrace.toString()}");

       });
      });
    } on StripeException catch (e) {
       setState(() {
        Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => PaymentFailWidget(
            error: languages[choosenLanguage]
                  ['text_The_payment_option_selection_flow_has_been_canceled']),
      );

      print("StripeException $e");
       });
    } catch (e) {
       setState(() {
        Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) => PaymentFailWidget(error: languages[choosenLanguage]['text_Exception_Error']),
      );
      print("catch === $e");
      });
    }
  }



    makePayementApi(var userId,amount,authToken,payment_id) async {
    print("makePayement ");
        var body={
            "user_id":userId.toString(),
            "amount":amount.toString(),
            "description":"null",
            "payment_id":payment_id.toString(),
            "type": "deposit"

        };
        print("body $authToken");
        try{
          var response=await ApiProvider().postRequest(apiUrl:AppConstants.addwalletPayment,data: body ,authToken:authToken);
          
      print("makePayement $response");

          if (response["status"]=true) {
        
        setState(() {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => PaymentSuccessWidget(),
          );
          wallatApi();
        });
          }
          else{
             Navigator.of(context).pop();
           showSnackBar(languages[choosenLanguage]['text_Error'], response["message"], Colors.greenAccent);
          }

         
         
           

        }catch(e){
      print("Payementcatch ${e.toString()} ");
      Navigator.of(context).pop();
        }
    }

  couponCodeApi(var couponCode) async {
  

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {"user_id": ids.toString(),
      "coupon": couponCode.toString()};
      print("body ${body} ");
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.redeemCoupon,
          data: body,
          authToken: authToken);
        print("response ${response} ");
      if (response["status"] == true) {
        setState(() {
         showSnackBar(languages[choosenLanguage]['text_Success'], response["message"], Colors.greenAccent);
         couponcodeController.clear();
          wallatApi();
        });
      } else {
        setState(() {
          showSnackBar(languages[choosenLanguage]['text_Error'], response["message"], Colors.redAccent);
        });
      }
    } catch (e) {
      setState(() {
       
       showSnackBar(languages[choosenLanguage]['text_Error'], e.toString(), Colors.redAccent);
      });
    }
  }



   wallatApi() async {
 
 var box=GetStorage();
    isLoading=true;
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {"user_id": ids.toString(),};
      print("body ${body} ");
      var response = await ApiProvider().postRequest(
          apiUrl: AppConstants.walletlist, data: body, authToken: authToken);
           print("response ${response} ");
      if (response["status"] == true) {
        setState(() {
          box.write("amount", double.parse(response["currentBalance"].toString()).toStringAsFixed(2));
           total_amount=double.parse(response["currentBalance"].toString()).toStringAsFixed(2);
         walletList.clear();
          walletList.addAll(response["data"]);
        
         isLoading = false;
        });
      } else {
        setState(() {
          showSnackBar(languages[choosenLanguage]['text_Error'], response["message"], Colors.redAccent);
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        showSnackBar(languages[choosenLanguage]['text_Error'], e.toString(), Colors.redAccent);
        isLoading = false;
      });
    }
  }
String allWordsCapitilize(String str) {
    return str.toLowerCase().split(' ').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join(' ');
  }

  String allWordsCapitilize1(String str) {
    return str.toLowerCase().split('/').map((word) {
      String leftText = (word.length > 1) ? word.substring(1, word.length) : '';
      return word[0].toUpperCase() + leftText;
    }).join('/');
  }

   }
