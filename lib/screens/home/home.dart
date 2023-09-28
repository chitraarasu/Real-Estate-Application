import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/home/vm_home.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/search.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../controller/route_controller.dart';
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
              icon: Image.asset(
                "heart_active".png,
                width: FetchPixels.getPixelWidth(20),
                height: FetchPixels.getPixelHeight(20),
                color: darkBlue,
                scale: FetchPixels.getScale(),
              ),
            ),
          ),
        ],
      ),
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
              Search(enable: false),
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
                height: FetchPixels.getPixelHeight(210),
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
                height: FetchPixels.getPixelHeight(210),
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
