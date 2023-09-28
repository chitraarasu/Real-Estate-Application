import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate/utils/manager/font_manager.dart';

import '../utils/resizer/fetch_pixels.dart';

void showCustomToast(String texts, BuildContext context) {
  Fluttertoast.showToast(
    msg: texts,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 12.0,
  );
}

Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {String fontFamily = fontNunito,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none,
    FontWeight fontWeight = regular,
    TextAlign textAlign = TextAlign.start,
    txtHeight,
    bool horFactor = false}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
        fontFamily: fontNunito,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
    textScaleFactor: FetchPixels.getTextScale(horFactor: horFactor),
  );
}

Widget getPaddingWidget(EdgeInsets edgeInsets, {required Widget child}) {
  return Padding(
    padding: edgeInsets,
    child: child,
  );
}

Widget vSpace(double size) {
  return SizedBox(
    height: FetchPixels.getPixelHeight(size),
  );
}

Widget hSpace(double size) {
  return SizedBox(
    width: FetchPixels.getPixelWidth(size),
  );
}
