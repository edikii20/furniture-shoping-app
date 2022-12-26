import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_shoping_app/domain/repositories/shope_repository.dart';
import 'package:furniture_shoping_app/utilities/scroll_jumper_mixin.dart';

import '../../../domain/hive_db/entities/home_catalog_item.dart';
import '../../../domain/hive_db/entities/home_category.dart';

part 'home_page_state.dart';

//TODO: Проверить закрывется ли cubit когда меняется страница
class HomePageCubit extends Cubit<HomePageState> with ScrollJumper {
  final ShopeRepository _shopeRepository;
  HomePageCubit({required ShopeRepository shopeRepository})
      : _shopeRepository = shopeRepository,
        super(HomePageState(
          selectedCategoryIndex: 0,
          categories: [],
          catalogOfCategory: [],
        )) {
    _init();
  }

  Future<void> _init() async {
    final categories = await _shopeRepository.loadCategoties();
    final catalogOfCategory = await _shopeRepository.loadCatalogOfCategory(
      category: categories[state.selectedCategoryIndex],
    );
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

    final catalogOfCategory = await _shopeRepository.loadCatalogOfCategory(
      category: state.categories[index],
    );
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
