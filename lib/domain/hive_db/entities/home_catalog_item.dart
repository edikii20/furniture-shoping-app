import 'package:hive/hive.dart';

part 'home_catalog_item.g.dart';

@HiveType(typeId: 0)
class HomeCatalogItem extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  double cost;
  @HiveField(3)
  Map<String, String> imageNames;
  @HiveField(4)
  String detailsText;
  @HiveField(5)
  double rating;
  @HiveField(6)
  int countReviews;
  @HiveField(7, defaultValue: 1)
  int selectedQuantity = 1;
  @HiveField(8)
  int maxQuantity;
  //Нужно сделать String? и по дефолту поставить null
  @HiveField(9)
  String selectedColor;
  @HiveField(10)
  bool isFavorite = false;

  HomeCatalogItem(
      {required this.id,
      required this.name,
      required this.cost,
      required this.imageNames,
      required this.detailsText,
      required this.rating,
      required this.countReviews,
      required this.maxQuantity,
      required this.selectedColor});
}
