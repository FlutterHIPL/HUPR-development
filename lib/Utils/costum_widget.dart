import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hupr_texibooking/Element/common_indecator_widget.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/images.dart';

class CustomWidget{


void showToast(BuildContext context, {String? msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg.toString()),
        duration: Duration(seconds: 3),
      ),
    );
  }

CustomBack({
    required Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.all(10),
        width: 35,
        height: 35,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: SvgPicture.asset(Images.backIcon),
      ),
    );
  }


CustombackButton({
    required Function()? onPressed,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: onPressed, child: SvgPicture.asset(Images.backIcon)),
              heightSpace20,
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, bottom: 20, top: 15),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: blackTextColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }


  CustomButtonLoader({
    double? height,
    double? vertical,
    
  }) {
    return Container(
        height: height ?? 50,
        margin:
            EdgeInsets.symmetric(horizontal: 15.0, vertical: vertical ?? 10),
        decoration: BoxDecoration(
          color: appBackgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
          child: Center(
            child: SizedBox(
              width: 25,
              height: 25,
              child:
                  CircularProgressIndicator(strokeWidth: 3, color: whiteColor),
            ),
          ),
        ));
  }



  CustomTextWidget(
    {
      required String text,
      double? textsize,
      Color textColor = Colors.black,
      FontWeight fontWeight =FontWeight.w100,
      
    }
  ){

      return  Text(
              text,
              style: TextStyle(
                  color: textColor == appBackgroundColor ? whiteColor : textColor,
                  fontFamily: "Poppins",
                  fontWeight: fontWeight,
                  fontSize: textsize),
                  textAlign: TextAlign.center,
            );

  }
 
  
  Widget buildMaterialBtn({
    required String text,
    required Function()? onPressed,
    double? height,
    double? minWidth,
    double? radius,
    Color textColor = Colors.black,
    Color color = Colors.white,
  }) {
    return MaterialButton(
      height: height ?? 45,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 5),
      ),
      elevation: 1,
      minWidth: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Acumin Pro',
          fontWeight: FontWeight.w700,
          color: color == appBackgroundColor
              ? whiteColor
              : textColor,
          fontSize: 16,
        ),
      ),
    );
  }

               


}

const widthSpace5=SizedBox(width: 5, );
const widthSpace10=SizedBox(width: 10, );
const widthSpace20=SizedBox(width: 20, );
const widthSpace30=SizedBox(width: 30, );
const widthSpace40 = SizedBox(
  width: 40,
);
const widthSpace50 = SizedBox(
  width: 50,
);

const heightSpace5 = SizedBox(height: 5,);
const heightSpace10=SizedBox(height: 10, );
const heightSpace15 = SizedBox( height: 15,);
 const heightSpace20=SizedBox(height: 20, );
  const heightSpace30=SizedBox(height: 30, );
   const heightSpace40=SizedBox(height: 40, );
    const heightSpace50=SizedBox(height: 50, );