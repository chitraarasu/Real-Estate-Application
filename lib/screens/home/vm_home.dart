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
}
