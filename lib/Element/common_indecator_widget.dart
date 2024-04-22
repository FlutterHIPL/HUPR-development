import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hupr_texibooking/Utils/colors.dart';
import 'package:hupr_texibooking/Utils/images.dart';

Widget CommonIndicatorWidget() {
  return Container(
    width: 45.0,
    height: 4.0,
    decoration: BoxDecoration(
        color: indicatorColor, borderRadius: BorderRadius.circular(40.0)),
  );
}

Widget CommonRunningCarIndicatorWidget() {
  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 45.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: appBackgroundColor,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                      SvgPicture.asset(Images.runningCarImage)
                    ],
                  );
}
