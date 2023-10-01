import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/profile/manage_places.dart';

import '../../controller/route_controller.dart';
import '../../utils/manager/color_manager.dart';
import '../../utils/manager/font_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/appbar/common_appbar.dart';
import '../../widget/buttons/secondary_button.dart';
import '../../widget/widget_utils.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  Widget getTag(title, value) {
    return Expanded(
      child: Column(
        children: [
          getCustomFont(
            title,
            12,
            darkGrey,
            1,
            fontWeight: medium,
          ),
          getCustomFont(
            value,
            18,
            darkGrey,
            1,
            fontWeight: bold,
          ),
        ],
      ),
    );
  }

  RxBool isEditMode = RxBool(false);

  @override
  Widget build(BuildContext context) {
    double radius = FetchPixels.getPixelWidth(55);
    return WillPopScope(
      onWillPop: () async {
        RouteController.to.currentPos.value = 0;
        return false;
      },
      child: Scaffold(
        appBar: CObx(
          () => CommonAppBar(
            isProfile: !isEditMode.value,
            isEditModeOn: isEditMode.value,
            onEditClick: () {
              isEditMode.value = true;
            },
            onDoneClick: () {
              isEditMode.value = false;
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                        "Profile",
                        20,
                        Colors.black,
                        1,
                        fontWeight: bold,
                      ),
                      vSpace(15),
                      vSpace(radius),
                      Stack(
                        alignment: Alignment.topCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: FetchPixels.getPixelHeight(200),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: grey,
                              ),
                            ),
                            child: Column(
                              children: [
                                vSpace(radius),
                                getCustomFont(
                                  "Mariya Elliott",
                                  18,
                                  Colors.black,
                                  1,
                                  fontWeight: bold,
                                ),
                                vSpace(5),
                                getCustomFont(
                                  "test@gmail.com",
                                  14,
                                  darkGrey,
                                  1,
                                  fontWeight: bold,
                                ),
                                Spacer(),
                                getPaddingWidget(
                                  EdgeInsets.symmetric(
                                    horizontal: FetchPixels.getPixelWidth(10),
                                  ),
                                  child: Row(
                                    children: [
                                      getTag("Your Places", "10"),
                                      getTag("Views", "10"),
                                      getTag("Likes", "10"),
                                    ],
                                  ),
                                ),
                                vSpace(20),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -radius,
                            child: Obx(
                              () => Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: radius,
                                    backgroundColor: grey,
                                    backgroundImage: const NetworkImage(
                                      "https://via.placeholder.com/400x400",
                                    ),
                                  ),
                                  if (isEditMode.value)
                                    IconButton(
                                      onPressed: () {},
                                      icon: CircleAvatar(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        backgroundColor: darkGrey,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      vSpace(15),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ManagePlaces());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: .5, color: darkGrey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: getCustomFont(
                                    "Manage Places",
                                    15,
                                    Colors.black,
                                    1,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Icon(
                                  Icons.double_arrow_rounded,
                                  color: darkGrey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: FetchPixels.getPixelHeight(8),
                horizontal: FetchPixels.getPixelHeight(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      isFromProfile: true,
                      color: darkGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CObx extends Obx implements PreferredSizeWidget {
  static final _appBar = AppBar();

  CObx(super.builder);

  @override
  Size get preferredSize => _appBar.preferredSize;
}
