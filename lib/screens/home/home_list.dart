import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/home/map_view.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../widget/appbar/first_appbar.dart';
import '../../widget/home_card.dart';

class HomeList extends StatelessWidget {
  final String title;
  final bool isRent;

  HomeList(this.title, this.isRent);

  @override
  Widget build(BuildContext context) {
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: 15);
    return Scaffold(
      body: getPaddingWidget(
        edgeInsets,
        child: Column(
          children: [
            FirstAppBar(
              title: title,
              action: IconButton(
                onPressed: () {
                  Get.to(() => MapView());
                },
                icon: CircleAvatar(
                  backgroundColor: darkBlue,
                  child: Icon(
                    Icons.map_rounded,
                    color: white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                padding: EdgeInsets.only(top: 6),
                itemBuilder: (BuildContext context, int index) {
                  return getPaddingWidget(
                    EdgeInsets.only(
                      bottom: FetchPixels.getPixelHeight(20),
                    ),
                    child: HomeCard(
                      isDetailedList: true,
                      isRentList: isRent,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
