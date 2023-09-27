import 'package:flutter/material.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/widget_utils.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Image(
          image: AssetImage("menu".png),
          color: Colors.black,
          width: 30,
          height: 30,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(8),
          horizontal: FetchPixels.getPixelHeight(16),
        ),
        child: Column(
          children: [
            getCustomFont(
              "Hi, There!",
              20,
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
