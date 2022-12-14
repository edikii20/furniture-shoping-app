import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_category.dart';
import 'package:furniture_shoping_app/main_screens/cart_page/model/cart_page_model.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';
import 'package:furniture_shoping_app/main_screens/home_page/ui/home_page_widget.dart';

class CartPageWidget extends StatefulWidget {
  const CartPageWidget({super.key});

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}

class _CartPageWidgetState extends State<CartPageWidget> {
  final _model = CartPageModel();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CartPageProvider(
        model: _model,
        child: Scaffold(
          appBar: BaseAppBar(
              title: 'My Cart',
              action: null,
              leading: null,
              appBar: AppBar(),
              tabBar: false),
          body: const _CartPageBodyWidget(),
        ),
      ),
    );
  }
}

class _CartPageBodyWidget extends StatelessWidget {
  const _CartPageBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Expanded(
            child: _CartListItemsWidget(),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Total:',
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                _TotalCostWidget(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed('cart/check_out/congrats'),
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
                  MaterialStateProperty.all(const Size(double.maxFinite, 60)),
            ),
            child: const Text(
              'Check out',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _TotalCostWidget extends StatelessWidget {
  const _TotalCostWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalCost = CartPageProvider.watch(context)?.model.totalCost ?? 0;
    return Text(
      '\$ $totalCost',
      style: const TextStyle(
        color: Color(0xFF303030),
        fontFamily: 'NunitoSans',
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }
}

class _CartListItemsWidget extends StatelessWidget {
  const _CartListItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<HomeCatalogItem> cartList =
        CartPageProvider.watch(context)?.model.cartList ?? [];
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return _CartItemWidget(index: index, cartItem: cartList[index]);
      },
      itemCount: cartList.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Color(0xFFF0F0F0),
          thickness: 1,
          height: 25,
        );
      },
    );
  }
}

class _CartItemWidget extends StatelessWidget {
  const _CartItemWidget({
    Key? key,
    required this.index,
    required this.cartItem,
  }) : super(key: key);

  final int index;
  final HomeCatalogItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130,
          width: 130,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          //TODO: Выбрать исходя из выбраного цвета
          child: Image.asset(
            cartItem.imageNames.values.first,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.name,
                style: const TextStyle(
                  color: Color(0xFF999999),
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '\$ ${cartItem.cost * cartItem.selectedQuantity}',
                style: const TextStyle(
                  color: Color(0xFF242424),
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 54),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => CartPageProvider.read(context)
                        ?.model
                        .onTapMinus(cartItem: cartItem),
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
                    '${cartItem.selectedQuantity < 10 ? 0 : ''}${cartItem.selectedQuantity}',
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
                    onTap: () => CartPageProvider.read(context)
                        ?.model
                        .onTapPlus(cartItem: cartItem),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color(0xFFE0E0E0),
                      ),
                      child: const Icon(Icons.add_rounded),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints.tight(const Size(24, 24)),
          splashRadius: 24,
          onPressed: () => CartPageProvider.read(context)
              ?.model
              .removeCartItem(cartItem: cartItem),
          icon: const Icon(Icons.cancel_outlined),
          iconSize: 24,
        ),
      ],
    );
  }
}


//Promo Code
// const SizedBox(height: 15),
//             Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     spreadRadius: 1,
//                     color: const Color(0xFF303030).withOpacity(0.2),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: TextField(
//                 cursorHeight: 18,
//                 maxLines: 1,
//                 textAlignVertical: TextAlignVertical.center,
//                 decoration: InputDecoration(
//                   contentPadding:
//                       const EdgeInsets.only(bottom: 0, left: 10, right: 2),
//                   hintText: 'Enter your promo code',
//                   hintStyle: const TextStyle(
//                     color: Color(0xFF999999),
//                     fontFamily: 'NunitoSans',
//                     fontSize: 16,
//                   ),
//                   suffixIcon: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF303030),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   constraints:
//                       BoxConstraints.tight(const Size(double.infinity, 44)),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: const BorderSide(
//                       width: 0,
//                       style: BorderStyle.none,
//                     ),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//             ),