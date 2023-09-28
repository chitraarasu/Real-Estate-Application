import '../../model/m_category.dart';

class VMHome {
  static VMHome to = VMHome();

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
