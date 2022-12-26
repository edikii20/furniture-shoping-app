import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shoping_app/main_screens/home_page/cubit/home_page_cubit.dart';
import 'package:furniture_shoping_app/main_screens/page_picker/cubit/page_picker_cubit.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final catalogScrollController = ScrollController();

  @override
  void dispose() {
    catalogScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PagePickerCubit, PagePickerState>(
      listenWhen: (previous, current) => current.needScrollJump,
      listener: (context, state) {
        context.read<HomePageCubit>().jumpScrollToStart(
            scrollController: catalogScrollController, animated: true);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _HomeCategoriesListWidget(
                catalogScrollController: catalogScrollController),
            const SizedBox(height: 15),
            _HomeCatalogWidget(
                catalogScrollController: catalogScrollController),
          ],
        ),
      ),
    );
  }
}

class _HomeCatalogWidget extends StatelessWidget {
  const _HomeCatalogWidget({
    Key? key,
    required this.catalogScrollController,
  }) : super(key: key);

  final ScrollController catalogScrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<HomePageCubit, HomePageState>(
        buildWhen: (previous, current) =>
            previous.catalogOfCategory != current.catalogOfCategory,
        builder: (context, state) {
          return GridView.builder(
            controller: catalogScrollController,
            addAutomaticKeepAlives: false,
            itemCount: state.catalogOfCategory.length,
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
                onTap: () => Navigator.of(context).pushNamed('/product_detail',
                    arguments: state.catalogOfCategory[index]),
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
                            state.catalogOfCategory[index].imageNames.values
                                .first,
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
                      state.catalogOfCategory[index].name,
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
                        color: Color(0xFF606060),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$ ${state.catalogOfCategory[index].cost}',
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
          );
        },
      ),
    );
  }
}

class _HomeCategoriesListWidget extends StatelessWidget {
  const _HomeCategoriesListWidget(
      {Key? key, required this.catalogScrollController})
      : super(key: key);

  final ScrollController catalogScrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 79,
      child: BlocBuilder<HomePageCubit, HomePageState>(
        buildWhen: (previous, current) =>
            previous.selectedCategoryIndex != current.selectedCategoryIndex ||
            previous.categories.isEmpty,
        builder: (context, state) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () => context.read<HomePageCubit>().onTapCategory(
                        index: index,
                        catalogScrollController: catalogScrollController),
                    child: Container(
                      width: 55,
                      height: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: state.selectedCategoryIndex == index
                            ? const Color(0xFF303030)
                            : const Color(0xFFF5F5F5),
                      ),
                      child: Image.asset(
                        state.categories[index].iconName,
                        color: state.selectedCategoryIndex == index
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF909090),
                        scale: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    state.categories[index].name,
                    style: TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: state.selectedCategoryIndex == index
                          ? const Color(0xFF242424)
                          : const Color(0xFF999999),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 25),
            itemCount: state.categories.length,
          );
        },
      ),
    );
  }
}
