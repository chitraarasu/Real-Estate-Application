import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:real_estate/controller/route_controller.dart';
import 'package:real_estate/model/m_place.dart';
import 'package:real_estate/utils/c_extensions.dart';
import 'package:real_estate/utils/manager/loading_manager.dart';

import '../../utils/manager/font_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/appbar/common_appbar.dart';
import '../../widget/home_card.dart';
import '../../widget/widget_utils.dart';

class YourPlaces extends StatelessWidget {
  const YourPlaces({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RouteController.to.currentPos.value = 0;
        return false;
      },
      child: Scaffold(
        appBar: CommonAppBar(isMyPlace: true),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("places")
              .where("user_id",
                  isEqualTo: FirebaseAuth.instance.currentUser?.uid)
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            // List channelUsers =
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loading;
            } else if (snapshot.hasData) {
              List<PlaceModel> list = snapshot.data!.docs.map(
                (e) {
                  print(e.data());
                  return PlaceModel.fromJson(
                    e.data(),
                  );
                },
              ).toList();
              return list.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset("empty".lottie, width: 300),
                          vSpace(20),
                          getCustomFont(
                            "Click above + button to create your place.",
                            17,
                            Colors.black,
                            3,
                            fontWeight: bold,
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
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
                              "Your Places",
                              20,
                              Colors.black,
                              1,
                              fontWeight: bold,
                            ),
                            vSpace(15),
                            ListView.builder(
                              itemCount: list.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 6),
                              itemBuilder: (BuildContext context, int index) {
                                return getPaddingWidget(
                                  EdgeInsets.only(
                                    bottom: FetchPixels.getPixelHeight(20),
                                  ),
                                  child: HomeCard(
                                    isDetailedList: true,
                                    isMyPlaceList: true,
                                    // onTap: () {},
                                    placeData: list[index],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
            } else {
              print(snapshot.error);
              return getErrorMessage();
            }
          },
        ),
      ),
    );
  }
}
