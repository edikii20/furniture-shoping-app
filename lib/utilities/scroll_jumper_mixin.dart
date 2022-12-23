import 'package:flutter/material.dart';

mixin ScrollJumper {
  void jumpScrollToStart({
    required ScrollController scrollController,
    required bool animated,
  }) {
    if (scrollController.offset == 0) return;
    if (animated) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeIn,
      );
    } else {
      scrollController.jumpTo(0);
    }
  }
}
