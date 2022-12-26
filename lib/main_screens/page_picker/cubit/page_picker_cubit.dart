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

  void onItemTapped(int index) {
    if (index == state.selectedItemIndex) {
      emit(state.copyWith(needScrollJump: true));
      emit(state.copyWith(needScrollJump: false));
      return;
    }

    emit(state.copyWith(selectedItemIndex: index));
  }
}
