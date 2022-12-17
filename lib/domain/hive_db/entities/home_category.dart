import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:hive/hive.dart';

part 'home_category.g.dart';

@HiveType(typeId: 1)
class HomeCategoryItem extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String iconName;
  @HiveField(2)
  HiveList<HomeCatalogItem> catalog;

  HomeCategoryItem({
    required this.name,
    required this.iconName,
    required this.catalog,
  });
}
