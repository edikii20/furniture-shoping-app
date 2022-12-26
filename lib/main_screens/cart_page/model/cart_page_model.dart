import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Переделать с Provider, нужно чтобы state обновлялся исходя из нужного обекта корзины а не весь лист

class CartPageModel extends ChangeNotifier {
  //late final Future<Box<UserCart>> _cartBox;
  late final Future<Box<HomeCatalogItem>> _catalogBox;
  //late final ValueListenable<Box<UserCart>> _listenableCartBox;
  List<HomeCatalogItem> _cartList = [];
  double _totalCost = 0;

  List<HomeCatalogItem> get cartList => _cartList;
  double get totalCost => _totalCost;

  CartPageModel() {
    _setup();
  }

  Future<void> _updateCartList() async {
    // final box = await _cartBox;
    // _cartList = box.get('edikii20@mail.ru')!.cartList;
    // notifyListeners();
  }

  Future<void> onTapMinus({required HomeCatalogItem cartItem}) async {
    // final box = await _cartBox;
    // final catalogBox = await _catalogBox;
    // if (cartItem.selectedQuantity > 1) {
    //   cartItem.selectedQuantity -= 1;
    //   _totalCost -= cartItem.cost;
    //   catalogBox.get(cartItem.id)!
    //     ..maxQuantity += 1
    //     ..save();
    //   await box.get('edikii20@mail.ru')!.save();
    // }
  }

  Future<void> onTapPlus({required HomeCatalogItem cartItem}) async {
    // final box = await _cartBox;
    // final catalogBox = await _catalogBox;
    // if (0 < catalogBox.get(cartItem.id)!.maxQuantity) {
    //   cartItem.selectedQuantity += 1;
    //   _totalCost += cartItem.cost;
    //   catalogBox.get(cartItem.id)!
    //     ..maxQuantity -= 1
    //     ..save();
    //   await box.get('edikii20@mail.ru')!.save();
    // }
  }

  Future<void> removeCartItem({required HomeCatalogItem cartItem}) async {
    // final box = await _cartBox;
    // final catalogBox = await _catalogBox;

    // _totalCost -= cartItem.cost * cartItem.selectedQuantity;
    // catalogBox.get(cartItem.id)
    //   ?..maxQuantity += cartItem.selectedQuantity
    //   ..save();
    // box.get('edikii20@mail.ru')!.cartList.remove(cartItem);
    // await box.get('edikii20@mail.ru')!.save();
  }

  Future<void> _setup() async {
    // _cartBox = BoxManager.instance.openCartBox();
    // _catalogBox = BoxManager.instance.openHomeCatalogBox();

    // if (!(await _cartBox).containsKey('edikii20@mail.ru')) {
    //   await (await _cartBox).put('edikii20@mail.ru', UserCart());
    // }
    // _listenableCartBox =
    //     (await _cartBox).listenable(keys: ['edikii20@mail.ru']);
    // _listenableCartBox.addListener(_updateCartList);

    // _cartList = (await _cartBox).get('edikii20@mail.ru')!.cartList;
    // _totalCost = _cartList.fold(
    //     _totalCost,
    //     (previousValue, element) =>
    //         previousValue + element.cost * element.selectedQuantity);
    // notifyListeners();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }
}

class CartPageProvider extends InheritedNotifier<CartPageModel> {
  final CartPageModel model;
  const CartPageProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
          key: key,
        );

  static CartPageProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartPageProvider>();
  }

  static CartPageProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<CartPageProvider>()
        ?.widget;
    return widget is CartPageProvider ? widget : null;
  }
}
