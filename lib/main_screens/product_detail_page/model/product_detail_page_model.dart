import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user_cart.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user_favorites.dart';
import 'package:hive/hive.dart';

class ProductDetailPageModel extends ChangeNotifier {
  int selectedColorIndex = 0;
  int selectedImageIndex = 0;
  int quantity = 1;
  int maxQuantity;
  bool isSelectedBookmark;
  late final Future<Box<UserFavorites>> _favoritesBox;
  late final Future<Box<UserCart>> _cartBox;
  late final Future<Box<HomeCatalogItem>> _catalogBox;

  ProductDetailPageModel(
      {required this.maxQuantity, required this.isSelectedBookmark}) {
    _setup();
  }

  void _setup() {
    _favoritesBox = BoxManager.instance.openFavoritesBox();
    _cartBox = BoxManager.instance.openCartBox();
    _catalogBox = BoxManager.instance.openHomeCatalogBox();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await BoxManager.instance.closeBox(await _favoritesBox);
    await BoxManager.instance.closeBox(await _cartBox);
  }

  void onTapMinus() {
    if (quantity > 1) {
      quantity -= 1;
      notifyListeners();
    }
  }

  void onTapPlus() {
    if (quantity < maxQuantity) {
      quantity += 1;
      notifyListeners();
    }
  }

  Future<void> onTapBookmark({required HomeCatalogItem catalogItem}) async {
    final favoritesBox = await _favoritesBox;
    final catalogBox = await _catalogBox;

    if (isSelectedBookmark == true) {
      final userFavorites = favoritesBox.get('edikii20@mail.ru');
      userFavorites?.favoriteList.remove(catalogItem);
      catalogItem.isFavorite = false;
      userFavorites?.save();

      catalogItem.save();

      isSelectedBookmark = !isSelectedBookmark;
      notifyListeners();
    } else {
      if (favoritesBox.containsKey('edikii20@mail.ru')) {
        final userFavorites = favoritesBox.get('edikii20@mail.ru');
        userFavorites?.favoriteList.add(catalogItem);
        catalogItem.isFavorite = true;
        userFavorites?.save();
        catalogItem.save();
      } else {
        favoritesBox.put(
            'edikii20@mail.ru',
            UserFavorites()
              ..favoriteList = HiveList<HomeCatalogItem>(catalogBox,
                  objects: [catalogItem..isFavorite = true]));
        catalogItem.save();
      }

      isSelectedBookmark = !isSelectedBookmark;
      notifyListeners();
    }
  }

  void onPressedBack({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  Future<void> onPressedAddToCart(
      {required BuildContext context,
      required HomeCatalogItem catalogItem}) async {
    final cartBox = await _cartBox;
    if (0 < maxQuantity) {
      if (!cartBox.containsKey('edikii20@mail.ru')) {
        await cartBox.put('edikii20@mail.ru', UserCart());
      }
      final userCart = cartBox.get('edikii20@mail.ru');
      catalogItem
        ..selectedColor =
            catalogItem.imageNames.keys.toList()[selectedColorIndex]
        ..selectedQuantity = quantity;
      final isItemInCart = userCart!.cartList.any((element) =>
          element.id == catalogItem.id &&
          element.selectedColor == catalogItem.selectedColor);

      if (isItemInCart) {
        userCart.cartList
            .firstWhere((element) =>
                element.id == catalogItem.id &&
                element.selectedColor == catalogItem.selectedColor)
            .selectedQuantity += quantity;
      } else {
        userCart.cartList.add(catalogItem);
      }

      (await _catalogBox).get(catalogItem.id)
        ?..maxQuantity -= quantity
        ..save();

      await userCart.save();
    }

    Navigator.of(context).pop();
  }

  void onImageChanged(int value) {
    selectedImageIndex = value;
    notifyListeners();
  }

  void onSelectColor({required int index}) {
    if (selectedColorIndex == index) {
      return;
    }
    selectedColorIndex = index;
    notifyListeners();
  }
}

class ProductDetailPageProvider
    extends InheritedNotifier<ProductDetailPageModel> {
  final ProductDetailPageModel model;
  const ProductDetailPageProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
          key: key,
        );

  static ProductDetailPageProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProductDetailPageProvider>();
  }

  static ProductDetailPageProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ProductDetailPageProvider>()
        ?.widget;
    return widget is ProductDetailPageProvider ? widget : null;
  }
}
