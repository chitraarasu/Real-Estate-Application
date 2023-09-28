import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:real_estate/controller/route_controller.dart';
import 'package:real_estate/screens/dashboard/c_drawer.dart';
import 'package:real_estate/screens/home/home.dart';
import 'package:real_estate/screens/new_home/new_home.dart';
import 'package:real_estate/screens/profile/profile.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../utils/manager/color_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  RxInt currentPos = RxInt(0);

  List<dynamic> bottomBarList = [
    {
      "icon": "home".png,
      "title": "Home",
    },
    Icons.add,
    {
      "icon": "profile".png,
      "title": "Profile",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: RouteController.to.zoomDrawerController,
      menuScreen: const CDrawer(),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
      drawerShadowsBackgroundColor: darkBlue,
      menuBackgroundColor: darkBlue,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      mainScreen: Scaffold(
        body: Obx(
          () => currentPos.value == 0
              ? const Home()
              : currentPos.value == 1
                  ? const NewHome()
                  : const Profile(),
        ),
        bottomNavigationBar: buildBottomBar(
          FetchPixels.getPixelHeight(40),
          FetchPixels.getPixelHeight(24),
        ),
      ),
    );
  }

  Container buildBottomBar(double size, double iconSize) {
    return Container(
        height: FetchPixels.getPixelHeight(80),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 50,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Obx(
          () => Row(
              children: List.generate(bottomBarList.length, (index) {
            return Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  currentPos.value = index;
                },
                child: Center(
                  child: Container(
                    width: index == 1 ? size : null,
                    height: index == 1 ? size : null,
                    decoration: BoxDecoration(
                      color: index == 1 ? darkBlue : Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: index == 1
                          ? Icon(
                              bottomBarList[index],
                              color: index == 1 ? Colors.white : null,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                    bottomBarList[index]["icon"],
                                  ),
                                  color:
                                      currentPos.value == index ? black : grey,
                                ),
                                getCustomFont(
                                  bottomBarList[index]["title"],
                                  10,
                                  currentPos.value == index ? black : grey,
                                  1,
                                )
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            );
          })),
        ));
  }
}
