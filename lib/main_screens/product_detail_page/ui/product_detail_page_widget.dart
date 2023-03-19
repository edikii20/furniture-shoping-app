import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shoping_app/main_screens/product_detail_page/cubit/product_detail_cubit.dart';

class ProductDetailPageWidget extends StatelessWidget {
  const ProductDetailPageWidget({super.key});

//TODO: Починить Quantity
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          children: const [
            _HeaderProductDetailWidget(),
            SizedBox(height: 20),
            _ContentProductDetailWidget(),
          ],
        ),
      ),
    );
  }
}

class _ContentProductDetailWidget extends StatelessWidget {
  const _ContentProductDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 16, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ProductNameWidget(),
          const SizedBox(height: 10),
          const _ProductQuantitySelectionWidget(),
          const SizedBox(height: 5),
          Row(
            children: const [
              Icon(
                Icons.star,
                color: Color(0xFFF2C94C),
              ),
              SizedBox(width: 10),
              _ProductRatingWidget(),
              SizedBox(width: 20),
              _ProductReviewsWidget(),
            ],
          ),
          const SizedBox(height: 11),
          const _ProductDetailsTextWidget(),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: Row(
              children: const [
                _ProductBookmarkButtonWidget(),
                SizedBox(width: 15),
                _ProductAddToCartButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductAddToCartButtonWidget extends StatelessWidget {
  const _ProductAddToCartButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () =>
            context.read<ProductDetailCubit>().onPressedAddToCart(),
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
          fixedSize: MaterialStateProperty.all(const Size.fromHeight(60)),
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
    );
  }
}

//TODO: Билдется всегда, нужно сделать чтобы билделся если favorite другой
// Проблема в том что prev и cur стейт почему-то приходят одинаковыми хотя не должны
// Есть мысль что это из-за того что home_catalog_item entity не иммутабельная
class _ProductBookmarkButtonWidget extends StatelessWidget {
  const _ProductBookmarkButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ProductDetailCubit>().onTapBookmark(),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF0F0F0),
        ),
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            return Icon(
              state.catalogItem.isFavorite
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              size: 34,
              color: const Color(0xFF242424),
            );
          },
        ),
      ),
    );
  }
}

class _ProductDetailsTextWidget extends StatelessWidget {
  const _ProductDetailsTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94.4,
      child: Scrollbar(
        thumbVisibility: true,
        radius: const Radius.circular(10),
        thickness: 2,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            buildWhen: (previous, current) =>
                previous.catalogItem.detailsText !=
                current.catalogItem.detailsText,
            builder: (context, state) {
              return Text(
                state.catalogItem.detailsText,
                style: const TextStyle(
                  color: Color(0xFF606060),
                  fontSize: 14,
                  fontFamily: 'NunitoSans',
                  decoration: TextDecoration.none,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProductReviewsWidget extends StatelessWidget {
  const _ProductReviewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.catalogItem.countReviews != current.catalogItem.countReviews,
      builder: (context, state) {
        return Text(
          '(${state.catalogItem.countReviews} reviews)',
          style: const TextStyle(
            color: Color(0xFF808080),
            fontSize: 14,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        );
      },
    );
  }
}

class _ProductRatingWidget extends StatelessWidget {
  const _ProductRatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.catalogItem.rating != current.catalogItem.rating,
      builder: (context, state) {
        return Text(
          '${state.catalogItem.rating}',
          style: const TextStyle(
            color: Color(0xFF303030),
            fontSize: 18,
            fontFamily: 'NunitoSans',
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none,
          ),
        );
      },
    );
  }
}

class _ProductQuantitySelectionWidget extends StatelessWidget {
  const _ProductQuantitySelectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            buildWhen: (previous, current) =>
                previous.catalogItem.cost != current.catalogItem.cost,
            builder: (context, state) {
              return Text(
                '\$ ${state.catalogItem.cost}',
                style: const TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 30,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: context.read<ProductDetailCubit>().onTapMinus,
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
        BlocBuilder<ProductDetailCubit, ProductDetailState>(
          buildWhen: (previous, current) =>
              previous.quantity != current.quantity,
          builder: (context, state) {
            return Text(
              '${state.quantity < 10 ? 0 : ''}${state.quantity}',
              style: const TextStyle(
                color: Color(0xFF242424),
                fontSize: 18,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            );
          },
        ),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: context.read<ProductDetailCubit>().onTapPlus,
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
    );
  }
}

class _ProductNameWidget extends StatelessWidget {
  const _ProductNameWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.catalogItem.name != current.catalogItem.name,
      builder: (context, state) {
        return Text(
          state.catalogItem.name,
          style: const TextStyle(
            color: Color(0xFF303030),
            fontSize: 24,
            fontFamily: 'Gelasio',
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        );
      },
    );
  }
}

class _HeaderProductDetailWidget extends StatelessWidget {
  const _HeaderProductDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _HeaderCustomMultiChildLayoutDelegate(),
      children: [
        LayoutId(
          id: 1,
          child: const ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            child: _ProductImagesWidget(),
          ),
        ),
        LayoutId(
          id: 2,
          child: const _BackButtonWidget(),
        ),
        LayoutId(
          id: 3,
          child: const _ProductColorPickerWidget(),
        ),
        LayoutId(
          id: 4,
          child: const _ProductImagesSelectrorWidget(),
        ),
      ],
    );
  }
}

