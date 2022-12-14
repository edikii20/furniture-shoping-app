import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:hive/hive.dart';

part 'user_favorites.g.dart';

@HiveType(typeId: 2)
class UserFavorites extends HiveObject {
  @HiveField(0)
  late HiveList<HomeCatalogItem> favoriteList;
}
