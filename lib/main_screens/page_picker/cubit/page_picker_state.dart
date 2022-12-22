part of 'page_picker_cubit.dart';

class PagePickerState {
  final int selectedItemIndex;
  final List<Widget> mainScreens = [
    const HomePageWidget(),
    const FavoritePageWidget(),
    const CartPageWidget(),
    const ProfilePageWidget(),
  ];

  final List<PreferredSizeWidget> appBars = [
    const HomeAppBar(),
    BaseAppBar(
        title: 'Favorites',
        action: BaseAppBarAction.search,
        leading: null,
        appBar: AppBar(),
        tabBar: false),
    BaseAppBar(
        title: 'My Cart',
        action: null,
        leading: null,
        appBar: AppBar(),
        tabBar: false),
    BaseAppBar(
        title: 'Profile',
        appBar: AppBar(),
        action: BaseAppBarAction.logout,
        leading: null,
        tabBar: false),
  ];

  PagePickerState({
    required this.selectedItemIndex,
  });

  PagePickerState copyWith({
    int? selectedItemIndex,
  }) {
    return PagePickerState(
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
    );
  }

  @override
  bool operator ==(covariant PagePickerState other) {
    if (identical(this, other)) return true;

    return other.selectedItemIndex == selectedItemIndex;
  }

  @override
  int get hashCode => selectedItemIndex.hashCode;
}
