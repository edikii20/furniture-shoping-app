import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/main_screens/product_detail_page/model/product_detail_page_model.dart';

class ProductDetailPageWidget extends StatefulWidget {
  const ProductDetailPageWidget({super.key});

  @override
  State<ProductDetailPageWidget> createState() =>
      _ProductDetailPageWidgetState();
}

class _ProductDetailPageWidgetState extends State<ProductDetailPageWidget> {
  late final HomeCatalogItem catalogItem;
  late final _model = ProductDetailPageModel(
      maxQuantity: catalogItem.maxQuantity,
      isSelectedBookmark: catalogItem.isFavorite);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    catalogItem = ModalRoute.of(context)!.settings.arguments as HomeCatalogItem;
  }

  @override
  void dispose() async {
    super.dispose();
    await _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProductDetailPageProvider(
      model: _model,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            children: [
              _HeaderProductDetailWidget(catalogItem: catalogItem),
              const SizedBox(height: 20),
              _ContentProductDetailWidget(catalogItem: catalogItem),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContentProductDetailWidget extends StatelessWidget {
  const _ContentProductDetailWidget({
    Key? key,
    required this.catalogItem,
  }) : super(key: key);

  final HomeCatalogItem catalogItem;

  @override
  Widget build(BuildContext context) {
    int quantity =
        ProductDetailPageProvider.watch(context)?.model.quantity ?? 1;
    bool isSelectedBookmark =
        ProductDetailPageProvider.watch(context)?.model.isSelectedBookmark ??
            false;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 16, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            catalogItem.name,
            style: const TextStyle(
              color: Color(0xFF303030),
              fontSize: 24,
              fontFamily: 'Gelasio',
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  '\$ ${catalogItem.cost}',
                  style: const TextStyle(
                    color: Color(0xFF303030),
                    fontSize: 30,
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap:
                    ProductDetailPageProvider.read(context)?.model.onTapMinus,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFE0E0E0),
                  ),
                  child: const Icon(Icons.remove_rounded),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                '${quantity < 10 ? 0 : ''}$quantity',
                style: const TextStyle(
                  color: Color(0xFF242424),
                  fontSize: 18,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: ProductDetailPageProvider.read(context)?.model.onTapPlus,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFE0E0E0),
                  ),
                  child: const Icon(Icons.add_rounded),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFF2C94C),
              ),
              const SizedBox(width: 10),
              Text(
                '${catalogItem.rating}',
                style: const TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 18,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '(${catalogItem.countReviews} reviews)',
                style: const TextStyle(
                  color: Color(0xFF808080),
                  fontSize: 14,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          SizedBox(
            height: 94.4,
            child: Scrollbar(
              thumbVisibility: true,
              radius: const Radius.circular(10),
              thickness: 2,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Text(
                  catalogItem.detailsText,
                  style: const TextStyle(
                    color: Color(0xFF606060),
                    fontSize: 14,
                    fontFamily: 'NunitoSans',
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => ProductDetailPageProvider.read(context)
                      ?.model
                      .onTapBookmark(catalogItem: catalogItem),
                  child: Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF0F0F0),
                    ),
                    child: Icon(
                      isSelectedBookmark
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 34,
                      color: const Color(0xFF242424),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => ProductDetailPageProvider.read(context)
                        ?.model
                        .onPressedAddToCart(
                            context: context, catalogItem: catalogItem),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10),
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF242424),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      fixedSize:
                          MaterialStateProperty.all(const Size.fromHeight(60)),
                    ),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderProductDetailWidget extends StatelessWidget {
  const _HeaderProductDetailWidget({
    Key? key,
    required this.catalogItem,
  }) : super(key: key);

  final HomeCatalogItem catalogItem;

  @override
  Widget build(BuildContext context) {
    int selectedColorIndex =
        ProductDetailPageProvider.watch(context)?.model.selectedColorIndex ?? 0;
    int selectedImageIndex =
        ProductDetailPageProvider.watch(context)?.model.selectedImageIndex ?? 0;
    return CustomMultiChildLayout(
      delegate: _HeaderCustomMultiChildLayoutDelegate(),
      children: [
        LayoutId(
          id: 1,
          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(50)),
            child: PageView(
              onPageChanged: (value) => ProductDetailPageProvider.read(context)
                  ?.model
                  .onImageChanged(value),
              children: [
                Image.asset(
                  catalogItem.imageNames[catalogItem.imageNames.keys
                      .elementAt(selectedColorIndex)]!,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  catalogItem.imageNames[catalogItem.imageNames.keys
                      .elementAt(selectedColorIndex)]!,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  catalogItem.imageNames[catalogItem.imageNames.keys
                      .elementAt(selectedColorIndex)]!,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        LayoutId(
          id: 2,
          child: ElevatedButton(
            onPressed: () => ProductDetailPageProvider.read(context)
                ?.model
                .onPressedBack(context: context),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              alignment: Alignment.center,
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFF242424),
              size: 20,
            ),
          ),
        ),
        LayoutId(
          id: 3,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () => ProductDetailPageProvider.read(context)
                      ?.model
                      .onSelectColor(index: 0),
                  child: CircleAvatar(
                    backgroundColor: selectedColorIndex == 0
                        ? const Color(0xFFABAAAA)
                        : const Color(0xFFF0F0F0),
                    radius: 20,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(int.parse(
                              catalogItem.imageNames.keys.elementAt(0),
                              radix: 16))
                          .withOpacity(1),
                    ),
                  ),
                ),
                const SizedBox(height: 29),
                GestureDetector(
                  onTap: () => ProductDetailPageProvider.read(context)
                      ?.model
                      .onSelectColor(index: 1),
                  child: CircleAvatar(
                    backgroundColor: selectedColorIndex == 1
                        ? const Color(0xFFABAAAA)
                        : const Color(0xFFF0F0F0),
                    radius: 20,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(int.parse(
                              catalogItem.imageNames.keys.elementAt(1),
                              radix: 16))
                          .withOpacity(1),
                    ),
                  ),
                ),
                const SizedBox(height: 29),
                GestureDetector(
                  onTap: () => ProductDetailPageProvider.read(context)
                      ?.model
                      .onSelectColor(index: 2),
                  child: CircleAvatar(
                    backgroundColor: selectedColorIndex == 2
                        ? const Color(0xFFABAAAA)
                        : const Color(0xFFF0F0F0),
                    radius: 20,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(int.parse(
                              catalogItem.imageNames.keys.elementAt(2),
                              radix: 16))
                          .withOpacity(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        LayoutId(
          id: 4,
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                width: selectedImageIndex == 0 ? 30 : 15,
                decoration: BoxDecoration(
                  color: selectedImageIndex == 0
                      ? const Color(0xFF303030)
                      : const Color(0xFFF0F0F0),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3,
                      color: const Color(0xFF303030).withOpacity(0.2),
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                width: selectedImageIndex == 1 ? 30 : 15,
                decoration: BoxDecoration(
                  color: selectedImageIndex == 1
                      ? const Color(0xFF303030)
                      : const Color(0xFFF0F0F0),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3,
                      color: const Color(0xFF303030).withOpacity(0.2),
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                width: selectedImageIndex == 2 ? 30 : 15,
                decoration: BoxDecoration(
                  color: selectedImageIndex == 2
                      ? const Color(0xFF303030)
                      : const Color(0xFFF0F0F0),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 3,
                      color: const Color(0xFF303030).withOpacity(0.2),
                      blurRadius: 7,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeaderCustomMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.biggest.width, 410);
  }

  @override
  void performLayout(Size size) {
    if (hasChild(1) && hasChild(2) && hasChild(3) && hasChild(4)) {
      layoutChild(1, BoxConstraints.tight(Size(size.width - 32, size.height)));
      layoutChild(2, BoxConstraints.tight(const Size(40, 40)));
      layoutChild(3, BoxConstraints.tight(const Size(64, 207)));
      layoutChild(4, BoxConstraints.tight(const Size(80, 4)));

      positionChild(1, const Offset(32, 0));
      positionChild(2, const Offset(12, 40));
      positionChild(3, const Offset(0, 126));
      positionChild(4, Offset(size.width - 120, 380));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return false;
  }
}
