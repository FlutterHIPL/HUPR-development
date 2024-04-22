import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/images.dart';

class CustomButton extends StatelessWidget {
  final String? btnName;
  final VoidCallback? onPressed;
  final bool? isVisible;
  // final Color? buttonColor;

  const CustomButton({
    Key? key,
    required this.btnName,
    required this.onPressed,
    this.isVisible,
    // this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
          decoration: BoxDecoration(
            color: appBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    btnName!,
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Nunito Sans'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  isVisible == false
                      ? SvgPicture.asset(Images.rightArrowIcon)
                      : SizedBox()
                ],
              ),
            ),
          )),
    );

    //  InkWell(
    //   onTap: onPressed,
    //   child: Container(
    //     height: 50,
    //     width: double.infinity,
    //     decoration: BoxDecoration(
    //         color: appBackgroundColor,
    //         shape: BoxShape.rectangle,
    //         borderRadius: BorderRadius.circular(5)),
    //     child: Center(
    //         child: Text(
    //       btnName!,
    //       style: TextStyle(
    //           color: whiteColor,
    //           fontSize: 18,
    //           fontWeight: FontWeight.w700,
    //           fontFamily: 'Nunito Sans'),
    //     )),
    //   ),
    // );
  }
}
