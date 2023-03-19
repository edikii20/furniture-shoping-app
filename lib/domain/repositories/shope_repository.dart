import 'package:hive/hive.dart';

import '../hive_db/data_provider/box_manager.dart';
import '../hive_db/entities/home_catalog_item.dart';
import '../hive_db/entities/home_category.dart';

class ShopeRepository {
  ShopeRepository() {
    _init();
  }

  Future<void> _init() async {
    await _setupDefaultContent();
  }

  Future<List<HomeCategoryItem>> loadCategoties() async {
    final categoriesBox = await BoxManager.instance.openHomeCategoriesBox();
    final categories = categoriesBox.values.toList();
    await BoxManager.instance.closeBox(categoriesBox);
    return categories;
  }

  Future<List<HomeCatalogItem>> loadCatalogOfCategory(
      {required HomeCategoryItem category}) async {
    final catalogBox = await BoxManager.instance.openHomeCatalogBox();
    final catalog = category.catalog.toList();
    await BoxManager.instance.closeBox(catalogBox);
    return catalog;
  }

  Future<void> addToFavorite({required int catalogItemID}) async {
    final sessionBox = await BoxManager.instance.openSessionBox();
    final usersBox = await BoxManager.instance.openUsersBox();
    final catalogBox = await BoxManager.instance.openHomeCatalogBox();
    final session = sessionBox.getAt(0);
    final catalogItem = catalogBox.get(catalogItemID)!;
    catalogItem.isFavorite = true;
    session?.user.first.favoriteList.add(catalogItem);

    await catalogItem.save();

    await session?.user.first.save();
    await BoxManager.instance.closeBox(catalogBox);
    await BoxManager.instance.closeBox(usersBox);
    await BoxManager.instance.closeBox(sessionBox);
  }

  Future<void> removeFromFavorite({required int catalogItemID}) async {
    final sessionBox = await BoxManager.instance.openSessionBox();
    final usersBox = await BoxManager.instance.openUsersBox();
    final catalogBox = await BoxManager.instance.openHomeCatalogBox();
    final session = sessionBox.getAt(0);
    final catalogItem = catalogBox.get(catalogItemID)!;
    catalogItem.isFavorite = false;
    session?.user.first.favoriteList.remove(catalogItem);
    await catalogItem.save();

    await session?.user.first.save();
    await BoxManager.instance.closeBox(catalogBox);
    await BoxManager.instance.closeBox(usersBox);
    await BoxManager.instance.closeBox(sessionBox);
  }

  Future<void> addToCart({
    required int catalogItemID,
    required int selectedQuantity,
    required String selectedColor,
  }) async {
    final sessionBox = await BoxManager.instance.openSessionBox();
    final usersBox = await BoxManager.instance.openUsersBox();
    final catalogBox = await BoxManager.instance.openHomeCatalogBox();
    final session = sessionBox.getAt(0);
    final catalogItem = catalogBox.get(catalogItemID)!
      ..selectedColor = selectedColor
      ..selectedQuantity = selectedQuantity
      ..maxQuantity -= selectedQuantity;
    final isItemInCart = session!.user.first.cartList.any((element) =>
        element.id == catalogItem.id &&
        element.selectedColor == catalogItem.selectedColor);

    if (isItemInCart) {
      session.user.first.cartList
          .firstWhere((element) =>
              element.id == catalogItem.id &&
              element.selectedColor == catalogItem.selectedColor)
          .selectedQuantity += catalogItem.selectedQuantity;
    } else {
      session.user.first.cartList.add(catalogItem);
    }

    await catalogItem.save();
    await session.user.first.save();
    await BoxManager.instance.closeBox(catalogBox);
    await BoxManager.instance.closeBox(usersBox);
    await BoxManager.instance.closeBox(sessionBox);
  }

  Future<void> removeFromCart({required HomeCatalogItem catalogItem}) async {}

