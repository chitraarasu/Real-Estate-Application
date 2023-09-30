import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/controller/route_controller.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/utils/resizer/fetch_pixels.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../../widget/buttons/secondary_button.dart';

class CDrawer extends StatelessWidget {
  const CDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: getPaddingWidget(
          EdgeInsets.all(FetchPixels.getPixelWidth(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomBack(
                    onBack: () {
                      RouteController.to.zoomDrawerController.close!();
                    },
                    color: Colors.white,
                  ),
                ],
              ),
              Spacer(),
              Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DrawerTile<String>(
                      "home",
                      "Home",
                      isActive: RouteController.to.currentPos.value == 0,
                      onTap: () {
                        RouteController.to.zoomDrawerController.close!();
                        RouteController.to.currentPos.value = 0;
                      },
                    ),
                    DrawerTile<IconData>(
                      Icons.add_box_rounded,
                      "Your Places",
                      isActive: RouteController.to.currentPos.value == 1,
                      onTap: () {
                        RouteController.to.zoomDrawerController.close!();
                        RouteController.to.currentPos.value = 1;
                      },
                    ),
                    DrawerTile<String>(
                      "profile",
                      "Profile",
                      isActive: RouteController.to.currentPos.value == 2,
                      onTap: () {
                        RouteController.to.zoomDrawerController.close!();
                        RouteController.to.currentPos.value = 2;
                      },
                    ),
                    DrawerTile<String>(
                      "heart",
                      "Favorites",
                      isActive: RouteController.to.currentPos.value == 3,
                      onTap: () {
                        RouteController.to.zoomDrawerController.close!();
                        RouteController.to.currentPos.value = 3;
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  SecondaryButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTile<T> extends StatelessWidget {
  final T icon;
  final String title;
  final bool isActive;
  final Function()? onTap;

  DrawerTile(this.icon, this.title, {this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return getPaddingWidget(
      EdgeInsets.symmetric(
        vertical: FetchPixels.getPixelHeight(8),
        horizontal: FetchPixels.getPixelWidth(3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: Ink(
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: !isActive ? null : Colors.white.withOpacity(.2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (icon == "heart") hSpace(3),
                      icon.runtimeType == String
                          ? ImageIcon(
                              AssetImage(icon.toString().png),
                              color: Colors.white,
                              size: FetchPixels.getPixelHeight(
                                icon == "heart" ? 17 : 20,
                              ),
                            )
                          : Icon(
                              icon as IconData,
                              color: Colors.white,
                              size: FetchPixels.getPixelHeight(22),
                            ),
                      hSpace(20),
                      getCustomFont(title, 18, Colors.white, 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
