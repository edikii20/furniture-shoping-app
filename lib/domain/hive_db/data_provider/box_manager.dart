import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_category.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user_cart.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user_favorites.dart';
import 'package:hive/hive.dart';

class BoxManager {
  static final instance = BoxManager._();

  BoxManager._();

  Future<Box<HomeCatalogItem>> openHomeCatalogBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(HomeCatalogItemAdapter());
    }
    return Hive.openBox<HomeCatalogItem>('home_catalog');
  }

  Future<Box<HomeCategoryItem>> openHomeCategoriesBox() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(HomeCategoryItemAdapter());
    }
    return Hive.openBox<HomeCategoryItem>('home_categories');
  }

  Future<Box<UserFavorites>> openFavoritesBox() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(UserFavoritesAdapter());
    }

    return Hive.openBox<UserFavorites>('favorites');
  }

  Future<Box<UserCart>> openCartBox() async {
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(UserCartAdapter());
    }

    return Hive.openBox<UserCart>('cart');
  }

  Future<void> closeBox(Box box) async {
    await box.compact();
    await box.close();
  }
}
