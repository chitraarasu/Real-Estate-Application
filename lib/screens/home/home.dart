import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/home/search_screen.dart';
import 'package:real_estate/screens/home/vm_home.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/search.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../controller/route_controller.dart';
import '../../widget/appbar/common_appbar.dart';
import '../../widget/category_chip.dart';
import '../../widget/home_card.dart';
import 'home_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  VMHome vmHome = VMHome.to;
  RxnInt selectedCategory = RxnInt();

  Widget getTitle(String title, {bool isRent = false}) {
    return Row(
      children: [
        Expanded(
          child: getCustomFont(
            title,
            20,
            Colors.black,
            1,
            fontWeight: bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => HomeList(title, isRent));
          },
          child: getCustomFont(
            "View all",
            12,
            Colors.black,
            1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    RouteController routeController = Get.find();
    return Scaffold(
      appBar: const CommonAppBar(isHome: true),
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
                "Hi, There!",
                20,
                Colors.black,
                1,
                fontWeight: bold,
              ),
              vSpace(15),
              GestureDetector(
                  onTap: () {
                    Get.to(() => SearchScreen());
                  },
                  child: Search(enable: false)),
              vSpace(12.5),
              Transform.translate(
                offset: const Offset(-8, 0),
                child: SizedBox(
                  height: FetchPixels.getPixelHeight(112.5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vmHome.category.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => CategoryChip(
                          vmHome.category[index],
                          index == selectedCategory.value,
                          () {
                            if (selectedCategory.value == index) {
                              selectedCategory.value = null;
                            } else {
                              selectedCategory.value = index;
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              vSpace(10),
              getTitle("Buy a home"),
              vSpace(15),
              SizedBox(
                height: FetchPixels.getPixelHeight(220),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vmHome.category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeCard();
                  },
                ),
              ),
              vSpace(25),
              getTitle(
                "Rent a home",
                isRent: true,
              ),
              vSpace(15),
              SizedBox(
                height: FetchPixels.getPixelHeight(220),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vmHome.category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeCard();
                  },
                ),
              ),
              vSpace(25),
            ],
          ),
        ),
      ),
    );
  }
}
