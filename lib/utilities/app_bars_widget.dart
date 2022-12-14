import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';

enum BaseAppBarAction { search, logout }

enum BaseAppBarLeading { back }

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBar appBar;
  final BaseAppBarAction? action;
  final BaseAppBarLeading? leading;
  final bool tabBar;

  const BaseAppBar(
      {super.key,
      required this.title,
      required this.appBar,
      required this.action,
      required this.leading,
      required this.tabBar});

  List<Widget>? _pickActions(BuildContext context) {
    if (action == BaseAppBarAction.search) {
      return [
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {},
            splashRadius: 24,
            icon: const Icon(
              MyIcons.search,
              size: 24,
              color: Color(0xFF242424),
            ),
          ),
        )
      ];
    } else if (action == BaseAppBarAction.logout) {
      return [
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/login'),
            splashRadius: 24,
            icon: const Icon(
              MyIcons.logout,
              size: 24,
              color: Color(0xFF242424),
            ),
          ),
        )
      ];
    }
    return null;
  }

  Widget? _pickLeadings(BuildContext context) {
    if (leading == BaseAppBarLeading.back) {
      return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        // style: ButtonStyle(
        //   padding: MaterialStateProperty.all(EdgeInsets.zero),
        //   alignment: Alignment.center,
        //   backgroundColor: MaterialStateProperty.all(Colors.white),
        // ),
        splashRadius: 20,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF242424),
          size: 20,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF303030),
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      actions: _pickActions(context),
      leading: _pickLeadings(context),
      bottom: tabBar
          ? const TabBar(
              indicatorColor: Color(0xFF242424),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: 'Delivered',
                ),
                Tab(
                  text: 'Processing',
                ),
                Tab(
                  text: 'Canceled',
                ),
              ],
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBar.preferredSize.height + (tabBar ? 50 : 0));
}
