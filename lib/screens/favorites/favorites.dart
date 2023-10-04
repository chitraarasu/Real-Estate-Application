import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/controller/route_controller.dart';
import 'package:real_estate/widget/appbar/first_appbar.dart';

import '../../model/m_place.dart';
import '../../utils/manager/loading_manager.dart';
import '../../utils/resizer/fetch_pixels.dart';
import '../../widget/home_card.dart';
import '../../widget/widget_utils.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RouteController.to.currentPos.value = 0;
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(8),
            horizontal: FetchPixels.getPixelHeight(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FirstAppBar(
                title: "Favorites",
                onBack: () {
                  RouteController.to.currentPos.value = 0;
                },
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loading;
                      } else if (snapshot.hasData) {
                        Map<String, dynamic>? userFireData =
                            snapshot.data!.data();
                        List favorites = userFireData?["favorites"] ?? [];
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("places")
                              .where("isApproved", isEqualTo: true)
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            // List channelUsers =
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return loading;
                            } else if (snapshot.hasData) {
                              List<PlaceModel> list = snapshot.data!.docs.map(
                                (e) {
                                  return PlaceModel.fromJson(e.data());
                                },
                              ).toList();

                              List<PlaceModel> favoriteList = list
                                  .where((element) =>
                                      favorites.contains(element.placeId))
                                  .toList();

                              return ListView.builder(
                                itemCount: favoriteList.length,
                                padding: EdgeInsets.only(top: 6),
                                itemBuilder: (BuildContext context, int index) {
                                  return getPaddingWidget(
                                    EdgeInsets.only(
                                      bottom: FetchPixels.getPixelHeight(20),
                                    ),
                                    child: HomeCard(
                                      isDetailedList: true,
                                      placeData: favoriteList[index],
                                    ),
                                  );
                                },
                              );
                            } else {
                              print(snapshot.error);
                              return getErrorMessage();
                            }
                          },
                        );
                      } else {
                        return getErrorMessage();
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
