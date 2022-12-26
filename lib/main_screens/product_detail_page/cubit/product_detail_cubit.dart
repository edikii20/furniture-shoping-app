import 'package:bloc/bloc.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/repositories/shope_repository.dart';

part 'product_detail_state.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ShopeRepository _shopeRepository;
  ProductDetailCubit(
      {required ShopeRepository shopeRepository,
      required HomeCatalogItem catalogItem})
      : _shopeRepository = shopeRepository,
        super(ProductDetailState(catalogItem: catalogItem));

  void onTapMinus() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void onTapPlus() {
    if (state.quantity < state.catalogItem.maxQuantity) {
      emit(state.copyWith(quantity: state.quantity + 1));
    }
  }

  void onImageChanged({required int value}) {
    emit(state.copyWith(selectedImageIndex: value));
  }

  void onColorChanged({required int index}) {
    if (state.selectedColorIndex == index) {
      return;
    }
    emit(state.copyWith(selectedColorIndex: index));
  }

  Future<void> onTapBookmark() async {
    if (state.catalogItem.isFavorite) {
      await _shopeRepository.removeFromFavorite(
          catalogItemID: state.catalogItem.id);
      emit(state.copyWith(catalogItem: state.catalogItem..isFavorite = false));
    } else {
      await _shopeRepository.addToFavorite(catalogItemID: state.catalogItem.id);
      emit(state.copyWith(catalogItem: state.catalogItem..isFavorite = true));
    }
  }

//TODO: Нужно эмитеть с другим статусом типо добавлен в корзину чтобы можно было вернуться домой
//TODO: Сделать проверку на maxQuantity
  Future<void> onPressedAddToCart() async {
    final catalogItem = state.catalogItem
      ..selectedColor =
          state.catalogItem.imageNames.keys.toList()[state.selectedColorIndex]
      ..selectedQuantity = state.quantity;
    await _shopeRepository.addToCart(
      catalogItemID: state.catalogItem.id,
      selectedColor:
          state.catalogItem.imageNames.keys.toList()[state.selectedColorIndex],
      selectedQuantity: state.quantity,
    );
    emit(state.copyWith(catalogItem: catalogItem));
  }
}
