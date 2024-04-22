import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hupr_texibooking/Utils/auth.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyMapSettingPage extends StatefulWidget {
  const MyMapSettingPage({super.key});

  @override
  State<MyMapSettingPage> createState() => _MyMapSettingPageState();
}

class _MyMapSettingPageState extends State<MyMapSettingPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  int selectedRadio=2;
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
      box.write("mapType", val);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mapType() != "") {
      selectedRadio =int.parse(mapType().toString()) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(Images.backIcon)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    languages[choosenLanguage]['text_Map_Settings'],
                    style: TextStyle(
                        color: blackTextColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            heightSpace20,
            Expanded(
                child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 25,bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                 
                  // height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        
                        child: GoogleMap(
                           zoomControlsEnabled: false,
                          mapType:
                              index == 0 ? MapType.hybrid : MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(26.905344, 75.7387577),
                            zoom: 16,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Spacer(),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: whiteColor,
                                    border: Border.all(
                                        color: outlineColor, width: 2)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Images.mapSettingsIcon),
                                    widthSpace10,
                                    Text(
                                      languages[choosenLanguage]['text_MapBox'],
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    index == 0
                                        ? Radio(
                                            value: 1,
                                            groupValue: selectedRadio,
                                            activeColor: greenColor,
                                            onChanged: (val) {
                                              setState(() {
                                                print(
                                                    "Index11 ${selectedRadio}");

                                                setSelectedRadio(val!);
                                              });
                                            },
                                          )
                                        : Radio(
                                            value: 2,
                                            groupValue: selectedRadio,
                                            activeColor: greenColor,
                                            onChanged: (val) {
                                              setState(() {
                                                print(
                                                    "Index22 ${selectedRadio}");

                                                setSelectedRadio(val!);
                                              });
                                            },
                                          ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: whiteColor,
                                    border: Border.all(
                                        color: outlineColor, width: 2)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(Images.tickRightIcon),
                                        widthSpace10,
                                        Text(
                                          languages[choosenLanguage]
                                              ['text_Attractive_design'],
                                          style: TextStyle(
                                              color: blackTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    heightSpace10,
                                    Row(
                                      children: [
                                        SvgPicture.asset(Images.tickRightIcon),
                                        widthSpace10,
                                        Text(
                                          languages[choosenLanguage]
                                              ['text_Good_performance'],
                                          style: TextStyle(
                                              color: blackTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    heightSpace10,
                                    Row(
                                      children: [
                                        SvgPicture.asset(Images.crosscircle),
                                        widthSpace10,
                                        Text(
                                          languages[choosenLanguage]
                                              ['text_Expensive'],
                                          style: TextStyle(
                                              color: blackTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
