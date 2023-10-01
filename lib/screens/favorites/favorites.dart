import 'package:flutter/material.dart';
import 'package:real_estate/controller/route_controller.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';

import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/home_card.dart';
import '../../widget/widget_utils.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RouteController.to.currentPos.value = 0;
        return false;
      },
      child: Scaffold(
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
                title: "Favorites",
                onBack: () {
                  RouteController.to.currentPos.value = 0;
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
