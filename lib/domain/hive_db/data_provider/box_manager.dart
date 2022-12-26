import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_category.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/session.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user.dart';
import 'package:hive/hive.dart';

class BoxManager {
  static final instance = BoxManager._();

  BoxManager._();

  Future<Box<HomeCatalogItem>> openHomeCatalogBox() async {
    // if (!Hive.isAdapterRegistered(0)) {
    //   Hive.registerAdapter<HomeCatalogItem>(HomeCatalogItemAdapter());
    // }
    return Hive.openBox<HomeCatalogItem>('home_catalog');
  }

  Future<Box<HomeCategoryItem>> openHomeCategoriesBox() async {
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter<HomeCategoryItem>(HomeCategoryItemAdapter());
    // }
    return Hive.openBox<HomeCategoryItem>('home_categories');
  }

  Future<Box<User>> openUsersBox() async {
    // if (!Hive.isAdapterRegistered(2)) {
    //   Hive.registerAdapter<User>(UserAdapter());
    // }

    return Hive.openBox<User>('users');
  }

  Future<Box<Session>> openSessionBox() async {
    // if (!Hive.isAdapterRegistered(3)) {
    //   Hive.registerAdapter<Session>(SessionAdapter());
    // }

    return Hive.openBox<Session>('session');
  }

  Future<void> closeBox(Box box) async {
    await box.compact();
    await box.close();
  }
}
