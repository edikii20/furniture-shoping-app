import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_category.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/user_favorites.dart';
import 'package:furniture_shoping_app/main_screens/home_page/ui/home_page_widget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/hive_db/entities/user_cart.dart';

class FavoritePageModel extends ChangeNotifier {
  late final Future<Box<UserFavorites>> _favoritesBox;
  late final Future<Box<HomeCatalogItem>> _catalogBox;
  late final ValueListenable<Box<UserFavorites>> _listenableFavoritesBox;
  List<HomeCatalogItem> _favoriteList = [];

  List<HomeCatalogItem> get favoriteList => _favoriteList;

  FavoritePageModel() {
    _setup();
  }

  @override
  Future<void> dispose() async {
    _listenableFavoritesBox.removeListener(_updateFavoriteList);
    super.dispose();
    await BoxManager.instance.closeBox(await _favoritesBox);
  }

  Future<void> onPressedAddToCartItem(
      {required int index,
      required String selectedColor,
      required BuildContext context}) async {
    final cartBox = await BoxManager.instance.openCartBox();
    final catalogBox = await _catalogBox;
    if (0 < catalogBox.get(_favoriteList[index].id)!.maxQuantity) {
      if (!cartBox.containsKey('edikii20@mail.ru')) {
        await cartBox.put('edikii20@mail.ru', UserCart());
      }
      final userCart = cartBox.get('edikii20@mail.ru');
      final isItemInCart = userCart!.cartList.any((element) =>
          element.id == _favoriteList[index].id &&
          element.selectedColor == selectedColor);

      if (isItemInCart) {
        userCart.cartList
            .firstWhere((element) =>
                element.id == _favoriteList[index].id &&
                element.selectedColor == selectedColor)
            .selectedQuantity += 1;
      } else {
        userCart.cartList
            .add(_favoriteList[index]..selectedColor = selectedColor);
      }

      (await _catalogBox).get(_favoriteList[index].id)
        ?..maxQuantity -= 1
        ..save();

      await userCart.save();
    }

    await BoxManager.instance.closeBox(cartBox);
    Navigator.of(context).pop();
  }

  Future<void> onPressedRemoveItem(int index) async {
    final box = await _favoritesBox;
    final userFavorite = box.get('edikii20@mail.ru');
    final catalogItem = (await _catalogBox)
        .get(userFavorite?.favoriteList.elementAt(index).key);
    catalogItem?.isFavorite = false;
    await catalogItem?.save();
    userFavorite?.favoriteList.removeAt(index);

    await userFavorite?.save();
  }

  Future<void> _updateFavoriteList() async {
    final box = await _favoritesBox;
    _favoriteList = box.get('edikii20@mail.ru')!.favoriteList.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _favoritesBox = BoxManager.instance.openFavoritesBox();
    _catalogBox = BoxManager.instance.openHomeCatalogBox();

    if (!(await _favoritesBox).containsKey('edikii20@mail.ru')) {
      await (await _favoritesBox).put(
          'edikii20@mail.ru',
          UserFavorites()
            ..favoriteList =
                HiveList<HomeCatalogItem>(await _catalogBox, objects: []));
    }
    _listenableFavoritesBox =
        (await _favoritesBox).listenable(keys: ['edikii20@mail.ru']);
    _listenableFavoritesBox.addListener(_updateFavoriteList);

    _favoriteList =
        (await _favoritesBox).get('edikii20@mail.ru')!.favoriteList.toList();
    notifyListeners();
  }
}

class FavoritePageProvider extends InheritedNotifier<FavoritePageModel> {
  final FavoritePageModel model;
  const FavoritePageProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
          key: key,
        );

  static FavoritePageProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FavoritePageProvider>();
  }

  static FavoritePageProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<FavoritePageProvider>()
        ?.widget;
    return widget is FavoritePageProvider ? widget : null;
  }
}
