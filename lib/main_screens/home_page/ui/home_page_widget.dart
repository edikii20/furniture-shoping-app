import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_catalog_item.dart';
import 'package:furniture_shoping_app/domain/hive_db/entities/home_category.dart';
import 'package:furniture_shoping_app/main_screens/home_page/model/home_page_model.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';

final homePageGlobalKey = GlobalKey<_HomeCatalogWidgetState>();

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePageProvider(
      model: HomePageModel(),
      child: const _HomePageBodyWidget(),
    );
  }
}

class _HomePageBodyWidget extends StatelessWidget {
  const _HomePageBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const _HomeCategoriesListWidget(),
          const SizedBox(height: 15),
          _HomeCatalogWidget(
            key: homePageGlobalKey,
          ),
        ],
      ),
    );
  }
}

class _HomeCatalogWidget extends StatefulWidget {
  const _HomeCatalogWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_HomeCatalogWidget> createState() => _HomeCatalogWidgetState();
}

class _HomeCatalogWidgetState extends State<_HomeCatalogWidget> {
  final ScrollController homeItemsGridController = ScrollController();

  @override
  void dispose() {
    homeItemsGridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<HomeCatalogItem> catalog =
        HomePageProvider.watch(context)?.model.catalog ?? [];
    return Expanded(
      child: GridView.builder(
        controller: homeItemsGridController,
        addAutomaticKeepAlives: false,
        itemCount: catalog.length,
        padding: const EdgeInsets.only(bottom: 10),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 21,
          mainAxisSpacing: 15,
          childAspectRatio: (175.2 / 275),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => HomePageProvider.read(context)
                ?.model
                .onTapCatalogItem(index: index, context: context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 228.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        catalog[index].imageNames.values.first,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFF606060).withOpacity(0.4),
                          ),
                          child: Image.asset(
                            'assets/icons/shoping_bag_white.png',
                            scale: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  catalog[index].name,
                  style: const TextStyle(
                    fontFamily: 'NunitoSans',
                    fontSize: 14,
                    color: Color(0xFF606060),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$ ${catalog[index].cost}',
                  style: const TextStyle(
                    fontFamily: 'NunitoSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF303030),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _HomeCategoriesListWidget extends StatelessWidget {
  const _HomeCategoriesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex =
        HomePageProvider.watch(context)?.model.selectedCategoryIndex ?? 0;
    List<HomeCategoryItem> categories =
        HomePageProvider.watch(context)?.model.categories ?? [];
    return SizedBox(
      height: 79,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () => HomePageProvider.read(context)
                    ?.model
                    .onTapCategoryItem(index),
                child: Container(
                  width: 55,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: selectedIndex == index
                        ? const Color(0xFF303030)
                        : const Color(0xFFF5F5F5),
                  ),
                  child: Image.asset(
                    categories[index].iconName,
                    color: selectedIndex == index
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF909090),
                    scale: 4,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                categories[index].name,
                style: TextStyle(
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: selectedIndex == index
                      ? const Color(0xFF242424)
                      : const Color(0xFF999999),
                ),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 25),
        itemCount: categories.length,
      ),
    );
  }
}
