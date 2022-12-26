part of 'product_detail_cubit.dart';

class ProductDetailState {
  final int selectedColorIndex;
  final int selectedImageIndex;
  final int quantity;
  final HomeCatalogItem catalogItem;

  ProductDetailState({
    this.selectedColorIndex = 0,
    this.selectedImageIndex = 0,
    this.quantity = 1,
    required this.catalogItem,
  });

  ProductDetailState copyWith({
    int? selectedColorIndex,
    int? selectedImageIndex,
    int? quantity,
    HomeCatalogItem? catalogItem,
  }) {
    return ProductDetailState(
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      quantity: quantity ?? this.quantity,
      catalogItem: catalogItem ?? this.catalogItem,
    );
  }

  @override
  bool operator ==(covariant ProductDetailState other) {
    if (identical(this, other)) return true;

    return other.selectedColorIndex == selectedColorIndex &&
        other.selectedImageIndex == selectedImageIndex &&
        other.quantity == quantity &&
        other.catalogItem == catalogItem;
  }

  @override
  int get hashCode {
    return selectedColorIndex.hashCode ^
        selectedImageIndex.hashCode ^
        quantity.hashCode ^
        catalogItem.hashCode;
  }
}
