import 'package:flutter/material.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../widget/first_appbar.dart';
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
            FirstAppBar(title: title),
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
