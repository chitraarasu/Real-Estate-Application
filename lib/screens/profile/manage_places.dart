import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';

import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/home_card.dart';
import '../../widget/widget_utils.dart';

class ManagePlaces extends StatelessWidget {
  const ManagePlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: FetchPixels.getPixelHeight(8),
          horizontal: FetchPixels.getPixelHeight(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstAppBar(
              title: "Manage Places",
              onBack: () {
                Get.back();
              },
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
                    child: const HomeCard(
                      isDetailedList: true,
                      isManagePlaceList: true,
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
