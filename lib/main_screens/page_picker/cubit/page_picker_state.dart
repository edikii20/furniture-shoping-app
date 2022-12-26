part of 'page_picker_cubit.dart';

class PagePickerState {
  final int selectedItemIndex;
  final bool needScrollJump;
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
    required this.needScrollJump,
  });

  PagePickerState copyWith({
    int? selectedItemIndex,
    bool? needScrollJump,
  }) {
    return PagePickerState(
      selectedItemIndex: selectedItemIndex ?? this.selectedItemIndex,
      needScrollJump: needScrollJump ?? false,
    );
  }

  @override
  bool operator ==(covariant PagePickerState other) {
    if (identical(this, other)) return true;

    return other.selectedItemIndex == selectedItemIndex &&
        other.needScrollJump == needScrollJump;
  }

  @override
  int get hashCode => selectedItemIndex.hashCode ^ needScrollJump.hashCode;
}
