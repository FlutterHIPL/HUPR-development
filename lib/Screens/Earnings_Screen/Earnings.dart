
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Utils/app_constants.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/api_provider.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {


  String switchkey = "Monthly";
  var totalEarnings="";
  int distance = 0;
  int time_spent = 0;
  int total_ride=0;
  int index=0;
  bool isLoading=false;

    var formatterDate = DateFormat('dd MMMM');
    var formatterDate1 = DateFormat('yyyy-MM-dd');
    var formatterDay = DateFormat('d');
    DateTime selectedDate = DateTime.now();
    var date="";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        date=formatterDate.format(picked).toString();
         myEarningApi(
            "daily",formatterDate1.format(picked)
               );
      });
    }
  }






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
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
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 176,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(25),
                            // border: Border.all(color: outlineColor, width: 2)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 180,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: outlineColor, width: 2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              switchkey = "Monthly";
  myEarningApi(
                                                  "monthly",
                                                  monthsList[index]
                                                      .id
                                                      .toString());
                                            });
                                            
                                          },
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: switchkey == "Monthly"
                                                    ? fillColor
                                                    : whiteColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(9),
                                                    bottomLeft:
                                                        Radius.circular(9))),
                                            child: Text(
                                              languages[choosenLanguage]
                                                    ['text_Monthly'],
                                                style: TextStyle(
                                                    color:
                                                        switchkey == "Monthly"
                                                            ? appBackgroundColor
                                                            : blackTextColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                textAlign: TextAlign.center),
                                          )),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 2,
                                      color: outlineColor,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              switchkey ="Daily";
                                                  myEarningApi("daily", 
                                                  formatterDate1.format(selectedDate)
                                                 );
                                            });
                                           
                                          },
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: switchkey == "Daily"
                                                    ? fillColor
                                                    : whiteColor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(9),
                                                    bottomRight:
                                                        Radius.circular(9))),
                                            child: Text(
                                               languages[choosenLanguage]['text_Daily'],
                                              style: TextStyle(
                                                  color: switchkey == "Daily"
                                                      ? appBackgroundColor
                                                      : blackTextColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                    ),
                               
                               
                               
                                  ],
                                ),
                              ),
                            switchkey == "Monthly"  ?
                               Container(
                                 color: whiteColor,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                      GestureDetector(
                                           onTap: () {
                                            setState(() {
                                              if(index>0){
                                              index--;
                                               myEarningApi(
                                                        "monthly", monthsList[index]
                                                            .id.toString());
                                              }
                                            });
                                            
                                           },child: SvgPicture.asset(Images.arrow_left)),
                                     widthSpace20,
                                     Column(
                                       children: [
                                         Text(
                                           "${language()=='en' || language() == '' ?monthsList[index].monthsvalues: monthsList[index].dutchlag}",
                                           style: TextStyle(
                                               color: blackTextColor,
                                               fontSize: 16,
                                               fontWeight: FontWeight.w600),
                                           textAlign: TextAlign.center,
                                         ),
                                        if (totalEarnings.toString() !=
                                                  "") Text(
                                           "EUR ${totalEarnings.toString()}",
                                           style: TextStyle(
                                               color: blackTextColor,
                                               fontSize: 21,
                                               fontWeight: FontWeight.w700),
                                           textAlign: TextAlign.center,
                                         ),
                                       ],
                                     ),
                                     widthSpace20,
                                     GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                   if (index < 11){
                                                  index++;
                                                   myEarningApi("monthly",
                                                        monthsList[index].id
                                                            .toString());
                                                   }
                                                });
                                                
                                              },
                                              child: SvgPicture.asset(Images.arrow_right))
                                   ],
                                 ),
                               ):
                           
                              
                               GestureDetector(
                                onTap: () {
                                  selectDate(context);
                                },
                                child: Container(
                                  color: whiteColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(Images.arrow_left),
                                      widthSpace20,
                                      Column(
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              selectDate(context);
                                            },
                                            child: Text(
                                              "${date==""?formatterDate.format(selectedDate):date}",
                                              style: TextStyle(
                                                  color: blackTextColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        if(totalEarnings.toString() !=
                                                    "")  Text(
                                            "EUR ${ totalEarnings.toString()}",
                                            style: TextStyle(
                                                color: blackTextColor,
                                                fontSize: 21,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      widthSpace20,
                                      SvgPicture.asset(Images.arrow_right)
                                    ],
                                  ),
                                ),
                              ),
                           
                           
                            ],
                          )),
                    ],
                  ),
                ),
              if(totalEarnings.toString() !="")  
              Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 268),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                languages[choosenLanguage]
                                                    ['text_Total_rides'],
                                style: TextStyle(
                                    color: hintTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(Images.totalRideIcon),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${total_ride}",
                                    style: TextStyle(
                                        color: greyTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                              width: 2,
                              decoration: BoxDecoration(
                                color: outlineColor,
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                languages[choosenLanguage]['text_Distance_traveled'],
                                style: TextStyle(
                                    color: hintTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(Images.distanceTraveled),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$distance KM",
                                    style: TextStyle(
                                        color: greyTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                              width: 2,
                              decoration: BoxDecoration(
                                color: outlineColor,
                              )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                languages[choosenLanguage]['text_Time_spent'],
                                style: TextStyle(
                                    color: hintTextColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                                textAlign: TextAlign.center,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.clockIcon,
                                    color: Color(0xffA3CCFE),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$time_spent",
                                    style: TextStyle(
                                        color: greyTextColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
        
              
        isLoading == true
                ? Container(
                   alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
           child:    Column(
            children: [
            totalEarnings.toString() != ""? 
            Expanded(
                 child:  Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, left: 25),
                          width: Get.width * 0.2,
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 20,
                                child: Text(
                                  "\$1000.00  +",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                  height: 20,
                                child: Text(
                                  "\$1000.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                  height: 20,
                                child: Text(
                                  "\$900.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                  height: 20,
                                child: Text(
                                  "\$800.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            Container(
                                  height: 20,
                                child: Text(
                                  "\$700.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                             Container(
                                  height: 20,
                                child: Text(
                                  "\$600.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                             Container(
                                  height: 20,
                                child: Text(
                                  "\$500.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                  height: 20,
                                child: Text(
                                  "\$400.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                  height: 20,
                                child: Text(
                                  "\$300.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                             Container(
                                  height: 20,
                                child: Text(
                                  "\$200.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                             Container(
                                  height: 20,
                                child: Text(
                                  "\$100.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  "\$0.00",
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        switchkey == "Monthly" ? earningMethods() : earningMethods1(),
                      ],
                    ),
                         
               )
                   : Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: Get.height*0.3,
                          child: Image.asset(Images.earning_record)),
                        heightSpace20,
                        Text(
                          languages[choosenLanguage]['text_No_trip_record_found_for_these_filters'],
                          style: TextStyle(
                              color: greyTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                   
            ],
                   ),
         )
          ],
        ),
      ),
    );
  }



  myEarningApi( var type,date) async {
    setState(() {
      isLoading=true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("id");
    var authToken = prefs.getString("token");
    var body={
            "driver_id": userId.toString(),
            "type": type.toString(),
            "earning_by": date.toString(),
            
            
             };
    print("myEarningApi $body");
        try{
          var response=await ApiProvider().postRequest1(apiUrl:AppConstants.myearning,data: body ,authToken:authToken);
          
        print("myearning $response");

          if (response["status"]=true) {
        print("myearningif ");
            if(response['data'].length!=0){
              print("myearningdata ${double.parse(response['data']["totalEarnings"].toString()).toStringAsFixed(2)}");
            setState(() {
            distance = 0;
            time_spent = 0;
            total_ride=0;
            totalEarnings="";
            totalEarnings =double.parse(response['data']["totalEarnings"].toString()).toStringAsFixed(2);
            total_ride=int.parse(response['data']["totalBookings"].toString());
            distance=int.parse(response['data']["totalDistance"].toString());
            time_spent=int.parse(response['data']["totalTimeSpent"].toString());
              isLoading = false;
             
             });
            }
            else{
            setState(() {
               print("myearningelsedata ");
               totalEarnings = "";
            distance = 0;
            time_spent = 0;
            total_ride = 0;
             isLoading = false;
          });
            }
          }
          else{
        print("myearningelse ");
        setState(() {
           totalEarnings = "";
          distance = 0;
           time_spent = 0;
           total_ride = 0;
            isLoading = false;
        });
          }
        }catch(e){
          setState(() {
             isLoading = false;
          });
          print("myearning11 ${e.toString()}");
        }
  }

    earningMethods(){
      return  Container(
                      height: 355,
                      width: Get.width*0.72,
                      child: ListView.builder(
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index1) {
                            int ss = double.parse(totalEarnings.toString()).toInt();

                            return 
                            
                            Container(
                              
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 15,
                                        height: ss == 0? 0: ss <= 50 ? 20: ss<=100?40: ss <=150?50:
                                        ss <=200?68:ss <=250?80:ss <=300?100: ss <= 350? 115:
                                        ss <= 400? 130: ss <= 450? 145 : ss <= 500? 160: 
                                        ss <= 550 ? 175: ss <= 600 ? 190: ss <= 650? 205: 
                                        ss <= 700? 220 : ss <= 750? 235: ss <= 800? 250:
                                        ss <= 850 ? 265: ss <= 900 ? 280: ss <= 950 ? 291 :
                                        ss <= 1000 ? 310 :ss <= 1050 ? 320 : 337,
                                        decoration: BoxDecoration(
                                            color: appBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      SizedBox(height: 5,),
                                    if (ss != 0)
                        Transform.rotate(
                          angle: 5.7,
                          child: Text(
                            "${monthsList[index].monthsvalues.toString()}",
                            style: TextStyle(
                                color: greyTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                                      
                                    ],
                                  ),
                                  widthSpace30,
                                ],
                              ),
                            );
                          
                          
                          
                          }),
                    );
                
    }

earningMethods1() {
    return Container(
      height: 355,
      width: Get.width * 0.72,
      child: ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
           
            int ss =
                double.parse(totalEarnings.toString())
                    .toInt();





           
            return  Container(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 15,
                        height: ss==0?0: ss <= 50 ? 20: ss<=100?40: ss <=150?50: ss <= 200? 67
                        : ss <= 250? 80: ss <= 300 ? 100: ss <= 350 ? 115: ss <= 400? 130:
                        ss <= 450? 145: ss <= 500? 160: ss <= 550 ? 175: ss <= 600? 190: 
                        ss <= 650? 205 : ss <= 700? 220: ss <= 750? 235: ss <= 800? 250:
                        ss <= 850? 265:ss <= 900? 280:ss <= 950? 292:ss <= 1000? 310:
                        ss <= 1050? 325:338,
                        decoration: BoxDecoration(
                            color: appBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    SizedBox(height: 5,),
                   if (ss != 0)   Transform.rotate(
                        angle: 5.7,
                        child: Text(
                         "${language()=="en" || language() == "" ? DateFormat(DateFormat.WEEKDAY).format(selectedDate):
                         DateFormat(DateFormat.WEEKDAY).format(selectedDate)=="Monday"?"Maandag":
                         DateFormat(DateFormat.WEEKDAY).format(selectedDate)=="Tuesday"?"Dinsdag":
                         DateFormat(DateFormat.WEEKDAY).format(selectedDate)=="Wednesday"?"Woensdag":
                         DateFormat(DateFormat.WEEKDAY).format(selectedDate)=="Thursday"?"Donderdag":
                         DateFormat(DateFormat.WEEKDAY).format(selectedDate)=="Friday"?"Vrijdag":
                         DateFormat(DateFormat.WEEKDAY).format(selectedDate)=="Saturday"?"Zaterdag":"Zondag" 
                         }",
                          style: TextStyle(
                              color: greyTextColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    
                    ],
                  ),
                  widthSpace30,
                ],
              ),
            );
       }),
    );
  }


}



class months{
  int id;
  String monthsvalues;
  String dutchlag;

  months({
    required this.id,
    required this.monthsvalues,
     required this.dutchlag,

  });
}
final monthsList = [
  months(
    id: 01,
    monthsvalues: 'January',
    dutchlag: 'Januari'
    ),
     months(
    id: 02,
    monthsvalues: 'February',
    dutchlag: 'Februari'
  ),
   months(
    id: 03,
    monthsvalues: 'March',
     dutchlag: 'Maart'
  ),
   months(
    id: 04,
    monthsvalues: 'April',
     dutchlag: 'April'
  ),
   months(
    id: 05,
    monthsvalues: 'May',
     dutchlag: 'Kunnen'
    ),
     months(
    id: 06,
    monthsvalues: 'June',
     dutchlag: 'Juni'
  ),
   months(
    id: 07,
    monthsvalues: 'July',
     dutchlag: 'Juli'
  ),
   months(
    id: 08,
    monthsvalues: 'August',
     dutchlag: 'Augustus'
  ),
   months(
    id: 09,
    monthsvalues: 'September',
     dutchlag: 'September'
  ),
   months(
    id: 10,
    monthsvalues: 'October',
     dutchlag: 'Oktober'
  ),
   months(
    id: 11,
    monthsvalues: 'November',
     dutchlag: 'November'
  ),
   months(
    id: 12,
    monthsvalues: 'December',
     dutchlag: 'December'
  ),
];
 