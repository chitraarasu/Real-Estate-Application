import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../utils/manager/color_manager.dart';
import '../utils/manager/font_manager.dart';
import '../utils/resizer/fetch_pixels.dart';

class FirstAppBar extends StatelessWidget {
  final String title;

  const FirstAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        height: FetchPixels.getPixelHeight(60),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4, bottom: 4, right: 4, left: 1),
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: darkGrey,
                                size: FetchPixels.getPixelHeight(20),
                              ),
                              hSpace(3),
                              getCustomFont(
                                "Back",
                                14,
                                darkGrey,
                                1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            getCustomFont(
              title,
              19,
              Colors.black,
              1,
              fontWeight: bold,
            ),
          ],
        ),
      ),
    );
  }
}
