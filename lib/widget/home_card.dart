import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/login/login_screen.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/toast_manager.dart';
import 'package:real_estate/widget/widget_utils.dart';

import '../model/m_place.dart';
import '../screens/home/home_detail_view.dart';
import '../screens/login/vm_login.dart';
import '../screens/your_places/vm_new_place.dart';
import '../utils/manager/color_manager.dart';
import '../utils/manager/font_manager.dart';
import '../utils/resizer/fetch_pixels.dart';

class HomeCard extends StatelessWidget {
  final bool isDetailedList;
  final bool isRentList;
  final bool isMyPlaceList;
  final bool isManagePlaceList;
  final Function()? onTap;
  final PlaceModel? placeData;

  const HomeCard({
    super.key,
    this.isDetailedList = false,
    this.isRentList = false,
    this.isMyPlaceList = false,
    this.isManagePlaceList = false,
    this.onTap,
    this.placeData,
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
    final data = Get.find<VMNewPlace>();

    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          Get.to(() => HomeDetailView(
                isManagePlaceList: isManagePlaceList,
                isMyPlace: isMyPlaceList,
                placeData: placeData,
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
                        placeData?.imagesUrl!.first ??
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
                        itemBuilder: (context) => [
                          // PopupMenuItem(
                          //   value: 1,
                          //   child: Row(
                          //     children: [
                          //       Icon(
                          //         Icons.edit,
                          //         color: darkGrey,
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       getCustomFont(
                          //         "Edit",
                          //         16,
                          //         darkGrey,
                          //         1,
                          //       )
                          //     ],
                          //   ),
                          // ),
                          PopupMenuItem(
                            value: 2,
                            onTap: () {
                              if (placeData?.rejectedReason != null ||
                                  (placeData?.isApproved ?? false)) {
                                data.deletePlace(placeData?.placeId);
                              } else {
                                ToastManager.shared.show(
                                    "You can't delete the place when it's under review!");
                              }
                            },
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
                          backgroundColor: white,
                          child: Icon(
                            Icons.more_vert_rounded,
                            size: 20,
                            color: darkGrey,
                          ),
                        ),
                        elevation: 1,
                      ),
                    ),
                  if (!isMyPlaceList && !isManagePlaceList)
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
                            backgroundColor: white,
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
                  // if (isDetailedList && !isMyPlaceList)
                  //   Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(6),
                  //       child: CircleAvatar(
                  //         backgroundColor: white,
                  //         radius: FetchPixels.getPixelWidth(13),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(6.0),
                  //           child: Icon(
                  //             Icons.share_rounded,
                  //             color: darkGrey,
                  //             size: FetchPixels.getPixelWidth(14),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
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
                        Expanded(
                          child: getCustomFont(
                            placeData?.name ?? "Marina Ca, Nu",
                            isDetailedList ? 17.5 : 15,
                            Colors.black,
                            1,
                            fontWeight: semiBold,
                          ),
                        ),
                        hSpace(5),
                        // if (!isMyPlaceList)
                        //   getCustomFont(
                        //     placeData != null
                        //         ? formatDuration(placeData?.createdAt?.toDate())
                        //         : "2h ago",
                        //     14,
                        //     darkGrey,
                        //     1,
                        //     fontWeight: medium,
                        //   ),
                        if (isMyPlaceList)
                          GestureDetector(
                            onTap: () {
                              if (placeData?.rejectedReason != null) {
                                data.showAlert(
                                    context, placeData?.rejectedReason);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: placeData?.rejectedReason != null
                                    ? Colors.redAccent
                                    : placeData?.isApproved == true
                                        ? green
                                        : darkGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: getPaddingWidget(
                                EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 6,
                                ),
                                child: getCustomFont(
                                  placeData?.rejectedReason != null
                                      ? "Rejected"
                                      : placeData?.isApproved ?? false
                                          ? "Active"
                                          : "In Review",
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
                            placeData?.address ?? "New York, NY 100",
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
                            "${placeData?.beds ?? 0} ${isDetailedList ? "Beds" : "Bds"}"),
                        getIconText(Icons.bathroom_outlined,
                            "${placeData?.bath ?? 0} ${isDetailedList ? "Bathrooms" : "Bath"}"),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: getIconText(Icons.width_wide_outlined,
                              "${placeData?.sqft ?? 0} sqft"),
                        ),
                      ],
                    ),
                    Spacer(),
                    if (!isMyPlaceList)
                      Row(
                        children: [
                          Expanded(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(placeData?.userId)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            DocumentSnapshot<
                                                Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container();
                                  } else if (snapshot.hasData) {
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: snapshot.data!
                                                      .data()?["photo_url"] ==
                                                  null
                                              ? null
                                              : NetworkImage(
                                                  snapshot.data!
                                                      .data()!["photo_url"]
                                                      .toString(),
                                                ),
                                          radius: isDetailedList ? 11 : 10,
                                          backgroundColor: grey,
                                          child: snapshot.data!
                                                      .data()?["photo_url"] !=
                                                  null
                                              ? null
                                              : Image(
                                                  image:
                                                      AssetImage("profile".png),
                                                  color: Colors.white,
                                                ),
                                        ),
                                        hSpace(7),
                                        getCustomFont(
                                          snapshot.data!
                                                  .data()?["username"]
                                                  .toString()
                                                  .capitalize ??
                                              "Amanda Simon",
                                          isDetailedList ? 13 : 12,
                                          Colors.black,
                                          1,
                                          fontWeight: bold,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          ),
                          if (isDetailedList)
                            Row(
                              children: [
                                getCustomFont(
                                  "₹ ${placeData?.price}",
                                  15,
                                  Colors.black,
                                  1,
                                  fontWeight: extraBold,
                                ),
                                if (isRentList)
                                  if (!(placeData?.isForSale ?? true))
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
