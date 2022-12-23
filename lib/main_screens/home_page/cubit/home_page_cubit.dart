import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_shoping_app/domain/repositories/shope_repository.dart';
import 'package:furniture_shoping_app/utilities/scroll_jumper_mixin.dart';

import '../../../domain/hive_db/entities/home_catalog_item.dart';
import '../../../domain/hive_db/entities/home_category.dart';

part 'home_page_state.dart';

//TODO: Нужно подумать когда закрывать Shope Repository боксы
class HomePageCubit extends Cubit<HomePageState> with ScrollJumper {
  final shopeRepository = ShopeRepository();
  HomePageCubit()
      : super(HomePageState(
          selectedCategoryIndex: 0,
          categories: [],
          catalogOfCategory: [],
        )) {
    _init();
  }

  Future<void> _init() async {
    final categories = await shopeRepository.loadCategoties();
    final catalogOfCategory = await shopeRepository
        .loadCatalogOfCategory(categories[state.selectedCategoryIndex]);
    emit(state.copyWith(
      categories: categories,
      catalogOfCategory: catalogOfCategory,
    ));
  }

  Future<void> onTapCategory({
    required int index,
    required ScrollController catalogScrollController,
  }) async {
    if (index == state.selectedCategoryIndex) return;

    final catalogOfCategory =
        await shopeRepository.loadCatalogOfCategory(state.categories[index]);
    emit(state.copyWith(
      selectedCategoryIndex: index,
      catalogOfCategory: catalogOfCategory,
    ));

    jumpScrollToStart(
      scrollController: catalogScrollController,
      animated: false,
    );
  }
}
