import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';

import '../../cart_page/ui/cart_page_widget.dart';
import '../../favorite_page/ui/favorite_page_widget.dart';
import '../../home_page/ui/home_page_widget.dart';
import '../../profile_page/profile_page_widget.dart';

part 'page_picker_state.dart';

class PagePickerCubit extends Cubit<PagePickerState> {
  PagePickerCubit()
      : super(PagePickerState(
          selectedItemIndex: 0,
          needScrollJump: false,
        ));
//TODO: Решить проблему при которой, если два раза нажать Double Tap по элементу,
// то стейт два раза подряд будет true и ничего не поменяется, блок будет думать что стейт не поменялся
  void onItemTapped(int index) {
    if (index == state.selectedItemIndex) {
      emit(state.copyWith(needScrollJump: true));
      return;
    }

    emit(state.copyWith(selectedItemIndex: index));
  }
}
