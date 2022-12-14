import 'package:flutter/material.dart';

import 'package:furniture_shoping_app/main_screens/cart_page/ui/cart_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/favorite_page/ui/favorite_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/home_page/ui/home_page_widget.dart';
import 'package:furniture_shoping_app/main_screens/profile_page/profile_page_widget.dart';

class PagePickerModel extends ChangeNotifier {
  int selectedBottomNavigationBarItemIndex = 0;
  final List<Widget> _mainScreens = [
    const HomePageWidget(),
    const FavoritePageWidget(),
    const CartPageWidget(),
    const ProfilePageWidget(),
  ];

  List<Widget> get mainScreens => _mainScreens;

  void _jumpScrollToStart({required ScrollController? scrollController}) {
    final scrollOffset = scrollController?.offset;
    if (scrollOffset != 0) {
      scrollController?.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void onBottomNavigationBarItemTapped(int index) {
    if (index == selectedBottomNavigationBarItemIndex) {
      if (index == 0) {
        _jumpScrollToStart(
            scrollController:
                homePageGlobalKey.currentState?.homeItemsGridController);
        return;
      } else if (index == 1) {
        _jumpScrollToStart(
            scrollController:
                favoritePageGlobalKey.currentState?.favoriteScrollController);
        return;
      } else {
        return;
      }
    }

    selectedBottomNavigationBarItemIndex = index;
    notifyListeners();
  }
}

class PagePickerProvider extends InheritedNotifier<PagePickerModel> {
  final PagePickerModel model;
  const PagePickerProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
          key: key,
        );

  static PagePickerProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PagePickerProvider>();
  }

  static PagePickerProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<PagePickerProvider>()
        ?.widget;
    return widget is PagePickerProvider ? widget : null;
  }
}
