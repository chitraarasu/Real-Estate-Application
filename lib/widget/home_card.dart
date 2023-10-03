import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/login/login_screen.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../screens/home/home_detail_view.dart';
import '../screens/login/vm_login.dart';
import '../utils/manager/color_manager.dart';
import '../utils/manager/font_manager.dart';
import '../utils/resizer/fetch_pixels.dart';

class HomeCard extends StatelessWidget {
  final bool isDetailedList;
  final bool isRentList;
  final bool isMyPlaceList;
  final bool isManagePlaceList;
  final Function()? onTap;

  const HomeCard({
    super.key,
    this.isDetailedList = false,
    this.isRentList = false,
    this.isMyPlaceList = false,
    this.isManagePlaceList = false,
    this.onTap,
  });

  Widget getIconText(IconData iData, String text) {
    return Row(
      children: [
        Icon(
          iData,
          size: isDetailedList ? 18 : 16,
          color: green,
        ),
        hSpace(3),
        getCustomFont(text, isDetailedList ? 13 : 11, darkGrey, 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final vmLoginData = Get.find<VMLogin>();

    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          Get.to(() =>
              HomeDetailView(
                isManagePlaceList: isManagePlaceList,
              ));
        } else {
          onTap!();
        }
      },
      child: Container(
        width:
        isDetailedList ? double.infinity : FetchPixels.getPixelWidth(210),
        height: isDetailedList
            ? FetchPixels.getPixelHeight(isMyPlaceList ? 220 : 240)
            : double.infinity,
        margin: isDetailedList ? null : const EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    height:
                    FetchPixels.getPixelHeight(isDetailedList ? 125 : 110),
                    color: grey,
                    child: Image(
                      image: NetworkImage(
                        "https://via.placeholder.com/400x500",
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (isMyPlaceList)
                    Align(
                      alignment: Alignment.topRight,
                      child: PopupMenuButton<int>(
                        itemBuilder: (context) =>
                        [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: darkGrey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                getCustomFont(
                                  "Edit",
                                  16,
                                  darkGrey,
                                  1,
                                )
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                getCustomFont(
                                  "Delete",
                                  16,
                                  Colors.redAccent,
                                  1,
                                )
                              ],
                            ),
                          ),
                        ],
                        icon: CircleAvatar(
                          backgroundColor: white.withOpacity(.7),
                          child: Icon(
                            Icons.more_vert_rounded,
                            size: 20,
                            color: darkGrey,
                          ),
                        ),
                        elevation: 1,
                      ),
                    ),
                  if (!isMyPlaceList)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () {
                            if (vmLoginData.isLoggedIn.value) {

                            } else {
                              openSignInAlert();
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: white.withOpacity(.7),
                            radius: FetchPixels.getPixelWidth(13),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Image(
                                image: AssetImage(
                                  "heart".png,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isDetailedList && !isMyPlaceList)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: CircleAvatar(
                          backgroundColor: white.withOpacity(.7),
                          radius: FetchPixels.getPixelWidth(13),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.share_rounded,
                              color: darkGrey,
                              size: FetchPixels.getPixelWidth(14),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            vSpace(10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    right:
                    FetchPixels.getPixelWidth(isDetailedList ? 0 : 17.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        getCustomFont(
                          "Marina Ca, Nu",
                          isDetailedList ? 17.5 : 15,
                          Colors.black,
                          1,
                          fontWeight: semiBold,
                        ),
                        Spacer(),
                        if (isMyPlaceList)
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) =>
                                    AlertDialog(
                                      title: getCustomFont(
                                        "Reason for rejection!",
                                        18,
                                        Colors.redAccent,
                                        1,
                                        fontWeight: bold,
                                      ),
                                      content: SingleChildScrollView(
                                        child: getCustomFont(
                                          "Lorem Ipsum is simply dummy unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                          14,
                                          darkGrey,
                                          1000,
                                          fontWeight: semiBold,
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: getPaddingWidget(
                                EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 6,
                                ),
                                child: getCustomFont(
                                  "Active",
                                  15,
                                  Colors.white,
                                  1,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    vSpace(2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: isDetailedList ? 22 : 20,
                          color: grey,
                        ),
                        hSpace(3),
                        Expanded(
                          child: getCustomFont(
                            "New York, NY 100",
                            isDetailedList ? 14 : 12,
                            darkGrey,
                            1,
                            fontWeight: regular,
                          ),
                        ),
                      ],
                    ),
                    vSpace(3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        getIconText(Icons.bed_rounded,
                            "4 ${isDetailedList ? "Beds" : "Bds"}"),
                        getIconText(Icons.bathroom_outlined,
                            "4 ${isDetailedList ? "Bathrooms" : "Bath"}"),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child:
                          getIconText(Icons.width_wide_outlined, "4 sqft"),
                        ),
                      ],
                    ),
                    Spacer(),
                    if (!isMyPlaceList)
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://via.placeholder.com/400x400",
                            ),
                            radius: isDetailedList ? 11 : 10,
                            backgroundColor: grey,
                          ),
                          hSpace(7),
                          getCustomFont(
                            "John Adam",
                            isDetailedList ? 13 : 12,
                            Colors.black,
                            1,
                            fontWeight: bold,
                          ),
                          Spacer(),
                          if (isDetailedList)
                            Row(
                              children: [
                                getCustomFont(
                                  "₹200",
                                  15,
                                  Colors.black,
                                  1,
                                  fontWeight: extraBold,
                                ),
                                if (isRentList)
                                  getCustomFont(
                                    " /month",
                                    13,
                                    Colors.black,
                                    1,
                                    fontWeight: regular,
                                  ),
                              ],
                            )
                        ],
                      ),
                    vSpace(4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
