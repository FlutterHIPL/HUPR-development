import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hupr_texibooking/Controller/driver_auth_controller.dart';
import 'package:hupr_texibooking/Controller/vehicle_color_controller.dart';
import 'package:hupr_texibooking/Controller/vehicle_model_controller.dart';
import 'package:hupr_texibooking/Element/common_button_widget.dart';
import 'package:hupr_texibooking/Element/custom_text_field.dart';
import 'package:hupr_texibooking/Model/VehicleColorModel.dart';
import 'package:hupr_texibooking/Model/VehicleModeAndMakeModel.dart';
import 'package:hupr_texibooking/Screens/Driver_Details_Screens/document_screen.dart';
import 'package:hupr_texibooking/Screens/SignUp_Screen/driwer_information.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/costum_widget.dart';
import 'package:hupr_texibooking/Utils/images.dart';
import 'package:hupr_texibooking/language/language_option.dart';
import 'package:hupr_texibooking/language/translete.dart';

class MyVehicleDetailsPage extends StatefulWidget {
  const MyVehicleDetailsPage({super.key});

  @override
  State<MyVehicleDetailsPage> createState() => _MyVehicleDetailsPageState();
}

class _MyVehicleDetailsPageState extends State<MyVehicleDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  DriverAuthController controller = Get.put(DriverAuthController());
  VehicleModelController vehicleModelController =
      Get.put(VehicleModelController());

  VehicleColorController vehicleColorController =
      Get.put(VehicleColorController());

  String vehicleModelDropdownvalue = languages[choosenLanguage]['text_Vehicle _model&make'];
  int vehicleModelID = 0;

  String vehicleColorsDropdownvalue = languages[choosenLanguage]['text_Vehicle_color'];
  int vehicleColrosID = 0;
  String vehicleTypeDropdownvalue =languages[choosenLanguage]['text_Vehicle_type'];
  var vehicleTypeID = "";

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: CustomScrollView(
                    slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: _formKey,
              child: Obx(
                () => vehicleModelController.isLoading.value &&
                        vehicleColorController.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                        color: appBackgroundColor,
                      ))
                    : Column(
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
                            height:
                                MediaQuery.of(context).size.height / 2 * 0.4,
                            decoration: BoxDecoration(color: fillColor),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 20),
                              child: Image.asset(Images.vehicleDetails),
                            ),
                          ),
                          heightSpace30,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
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
                                SvgPicture.asset(Images.indecatorBg),
                                Container(
                                  decoration: BoxDecoration(
                                      color: appBackgroundColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(Images.indecatorBg),
                                Container(
                                  decoration: BoxDecoration(
                                      color: appBackgroundColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Text(
                                      "3",
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(Images.indecatorBg),
                                Container(
                                  decoration: BoxDecoration(
                                      color: appBackgroundColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Text(
                                      "4",
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
                          heightSpace20,
                          Text(
                            languages[choosenLanguage]['text_Vehicle_Details'],
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: 24.0),
                          ),
                         heightSpace15,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              languages[choosenLanguage]
                                      ['text_order_to_change_these_information_later'],
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomTextField(
                              AutovalidateModes:
                                  AutovalidateMode.onUserInteraction,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.name,
                              controller:
                                  controller.vehiclePlateNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languages[choosenLanguage]['text_Vehicle_plate_number_is_required'];
                                }
                                return null;
                              },
                              obscureText: false,
                              isTrue: true,
                              isPassword: true,
                              hintText: languages[choosenLanguage]
                                      ['text_Vehicle_plate_number'],
                              onIconTap: () {},
                              capitalization: TextCapitalization.words,
                            ),
                          ),
                          heightSpace20,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child:
                              
                                CustomTextField(
                              AutovalidateModes:
                                  AutovalidateMode.onUserInteraction,
                              inputAction: TextInputAction.next,
                              inputType: TextInputType.number,
                              controller:
                                  controller.vehicleProducationYearController,
                             
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return languages[choosenLanguage][
                                          'text_Vehicle_production_year_is_required'];
                                }
                                int? year = int.tryParse(value);
                                if (year == null ||
                                    year < 2000 ||
                                    year > DateTime.now().year) {
                                  return languages[choosenLanguage][
                                          'text_The_Production_Year_least_2000'];
                                }
                
                                return null;
                              },
                              obscureText: false,
                              isTrue: true,
                              isPassword: true,
                              hintText: languages[choosenLanguage][
                                      'text_Vehicle_production_year'],
                             
                              onIconTap: () {},
                              capitalization: TextCapitalization.words,
                            ),
                          ),
                         heightSpace20,
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                
                            child: DropdownButtonFormField<Data>(
                              validator: (value) {
                                if (value == null || value.name!.isEmpty) {
                                  return languages[choosenLanguage]
                                          ['text_Vehicle_model_&_make_is_required'];
                                }
                
                                return null;
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xffF5F5FF),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 0.0),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: outlineColor,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: outlineColor),
                                    //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: outlineColor),
                                    //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: outlineColor,
                                      ))),
                              isExpanded: true,
                              hint: vehicleModelDropdownvalue == "" ||
                                      vehicleModelDropdownvalue == null
                                  ? Text(
                                      languages[choosenLanguage][
                                              'text_Vehicle _model&make'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    )
                                  : Text(
                                      vehicleModelDropdownvalue,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                              // Down Arrow Icon
                              icon: SvgPicture.asset(Images.arrowDownIcon),
                
                            
                              items: vehicleModelController.vehicleModel!.data!
                                  .map((Data option) {
                                return DropdownMenuItem<Data>(
                                  value: option,
                                  child: Text(
                                    option.name.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                );
                              }).toList(),
                
                      
                              onChanged: (val) {
                                vehicleModelID = val!.id!.toInt();
                                controller.vehicleModelID.value =
                                    vehicleModelID;
                
                                print("vehicleModelID: $vehicleModelID");
                                setState(() {});
                              },
                            ),
                
                          ),
                          heightSpace20,
                          vehicleColorController.vehicleColorModel != null
                              ? 
                              
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child:
                                      DropdownButtonFormField<VehicleColorData>(
                                    validator: (value) {
                                      if (value == null ||
                                          value.name!.isEmpty) {
                                        return languages[choosenLanguage]
                                                ['text_Vehicle_color_is_required'];
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF5F5FF),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 0.0),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: outlineColor,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: outlineColor),
                                          //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: outlineColor),
                                          //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: outlineColor,
                                            ))),
                                    isExpanded: true,
                                    // Initial Value
                                    // value: ,
                                    hint: vehicleColorsDropdownvalue == "" ||
                                            vehicleColorsDropdownvalue == null
                                        ? Text(
                                            languages[choosenLanguage][
                                                    'text_Vehicle_color'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          )
                                        : Text(
                                            vehicleColorsDropdownvalue,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          ),
                                    // Down Arrow Icon
                                    icon:
                                        SvgPicture.asset(Images.arrowDownIcon),
                
                                    // Array list of items
                                    items: vehicleColorController
                                        .vehicleColorModel!.data!
                                        .map((VehicleColorData option) {
                                      return DropdownMenuItem<VehicleColorData>(
                                        value: option,
                                        child: Text(
                                          option.name.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins"),
                                        ),
                                      );
                                    }).toList(),
                
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (val) {
                                      vehicleColrosID = val!.id!.toInt();
                                      controller.vehicleColorID.value =
                                          vehicleColrosID;
                                      print(
                                          "vehicleColrosID: $vehicleColrosID");
                                      setState(() {});
                                    },
                                  ),
                
                                  
                                )
                              : SizedBox(),
                            heightSpace20,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child:
                                      DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == null ) {
                                        return languages[choosenLanguage]
                                                ['text_Vehicle_type_is_required'];
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF5F5FF),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 0.0),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: outlineColor,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: outlineColor),
                                          //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: outlineColor),
                                          //<-- SEE HERE
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            borderSide: BorderSide(
                                              color: outlineColor,
                                            ))),
                                    isExpanded: true,
                                    // Initial Value
                                    // value: ,
                                    hint: vehicleTypeDropdownvalue == "" ||
                                            vehicleTypeDropdownvalue == null
                                        ? Text(
                                            languages[choosenLanguage][
                                                    'text_Select_type'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          )
                                        : Text(
                                            vehicleTypeDropdownvalue,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins"),
                                          ),
                                    // Down Arrow Icon
                                    icon:
                                        SvgPicture.asset(Images.arrowDownIcon),
                
                                    // Array list of items
                                    items: vehicleColorController
                                        .vehicleItem
                                        .map((data) {
                                      return DropdownMenuItem(
                                        value: data["id"].toString(),
                                        child: Text(
                                          data["name"].toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins"),
                                        ),
                                      );
                                    }).toList(),
                
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (val) {
                                      vehicleTypeID = val.toString();
                                      controller.driverTypeID.value =
                                          vehicleTypeID;
                                      print(
                                          "vehicleTypeID: $vehicleTypeID");
                                      setState(() {});
                                    },
                                  ),
                
                                  
                                ),
                             
                         heightSpace20,
                          Spacer(),
                      controller.isLoadingApi.value?
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: CustomButton(
                                isVisible: true,
                                btnName: languages[choosenLanguage]
                                        ['text_Confirm'],
                                onPressed: () {
                                  if (_formKey.currentState!.validate())
                                   
                                    controller
                                          .TaxiNumberCheckApi();
                
                                
                                },
                              )),
                          heightSpace20,
                        ],
                      ),
              ),
            ),
          ),
                    ],
                  ),
        ),
      ),
    );
  }
}