  Future<void> _setupDefaultContent() async {
    final categoriesBox = await BoxManager.instance.openHomeCategoriesBox();
    final catalogBox = await BoxManager.instance.openHomeCatalogBox();
    if (categoriesBox.values.isEmpty) {
      List<HomeCatalogItem> defaultCatalog = [
        HomeCatalogItem(
          id: 0,
          name: 'Black Simple Lamp',
          cost: 50.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'B4916C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'F2C94C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
          },
          detailsText:
              'Black Simple Lamp is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 3.9,
          countReviews: 48,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 1,
          name: 'Minimal Stand',
          cost: 30.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'B4916C': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'F2C94C': 'assets/shopeCatalogImages/Minimal_Stand.png',
          },
          detailsText:
              'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.1,
          countReviews: 11,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 2,
          name: 'Coffee Chair',
          cost: 5.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'B4916C': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'F2C94C': 'assets/shopeCatalogImages/Coffee_Chair.png',
          },
          detailsText:
              'Coffee Chair is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 5,
          countReviews: 39,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 3,
          name: 'Simple Desk',
          cost: 40.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Simple_Desk.png',
            '6C8BB4': 'assets/shopeCatalogImages/Simple_Desk.png',
            'F2C94C': 'assets/shopeCatalogImages/Simple_Desk.png',
          },
          detailsText:
              'Simple Desk is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.2,
          countReviews: 190,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 4,
          name: 'Black Simple Lamp',
          cost: 50.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'B4916C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'F2C94C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
          },
          detailsText:
              'Black Simple Lamp is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 2.5,
          countReviews: 30,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 5,
          name: 'Minimal Stand',
          cost: 30.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'B4916C': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'F2C94C': 'assets/shopeCatalogImages/Minimal_Stand.png',
          },
          detailsText:
              'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.9,
          countReviews: 310,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 6,
          name: 'Coffee Chair',
          cost: 20.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'B4916C': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'F2C94C': 'assets/shopeCatalogImages/Coffee_Chair.png',
          },
          detailsText:
              'Coffee Chair is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.3,
          countReviews: 10,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 7,
          name: 'Simple Desk',
          cost: 5.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Simple_Desk.png',
            '6C8BB4': 'assets/shopeCatalogImages/Simple_Desk.png',
            'F2C94C': 'assets/shopeCatalogImages/Simple_Desk.png',
          },
          detailsText:
              'Simple Desk is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.5,
          countReviews: 32,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 8,
          name: 'Black Simple Lamp',
          cost: 50.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'B4916C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'F2C94C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
          },
          detailsText:
              'Black Simple Lamp is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4,
          countReviews: 60,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 9,
          name: 'Minimal Stand',
          cost: 30.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'B4916C': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'F2C94C': 'assets/shopeCatalogImages/Minimal_Stand.png',
          },
          detailsText:
              'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 1,
          countReviews: 15,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 10,
          name: 'Coffee Chair',
          cost: 5.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'B4916C': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'F2C94C': 'assets/shopeCatalogImages/Coffee_Chair.png',
          },
          detailsText:
              'Coffee Chair is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 3.5,
          countReviews: 140,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 11,
          name: 'Simple Desk',
          cost: 40.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Simple_Desk.png',
            '6C8BB4': 'assets/shopeCatalogImages/Simple_Desk.png',
            'F2C94C': 'assets/shopeCatalogImages/Simple_Desk.png',
          },
          detailsText:
              'Simple Desk is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 1.5,
          countReviews: 30,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 12,
          name: 'Black Simple Lamp',
          cost: 50.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'B4916C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
            'F2C94C': 'assets/shopeCatalogImages/Black_Simple_Lamp.png',
          },
          detailsText:
              'Black Simple Lamp is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.5,
          countReviews: 30,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 13,
          name: 'Minimal Stand',
          cost: 30.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'B4916C': 'assets/shopeCatalogImages/Minimal_Stand.png',
            'F2C94C': 'assets/shopeCatalogImages/Minimal_Stand.png',
          },
          detailsText:
              'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 5,
          countReviews: 100,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 14,
          name: 'Coffee Chair',
          cost: 20.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'B4916C': 'assets/shopeCatalogImages/Coffee_Chair.png',
            'F2C94C': 'assets/shopeCatalogImages/Coffee_Chair.png',
          },
          detailsText:
              'Coffee Chair is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 3.5,
          countReviews: 20,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
        HomeCatalogItem(
          id: 15,
          name: 'Simple Desk',
          cost: 5.00,
          imageNames: <String, String>{
            '242424': 'assets/shopeCatalogImages/Simple_Desk.png',
            '6C8BB4': 'assets/shopeCatalogImages/Simple_Desk.png',
            'F2C94C': 'assets/shopeCatalogImages/Simple_Desk.png',
          },
          detailsText:
              'Simple Desk is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
          rating: 4.5,
          countReviews: 30,
          maxQuantity: 15,
          selectedColor: '242424',
        ),
      ];

      await catalogBox.addAll(defaultCatalog);
      var popularCatalog =
          HiveList(catalogBox, objects: catalogBox.values.toList());
      var chairCatalog = HiveList(catalogBox,
          objects: catalogBox.values
              .where((element) => element.name == 'Coffee Chair')
              .toList());
      var tableCatalog = HiveList(catalogBox,
          objects: catalogBox.values
              .where((element) =>
                  element.name == 'Simple Desk' ||
                  element.name == 'Minimal Stand')
              .toList());
      var armchairCatalog = HiveList(catalogBox,
          objects: catalogBox.values.toList().sublist(0, 5));
      var bedCatalog = HiveList(catalogBox,
          objects: catalogBox.values.toList().sublist(3, 7));
      var lampCatalog = HiveList(catalogBox,
          objects: catalogBox.values
              .where((element) => element.name == 'Black Simple Lamp')
              .toList());

      List<HomeCategoryItem> defaultCategoiesList = [
        HomeCategoryItem(
            name: 'Popular',
            iconName: 'assets/icons/star.png',
            catalog: popularCatalog),
        HomeCategoryItem(
            name: 'Chair',
            iconName: 'assets/icons/chair.png',
            catalog: chairCatalog),
        HomeCategoryItem(
            name: 'Table',
            iconName: 'assets/icons/table.png',
            catalog: tableCatalog),
        HomeCategoryItem(
            name: 'Armchair',
            iconName: 'assets/icons/sofa.png',
            catalog: armchairCatalog),
        HomeCategoryItem(
            name: 'Bed', iconName: 'assets/icons/bed.png', catalog: bedCatalog),
        HomeCategoryItem(
            name: 'Lamp',
            iconName: 'assets/icons/lamp.png',
            catalog: lampCatalog),
      ];

      await categoriesBox.addAll(defaultCategoiesList);
    }
    await BoxManager.instance.closeBox(catalogBox);
    await BoxManager.instance.closeBox(categoriesBox);
  }
}
