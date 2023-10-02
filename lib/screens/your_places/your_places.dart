import 'package:flutter/material.dart';
import 'package:real_estate/controller/route_controller.dart';

import '../../utils/manager/font_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/appbar/common_appbar.dart';
import '../../widget/home_card.dart';
import '../../widget/widget_utils.dart';

class YourPlaces extends StatelessWidget {
  const YourPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RouteController.to.currentPos.value = 0;
        return false;
      },
      child: Scaffold(
        appBar: CommonAppBar(isMyPlace: true),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(8),
              horizontal: FetchPixels.getPixelHeight(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getCustomFont(
                  "Your Places",
                  20,
                  Colors.black,
                  1,
                  fontWeight: bold,
                ),
                vSpace(15),
                ListView.builder(
                  itemCount: 20,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 6),
                  itemBuilder: (BuildContext context, int index) {
                    return getPaddingWidget(
                      EdgeInsets.only(
                        bottom: FetchPixels.getPixelHeight(20),
                      ),
                      child: HomeCard(
                        isDetailedList: true,
                        isMyPlaceList: true,
                        onTap: () {},
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
