
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_profile_controller.dart';
import 'package:hupr_texibooking/Element/common_snack_widget.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayoutMethods extends StatefulWidget {
  const PayoutMethods({super.key});

  @override
  State<PayoutMethods> createState() => _PayoutMethodsState();
}

class _PayoutMethodsState extends State<PayoutMethods> {
   DriverProfileController profilecontroller =
      Get.put(DriverProfileController());
  TextEditingController amountController = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  bool isLoading1= false;

  @override
  void initState() {
    super.initState();
      profilecontroller.getDriverProfileCall();
  }

  @override
  Widget build(BuildContext context) {
     profilecontroller.getDriverProfileCall();
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
          
                    Container(
                    margin: EdgeInsets.only(bottom: 50),
                    width: MediaQuery.of(context).size.width,
                    height: Get.height*0.25,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.profileBackground),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                         Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(Images.backIcon)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20, top: 15),
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
                       ],
                    )),
          

       isLoading1 == true
                    ?   Container(
                        height: 55,
                         margin: EdgeInsets.only(top: Get.height * 0.3, left: 20, right: 20),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: redColor,
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
                        ))
                    :
                    profilecontroller.stripeStatus.value =="false" ||
                      profilecontroller.stripeStatus.value == ""?
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.3),
             padding: const EdgeInsets.only(
                      left: 20, right: 20),
            child:  GestureDetector(
                    onTap: () {
                    accountLinkApi();
                    },
                    child: Container(
                        height: 55,
                       padding: const EdgeInsets.only(
                            left: 20, right: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: redColor,
                          shape: BoxShape.rectangle,
                        
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Your stripe account verification pending. tap here to verify",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                        )),
                  ),
          ):Container(),
          
                                                       Container(
                                                                             margin: EdgeInsets.only(top: Get.height*0.2),
                                                                             child: Container(
                                                                                 width: MediaQuery.of(context).size.width,
                                                                                 height: 80,
                                                                                 margin: EdgeInsets.symmetric(horizontal: 20),
                                                                                 decoration: BoxDecoration(
                                                                                     color: whiteColor,
                                                                                     borderRadius: BorderRadius.circular(25),
                                                                                     border: Border.all(color: outlineColor, width: 2)),
                                                                                 child: Container(
                                                                                   height: 70,
                                                                                   margin: EdgeInsets.all(8),
                                                                                   decoration: BoxDecoration(
                                                                                       color: whiteColor,
                                                                                       borderRadius: BorderRadius.circular(20),
                                                                                       border: Border.all(color: outlineColor, width: 2)),
                                                                                   child: Row(
                                                                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                     crossAxisAlignment: CrossAxisAlignment.center,
                                                                                     children: [  
          
          
                                  
                                                                                Text(
                                                                                  languages[choosenLanguage]
                                                                                      ['text_Wallet_Balance'],
                                                                                  style: TextStyle(
                                                                                      color: hintTextColor,
                                                                                      fontSize: 16,
                                                                                      fontFamily: "Poppins",
                                                                                      fontWeight: FontWeight.w500),
                                                                                ),
                                                                                heightSpace10,
                                                                                Text(
                                                                                  "EUR ${amount() == "" ? "0.0" : amount()}",
                                                                                  style: TextStyle(
                                                                                      color: appBackgroundColor,
                                                                                      fontSize: 18,
                                                                                      fontFamily: "Poppins",
                                                                                      fontWeight: FontWeight.w700),
                                                                                ),
          
          
          
                                                                                     ]))
                                                                             )
                       ),                      
                                                                          
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: Get.height*0.3),
                  height: Get.height*0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                  
                   Spacer(),
          
              Stack(
                alignment: Alignment.center,
                children: [
          
                 
                  Container(
                            width: Get.width*0.58,
                            height: Get.height * 0.27,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: isError?Border.all(
                                      width: 1, color: redColor):Border.symmetric(),
                              shape: BoxShape.circle,
                                color: Color(0xffE5EEFF).withOpacity(0.2),
                          
                              ),
                         
                         child:  Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                               shape: BoxShape.circle,
                                color: Color(0xffE5EEFF).withOpacity(0.4),
                          
                              ),
                               child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffE5EEFF),
                                   shape: BoxShape.circle,
                                ),
                              ), 
                          ),   
                         
                         
                          ),
          
                          Container(
                            width: Get.width * 0.58,
                            height: Get.height * 0.27,
                            alignment: Alignment.center,
                            child: TextFormField(
                              controller: amountController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: appBackgroundColor),
                              decoration: InputDecoration(
                                   border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "EUR 0.00",
                                  
                                  labelStyle:  TextStyle(
                                    fontSize: 18,
                                    color: appBackgroundColor,
                                    textBaseline: TextBaseline.alphabetic,
                                  ),
                                  hintStyle:  TextStyle(
                                    fontSize: 18,
                                    color: appBackgroundColor,
                                    textBaseline: TextBaseline.alphabetic,
                                  )),
                              onChanged: (value) {
                                setState(() {
                                   if (value == "null" || value.isNotEmpty) {
                                    isError = false;
                                  }
                                });
                               
                              },
                            ),
                          ),

                ],
              ),        
                     Spacer(),
                  
                       
                                isLoading?
                                      Container(
                                      height: 48,
                                       margin: EdgeInsets.only(left: 20, right: 20),
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
                                      )):
                       GestureDetector(
                        onTap: () {
                          if (amountController.text.isNotEmpty) {
                            int parsedValue = double.parse(amount().toString()).toInt();
                       
                            if(parsedValue >1){
                        
                            if(int.parse(amountController.text.toString())>=1){
                              if(int.parse(amountController.text.toString())<parsedValue)
                              {
                                stripeWithdrawalApi();
                              }else{
                                showSnackBar(languages[choosenLanguage]['text_Error'],
                                       languages[choosenLanguage]['text_Insufficient_Balance'], Colors.redAccent);
                              } 
                            }else{
                               showSnackBar(
                                  languages[choosenLanguage]['text_Error'],
                                  languages[choosenLanguage]['text_Minimum_amount_withdrawal_eur_1'],
                                  Colors.redAccent);
                            }
                            }else{
                                 showSnackBar(
                                       languages[choosenLanguage]['text_Error'],
                                        languages[choosenLanguage]['text_Insufficient_Balance'],
                                           Colors.redAccent);
                  
                            }
                           
                          } else {
                            setState(() {
                              isError = true;
                            });
                          }
                        },
                        child: Container(
                          height: 48,
                            margin: EdgeInsets.only(left: 20, right: 20),
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
                                      languages[choosenLanguage]['text_Pay_Now'],
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Nunito Sans'),
                                    ),
                                    widthSpace10,
                                  ],
                                ),
                              ),
                            )),
                      ),


                     Spacer(),

                       Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Images.Notice,color: Color(0xffD2471B),),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: RichText(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                maxLines:
                                    2, // this will show dots(...) after 2 lines
                                strutStyle: StrutStyle(fontSize: 12.0),
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:  languages[choosenLanguage]
                                            ['text_Note'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Color(0xffD2471B))),
                                    TextSpan(
                                        text: " : ${languages[choosenLanguage]['text_Amount_available_for_withdrawal']} :100 %",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Color(0xffD2471B),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                         Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int? selectedRadio;

  AddPayout(context1) {
    showModalBottomSheet(
      context: context1,
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
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SvgPicture.asset(Images.wallet),
                      SizedBox(
                        height: 15,
                      ),
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
                        languages[choosenLanguage][
                            'text_Select_a_payout_method_to_link_your_account_with'],
                        style: TextStyle(
                            color: greyTextColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                      heightSpace15,
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
                              hintText: languages[choosenLanguage]
                                  ['text_Enter_amount'],
                              hintStyle: const TextStyle(
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
                      Container(
                        width: 175,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: isError,
                              child: Text(
                                languages[choosenLanguage]
                                    ['text_Amount_is_required'],
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
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(Images.stripe),
                                  widthSpace20,
                                  Text(
                                    languages[choosenLanguage]
                                        ['text_Stripe_Connect'],
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
                          // Get.to(()=>BankAccountDetaails());
                          if (amountController.text.isNotEmpty) {
                            if (selectedRadio.toString() == "1") {
                              stripeWithdrawalApi();
                            } else {
                              showSnackBar(
                                  languages[choosenLanguage]['text_Error'],
                                  languages[choosenLanguage]
                                      ['text_Select_payment_method'],
                                  Colors.redAccent);
                            }
                          } else {
                            setState(() {
                              isError = true;
                            });
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: btnColor,
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
                                          color: hintTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Nunito Sans'),
                                    ),
                                    widthSpace10,
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

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  stripeWithdrawalApi() async {
    setState(() {
      isLoading = true;
    });
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {
        "driver_id": ids.toString(),
        "currency": "eur",
        "amount": amountController.text.trim()
      };
      print("body ${body} ");
      var response = await ApiProvider().postRequest1(
          apiUrl: AppConstants.withdrawal, data: body, authToken: authToken);
      print("response ${response} ");
      if (response["status"] == true) {
        setState(() {

          box.write('amount',double.parse(response["currentBalance"].toString()).toStringAsFixed(2));
          isLoading = false;
          showSnackBar(languages[choosenLanguage]['text_Success'],
              response["message"], Colors.greenAccent);
          amountController.clear();
        });
      } else {
        
          setState(() {
            isLoading = false;
            showSnackBar(languages[choosenLanguage]['text_Error'],
                response["message"], Colors.redAccent);
          });
      
        
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
       
    }
  }

    accountLinkApi() async {
      setState(() {
          isLoading1 = true;
      });
    
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var authToken = pref.getString("token");
      var ids = pref.getInt("id");

      final body = {
        "driver_id": ids.toString(),
      };
      var response = await ApiProvider().postRequest1(
          apiUrl: AppConstants.accountLink, data: body, authToken: authToken);
      print("accountLink ${response}");
      if (response['status'] == true) {
        setState(() {
           isLoading1 = false;
          showSnackBar(languages[choosenLanguage]['text_Success'],
              response["message"].toString(), Colors.greenAccent);
        });
       
      } else {
         setState(() {
        isLoading1 = false;
        showSnackBar(languages[choosenLanguage]['text_Error'],
            response["message"].toString(), Colors.redAccent);
        });
      }
    } catch (e) {
       setState(() {
      isLoading1 = false;
      print("accountLink");
      });
    }
  }
}
