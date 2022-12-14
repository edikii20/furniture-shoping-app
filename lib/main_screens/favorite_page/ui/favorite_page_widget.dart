import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/main_screens/favorite_page/model/favorite_page_model.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';

final favoritePageGlobalKey = GlobalKey<_FavoriteListViewWidgetState>();

class FavoritePageWidget extends StatefulWidget {
  const FavoritePageWidget({super.key});

  @override
  State<FavoritePageWidget> createState() => _FavoritePageWidgetState();
}

class _FavoritePageWidgetState extends State<FavoritePageWidget> {
  final _model = FavoritePageModel();

  @override
  void dispose() async {
    super.dispose();
    await _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FavoritePageProvider(
        model: _model,
        child: Scaffold(
          appBar: BaseAppBar(
              title: 'Favorites',
              action: BaseAppBarAction.search,
              leading: null,
              appBar: AppBar(),
              tabBar: false),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16),
          //   child: _AddAllToCartButtonWidget(),
          // ),
          body: _FavoriteListViewWidget(key: favoritePageGlobalKey),
        ),
      ),
    );
  }
}

// class _AddAllToCartButtonWidget extends StatelessWidget {
//   const _AddAllToCartButtonWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool isEmptyFavoriteList =
//         FavoritePageProvider.watch(context)?.model.favoriteList.isEmpty ?? true;
//     return ElevatedButton(
//       onPressed: isEmptyFavoriteList
//           ? null
//           : FavoritePageProvider.read(context)?.model.onPressedAddAllToCart,
//       style: ButtonStyle(
//         elevation: MaterialStateProperty.all(10),
//         splashFactory: NoSplash.splashFactory,
//         backgroundColor: !isEmptyFavoriteList
//             ? MaterialStateProperty.all(
//                 const Color(0xFF242424),
//               )
//             : MaterialStateProperty.all(
//                 const Color(0xFF999999),
//               ),
//         shape: MaterialStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50)),
//       ),
//       child: const Text(
//         'Add all to my cart',
//         style: TextStyle(
//           color: Color(0xFFFFFFFF),
//           fontSize: 18,
//           fontFamily: 'NunitoSans',
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }

class _FavoriteListViewWidget extends StatefulWidget {
  const _FavoriteListViewWidget({Key? key}) : super(key: key);

  @override
  State<_FavoriteListViewWidget> createState() =>
      _FavoriteListViewWidgetState();
}

class _FavoriteListViewWidgetState extends State<_FavoriteListViewWidget> {
  final favoriteScrollController = ScrollController();

  @override
  void dispose() {
    favoriteScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<HomeCatalogItem> favoriteList =
        FavoritePageProvider.watch(context)?.model.favoriteList ?? [];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: favoriteScrollController,
              padding: const EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
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
                      child: Image.asset(
                        favoriteList[index].imageNames.values.first,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            favoriteList[index].name,
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$ ${favoriteList[index].cost}',
                            style: const TextStyle(
                              color: Color(0xFF242424),
                              fontFamily: 'NunitoSans',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          splashRadius: 24,
                          constraints: BoxConstraints.tight(const Size(24, 24)),
                          onPressed: () => FavoritePageProvider.read(context)
                              ?.model
                              .onPressedRemoveItem(index),
                          icon: const Icon(Icons.cancel_outlined),
                          iconSize: 24,
                        ),
                        const SizedBox(height: 76),
                        GestureDetector(
                          onTap: () {
                            final addToCartFunc =
                                FavoritePageProvider.read(context)
                                    ?.model
                                    .onPressedAddToCartItem;
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  _ChooseColorBottomSheetWidget(
                                colors: favoriteList[index]
                                    .imageNames
                                    .keys
                                    .toList(),
                                itemIndex: index,
                                addToCartFunc: addToCartFunc,
                              ),
                              constraints: BoxConstraints.tight(
                                  const Size(double.infinity, 120)),
                              backgroundColor: Colors.transparent,
                            );
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFE0E0E0),
                            ),
                            child: Image.asset(
                              'assets/icons/shoping_bag_black.png',
                              scale: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: favoriteList.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Color(0xFFF0F0F0),
                  thickness: 1,
                  height: 25,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ChooseColorBottomSheetWidget extends StatelessWidget {
  const _ChooseColorBottomSheetWidget({
    Key? key,
    required this.colors,
    required this.itemIndex,
    required this.addToCartFunc,
  }) : super(key: key);

  final List<String> colors;
  final int itemIndex;
  final addToCartFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          const Text(
            'Choose a color',
            style: TextStyle(
              color: Color(0xFF303030),
              fontFamily: 'Merriweather',
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => addToCartFunc(
                      index: itemIndex,
                      selectedColor: colors[index],
                      context: context),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFDFDFDF),
                    radius: 22,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor:
                          Color(int.parse(colors[index], radix: 16))
                              .withOpacity(1),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 20);
              },
              itemCount: colors.length,
            ),
          ),
        ],
      ),
    );
  }
}
