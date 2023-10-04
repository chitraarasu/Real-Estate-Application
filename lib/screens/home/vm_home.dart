import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../model/m_category.dart';

class VMHome extends GetxController {
  static VMHome to = Get.find();

  List<CategoryModel> category = [
    CategoryModel(1, "House", "house"),
    CategoryModel(2, "Apartment", "apartment"),
    CategoryModel(3, "Skyscraper", "skyscrapers"),
    CategoryModel(4, "Farmhouse", "farmhouse"),
    CategoryModel(5, "Townhouse", "townhouse"),
    CategoryModel(6, "Cottage", "cottage"),
    CategoryModel(7, "Duplex", "duplex"),
    CategoryModel(8, "Mansion", "mansion"),
    CategoryModel(9, "Penthouse", "penthouse"),
  ];

  addToFavorites(placeId) async {
    User? user = FirebaseAuth.instance.currentUser;

    var userRef = FirebaseFirestore.instance.collection("users").doc(user?.uid);

    DocumentSnapshot<Map<String, dynamic>> profileData = await userRef.get();

    if (profileData.data() != null) {
      List favorites = profileData.data()?["favorites"] ?? [];
      if (!favorites.contains(placeId)) {
        favorites.insert(0, placeId);
        userRef.update(
          {"favorites": favorites},
        );
      }
    }
  }

  removeFromFavorites(placeId) async {
    User? user = FirebaseAuth.instance.currentUser;

    var userRef = FirebaseFirestore.instance.collection("users").doc(user?.uid);

    DocumentSnapshot<Map<String, dynamic>> profileData = await userRef.get();

    if (profileData.data() != null) {
      List favorites = profileData.data()?["favorites"] ?? [];
      if (favorites.contains(placeId)) {
        favorites.remove(placeId);
        userRef.update(
          {"favorites": favorites},
        );
      }
    }
  }
}
