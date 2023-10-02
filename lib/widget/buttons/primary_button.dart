import 'package:flutter/material.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';

import '../widget_utils.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final double? radius;
  final EdgeInsets? padding;
  final Function()? onTap;

  PrimaryButton(this.title, {this.radius, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: darkBlue,
        // side: const BorderSide(color: Colors.white, width: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 30.0),
        ),
        textStyle: const TextStyle(color: Colors.white),
      ),
      onPressed: onTap,
      child: getPaddingWidget(
        padding ??
            EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(12),
              horizontal: FetchPixels.getPixelWidth(17),
            ),
        child: getCustomFont(
          title,
          16,
          Colors.white,
          1,
          fontWeight: bold,
        ),
      ),
    );
  }
}
