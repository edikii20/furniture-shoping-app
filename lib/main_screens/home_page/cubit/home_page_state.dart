part of 'home_page_cubit.dart';

class HomePageState {
  final int selectedCategoryIndex;
  final List<HomeCategoryItem> categories;
  final List<HomeCatalogItem> catalogOfCategory;
  HomePageState({
    required this.selectedCategoryIndex,
    required this.categories,
    required this.catalogOfCategory,
  });

  HomePageState copyWith({
    int? selectedCategoryIndex,
    List<HomeCategoryItem>? categories,
    List<HomeCatalogItem>? catalogOfCategory,
  }) {
    return HomePageState(
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      categories: categories ?? this.categories,
      catalogOfCategory: catalogOfCategory ?? this.catalogOfCategory,
    );
  }

  @override
  bool operator ==(covariant HomePageState other) {
    if (identical(this, other)) return true;

    return other.selectedCategoryIndex == selectedCategoryIndex &&
        listEquals(other.categories, categories) &&
        listEquals(other.catalogOfCategory, catalogOfCategory);
  }

  @override
  int get hashCode =>
      selectedCategoryIndex.hashCode ^
      categories.hashCode ^
      catalogOfCategory.hashCode;
}
