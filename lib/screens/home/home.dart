import 'package:flutter/material.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/search.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../controller/route_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            RouteController.to.toggleDrawer();
          },
          icon: ImageIcon(
            AssetImage("menu".png),
            size: 37.5,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {},
              icon: Image(
                image: AssetImage("heart_active".png),
                // size: 37.5,
                width: 25,
                height: 25,
                color: darkBlue,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(8),
          horizontal: FetchPixels.getPixelHeight(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCustomFont(
              "Hi, There!",
              20,
              Colors.black,
              1,
              fontWeight: bold,
            ),
            SizedBox(
              height: FetchPixels.getPixelHeight(15),
            ),
            Search(
              (val) {},
              TextEditingController(),
            ),
          ],
        ),
      ),
    );
  }
}
