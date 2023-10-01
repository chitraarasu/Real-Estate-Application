import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/utils/manager/color_manager.dart';
import 'package:real_estate/utils/manager/font_manager.dart';

import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/home_card.dart';
import '../../widget/search.dart';
import '../../widget/widget_utils.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool selectedTab = RxBool(true);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(8),
            horizontal: FetchPixels.getPixelHeight(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSpace(10),
              Row(
                children: [
                  Expanded(
                    child: Search(enable: true),
                  ),
                  hSpace(10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: getCustomFont(
                      "Cancel",
                      15,
                      darkBlue,
                      1,
                      fontWeight: medium,
                    ),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      vSpace(16),
                      Obx(
                        () => AnimatedToggleSwitch<bool>.size(
                          current: selectedTab.value,
                          values: const [true, false],
                          indicatorSize: const Size.fromWidth(double.infinity),
                          customIconBuilder: (context, local, global) => Text(
                            (local.value ? 'For Sale' : 'For Rent').tr,
                            style: TextStyle(
                              color: Color.lerp(
                                Colors.black,
                                Colors.black,
                                local.animationValue,
                              ),
                              fontSize: 15,
                            ),
                          ),
                          borderWidth: 5.0,
                          iconAnimationType: AnimationType.onSelected,
                          style: ToggleStyle(
                            indicatorColor: white,
                            backgroundColor: Color(0xFFebebec),
                            borderColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          selectedIconScale: 1.0,
                          height: 45,
                          onChanged: (b) {
                            selectedTab.value = b;
                          },
                        ),
                      ),
                      vSpace(5),
                      Divider(
                        thickness: .5,
                        color: grey,
                      ),
                      vSpace(5),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: grey,
                          ),
                          hSpace(10),
                          getCustomFont(
                            "Current Location",
                            15,
                            Colors.black,
                            1,
                            fontWeight: semiBold,
                          ),
                          Spacer(),
                          Icon(
                            Icons.check,
                            color: darkBlue,
                          ),
                        ],
                      ),
                      vSpace(5),
                      Divider(
                        thickness: .5,
                        color: grey,
                      ),
                      vSpace(5),
                      ListView.builder(
                        itemCount: 20,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
