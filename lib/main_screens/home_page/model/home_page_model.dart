import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/data_provider/box_manager.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_category.dart';
import 'package:furniture_shoping_app/main_screens/home_page/ui/home_page_widget.dart';
import 'package:hive/hive.dart';

class HomePageModel extends ChangeNotifier {
  int selectedCategoryIndex = 0;
  late final Future<Box<HomeCategoryItem>> _categoriesBox;
  late final Future<Box<HomeCatalogItem>> _catalogBox;
  late List<HomeCategoryItem> _categories = [];
  late List<HomeCatalogItem>? _catalogOfSelectedCategory = [];

  List<HomeCategoryItem> get categories => _categories;
  List<HomeCatalogItem>? get catalog => _catalogOfSelectedCategory;
  HomePageModel() {
    _setup();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await BoxManager.instance.closeBox(await _categoriesBox);
  }

  void onTapCatalogItem({required int index, required BuildContext context}) {
    Navigator.of(context).pushNamed('/product_detail',
        arguments: _catalogOfSelectedCategory![index]);
  }

  void onTapCategoryItem(int index) {
    if (index == selectedCategoryIndex) {
      return;
    }

    selectedCategoryIndex = index;
    final selectedCategoty = _categories.elementAt(selectedCategoryIndex);
    _loadCatalogOfSelectedCategory(selectedCategoty);

    _jumpCatalogToStart();
    notifyListeners();
  }

  void _jumpCatalogToStart() {
    final scrollOffset =
        homePageGlobalKey.currentState?.homeItemsGridController.offset;
    if (scrollOffset != 0) {
      homePageGlobalKey.currentState?.homeItemsGridController.jumpTo(0);
    }
  }

  Future<void> _loadCategoties() async {
    _categories = (await _categoriesBox).values.toList();
  }

  Future<void> _loadCatalogOfSelectedCategory(HomeCategoryItem category) async {
    await _catalogBox;
    _catalogOfSelectedCategory = category.catalog.toList();
  }

  Future<void> _setup() async {
    _categoriesBox = BoxManager.instance.openHomeCategoriesBox();
    _catalogBox = BoxManager.instance.openHomeCatalogBox();
    await _setupDefaultContent();

    await _loadCategoties();
    await _loadCatalogOfSelectedCategory(
        _categories.elementAt(selectedCategoryIndex));
    notifyListeners();
  }

  Future<void> _setupDefaultContent() async {
    if ((await _categoriesBox).values.isEmpty) {
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

      await (await _catalogBox).addAll(defaultCatalog);
      var popularCatalog = HiveList((await _catalogBox),
          objects: (await _catalogBox).values.toList());
      var chairCatalog = HiveList((await _catalogBox),
          objects: (await _catalogBox)
              .values
              .where((element) => element.name == 'Coffee Chair')
              .toList());
      var tableCatalog = HiveList((await _catalogBox),
          objects: (await _catalogBox)
              .values
              .where((element) =>
                  element.name == 'Simple Desk' ||
                  element.name == 'Minimal Stand')
              .toList());
      var armchairCatalog = HiveList((await _catalogBox),
          objects: (await _catalogBox).values.toList().sublist(0, 5));
      var bedCatalog = HiveList((await _catalogBox),
          objects: (await _catalogBox).values.toList().sublist(3, 7));
      var lampCatalog = HiveList((await _catalogBox),
          objects: (await _catalogBox)
              .values
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

      await (await _categoriesBox).addAll(defaultCategoiesList);
    }
  }
}

class HomePageProvider extends InheritedNotifier<HomePageModel> {
  final HomePageModel model;
  const HomePageProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
          key: key,
        );

  static HomePageProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomePageProvider>();
  }

  static HomePageProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<HomePageProvider>()
        ?.widget;
    return widget is HomePageProvider ? widget : null;
  }
}
