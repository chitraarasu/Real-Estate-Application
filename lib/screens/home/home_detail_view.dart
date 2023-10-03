import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_estate/screens/profile/pdf_viewer.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/font_manager.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';
import 'package:real_estate/widget/buttons/secondary_button.dart';

import '../../model/m_place.dart';
import '../../utils/manager/color_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/buttons/primary_button.dart';
import '../../widget/widget_utils.dart';
import '../login/login_screen.dart';
import '../login/vm_login.dart';
import '../textbox/first_textbox.dart';
import '../textbox/vm_textbox.dart';
import '../your_places/vm_new_place.dart';

class HomeDetailView extends StatelessWidget {
  final bool isManagePlaceList;
  final bool isMyPlace;
  final PlaceModel? placeData;

  HomeDetailView(
      {super.key,
      this.isManagePlaceList = false,
      this.isMyPlace = false,
      this.placeData});

  Widget getIconText(IconData iData, String text) {
    return Row(
      children: [
        Icon(
          iData,
          size: 23,
          color: Colors.black,
        ),
        hSpace(3),
        getCustomFont(text, 13, darkGrey, 1, fontWeight: semiBold),
      ],
    );
  }

  final reason = VMTextBox(
    placeholder: '',
    keyboardType: TextInputType.multiline,
  );

  rejectSheet() {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 35, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                        "Enter the reason!",
                        22,
                        Colors.black,
                        1,
                        fontWeight: bold,
                      ),
                      vSpace(16),
                      FirstTextBox(
                        data: reason,
                        isNeedTopPlaceholder: false,
                        maxLines: 10,
                      ),
                      vSpace(16),
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              title: "Reject",
                              // isFromProfile: true,
                              padding: EdgeInsets.symmetric(
                                vertical: FetchPixels.getPixelHeight(10),
                                horizontal: FetchPixels.getPixelWidth(17),
                              ),
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.30),
      isDismissible: true,
      isScrollControlled: true,
    );
  }

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    final vmLoginData = Get.find<VMLogin>();
    final data = Get.find<VMNewPlace>();

    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: 15);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: getPaddingWidget(
              edgeInsets,
              child: Column(
                children: [
                  FirstAppBar(
                    title: "Details",
                    action: isManagePlaceList || isMyPlace
                        ? Container()
                        : Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (vmLoginData.isLoggedIn.value) {
                                  } else {
                                    openSignInAlert();
                                  }
                                },
                                icon: Image.asset(
                                  "heart".png,
                                  width: FetchPixels.getPixelWidth(20),
                                  height: FetchPixels.getPixelHeight(20),
                                  color: darkGrey,
                                  scale: FetchPixels.getScale(),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.ios_share_outlined,
                                  color: darkGrey,
                                ),
                              ),
                            ],
                          ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CarouselSlider(
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  // height: 156,
                                  // aspectRatio: 16 / 9,
                                  viewportFraction: 1,
                                  initialPage: 0,
                                  enableInfiniteScroll: 1 == 1 ? false : true,
                                  reverse: false,
                                  autoPlay: 1 == 1 ? false : true,
                                  autoPlayInterval: Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      Duration(seconds: 1),
                                  enlargeCenterPage: false,
                                  // enlargeFactor: 0.3,
                                  scrollDirection: Axis.horizontal,
                                  onPageChanged: (index, reason) {
                                    // _currentIndex.value =
                                    //     index;
                                  },
                                ),
                                items: [1, 2, 3]
                                    .map((e) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            height:
                                                FetchPixels.getPixelHeight(180),
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
                                        ))
                                    .toList(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 6),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "gallery".png,
                                              width:
                                                  FetchPixels.getPixelWidth(19),
                                              height:
                                                  FetchPixels.getPixelHeight(
                                                      19),
                                              color: darkGrey,
                                              scale: FetchPixels.getScale(),
                                            ),
                                            hSpace(5),
                                            getCustomFont(
                                                "1 / 20", 15, darkGrey, 1),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          vSpace(15),
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: grey,
                              ),
                              hSpace(10),
                              getCustomFont(
                                "Amanda Simon",
                                17,
                                Colors.black,
                                1,
                                fontWeight: bold,
                              ),
                              Spacer(),
                              getCustomFont(
                                "2h ago",
                                14,
                                darkGrey,
                                1,
                                fontWeight: medium,
                              ),
                            ],
                          ),
                          vSpace(10),
                          Row(
                            children: [
                              Expanded(
                                child: getCustomFont(
                                  "64 Rosewood Street #2 San Francisco, CA",
                                  18,
                                  Colors.black,
                                  2,
                                  fontWeight: bold,
                                ),
                              ),
                              hSpace(10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: AssetImage("map".png),
                                  width: FetchPixels.getPixelWidth(110),
                                ),
                              ),
                            ],
                          ),
                          vSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getIconText(Icons.bed_rounded, "4 Beds"),
                              getIconText(
                                  Icons.bathroom_outlined, "4 Bathrooms"),
                              getIconText(Icons.width_wide_outlined, "4 sqft"),
                            ],
                          ),
                          vSpace(10),
                          const Divider(
                            thickness: 1,
                            color: grey,
                          ),
                          if (isManagePlaceList)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => PdfView());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD33B35),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: getPaddingWidget(
                                      EdgeInsets.symmetric(
                                        vertical:
                                            FetchPixels.getPixelHeight(10),
                                        horizontal:
                                            FetchPixels.getPixelWidth(15),
                                      ),
                                      child: Row(
                                        children: [
                                          getCustomFont(
                                            "Land Documents",
                                            15,
                                            Colors.white,
                                            1,
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.picture_as_pdf,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          vSpace(15),
                          getCustomFont(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                            16,
                            darkGrey,
                            1000,
                            fontWeight: regular,
                            textAlign: TextAlign.justify,
                          ),
                          vSpace(15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 50,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: getPaddingWidget(
              edgeInsets,
              child: SafeArea(
                bottom: true,
                top: false,
                child: getPaddingWidget(
                  EdgeInsets.symmetric(
                    vertical:
                        FetchPixels.getPixelHeight(isManagePlaceList ? 20 : 25),
                  ),
                  child: isManagePlaceList
                      ? Column(
                          children: [
                            Row(
                              children: [
                                getCustomFont(
                                  "\$2,300",
                                  22,
                                  Colors.black,
                                  1,
                                  fontWeight: bold,
                                ),
                                getCustomFont(
                                  " /month",
                                  16,
                                  darkGrey,
                                  1,
                                ),
                              ],
                            ),
                            vSpace(15),
                            Row(
                              children: [
                                Expanded(
                                  child: SecondaryButton(
                                    title: "Reject",
                                    isFromProfile: true,
                                    padding: EdgeInsets.symmetric(
                                      vertical: FetchPixels.getPixelHeight(12),
                                      horizontal: FetchPixels.getPixelWidth(17),
                                    ),
                                    color: Colors.redAccent,
                                    onTap: () {
                                      rejectSheet();
                                    },
                                  ),
                                ),
                                hSpace(10),
                                Expanded(
                                  child: PrimaryButton(
                                    "Approve",
                                    radius: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            getCustomFont(
                              "\$2,300",
                              22,
                              Colors.black,
                              1,
                              fontWeight: bold,
                            ),
                            getCustomFont(
                              " /month",
                              16,
                              darkGrey,
                              1,
                            ),
                            Spacer(),
                            PrimaryButton(
                              isMyPlace ? "Active" : "Call",
                              onTap: () {
                                if (isMyPlace) {
                                  data.showAlert(context);
                                }
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