class _ProductImagesSelectrorWidget extends StatelessWidget {
  const _ProductImagesSelectrorWidget({
    Key? key,
  }) : super(key: key);

//TODO: Сделать через ListViev.builder()
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.selectedImageIndex != current.selectedImageIndex,
      builder: (context, state) {
        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
              width: state.selectedImageIndex == 0 ? 30 : 15,
              decoration: BoxDecoration(
                color: state.selectedImageIndex == 0
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
              width: state.selectedImageIndex == 1 ? 30 : 15,
              decoration: BoxDecoration(
                color: state.selectedImageIndex == 1
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
              width: state.selectedImageIndex == 2 ? 30 : 15,
              decoration: BoxDecoration(
                color: state.selectedImageIndex == 2
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
        );
      },
    );
  }
}

class _ProductColorPickerWidget extends StatelessWidget {
  const _ProductColorPickerWidget({
    Key? key,
  }) : super(key: key);

//TODO: Сделать через ListViev.builder()
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
        buildWhen: (previous, current) =>
            previous.selectedColorIndex != current.selectedColorIndex,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () =>
                    context.read<ProductDetailCubit>().onColorChanged(index: 0),
                child: CircleAvatar(
                  backgroundColor: state.selectedColorIndex == 0
                      ? const Color(0xFFABAAAA)
                      : const Color(0xFFF0F0F0),
                  radius: 20,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(int.parse(
                            state.catalogItem.imageNames.keys.elementAt(0),
                            radix: 16))
                        .withOpacity(1),
                  ),
                ),
              ),
              const SizedBox(height: 29),
              GestureDetector(
                onTap: () =>
                    context.read<ProductDetailCubit>().onColorChanged(index: 1),
                child: CircleAvatar(
                  backgroundColor: state.selectedColorIndex == 1
                      ? const Color(0xFFABAAAA)
                      : const Color(0xFFF0F0F0),
                  radius: 20,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(int.parse(
                            state.catalogItem.imageNames.keys.elementAt(1),
                            radix: 16))
                        .withOpacity(1),
                  ),
                ),
              ),
              const SizedBox(height: 29),
              GestureDetector(
                onTap: () =>
                    context.read<ProductDetailCubit>().onColorChanged(index: 2),
                child: CircleAvatar(
                  backgroundColor: state.selectedColorIndex == 2
                      ? const Color(0xFFABAAAA)
                      : const Color(0xFFF0F0F0),
                  radius: 20,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(int.parse(
                            state.catalogItem.imageNames.keys.elementAt(2),
                            radix: 16))
                        .withOpacity(1),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BackButtonWidget extends StatelessWidget {
  const _BackButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pop(),
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
    );
  }
}

class _ProductImagesWidget extends StatelessWidget {
  const _ProductImagesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      buildWhen: (previous, current) =>
          previous.selectedColorIndex != current.selectedColorIndex,
      builder: (context, state) {
        return PageView.builder(
          onPageChanged: (value) =>
              context.read<ProductDetailCubit>().onImageChanged(value: value),
          itemBuilder: (context, index) => Image.asset(
            state.catalogItem.imageNames[state.catalogItem.imageNames.keys
                .elementAt(state.selectedColorIndex)]!,
            fit: BoxFit.cover,
          ),
          itemCount: 3,
        );
      },
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
