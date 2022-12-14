import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/main_screens/page_picker/model/page_picker_model.dart';

class PagePickerWidget extends StatefulWidget {
  const PagePickerWidget({super.key});

  @override
  State<PagePickerWidget> createState() => _PagePickerWidgetState();
}

class _PagePickerWidgetState extends State<PagePickerWidget> {
  final _model = PagePickerModel();

  @override
  Widget build(BuildContext context) {
    return PagePickerProvider(
      model: _model,
      child: const _PagePickerBodyWidget(),
    );
  }
}

class _PagePickerBodyWidget extends StatelessWidget {
  const _PagePickerBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = PagePickerProvider.watch(context)
            ?.model
            .selectedBottomNavigationBarItemIndex ??
        0;
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          iconSize: 28,
          currentIndex: currentIndex,
          onTap: (index) => PagePickerProvider.read(context)
              ?.model
              .onBottomNavigationBarItemTapped(index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: currentIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 1
                  ? const Icon(Icons.bookmark_rounded)
                  : const Icon(Icons.bookmark_border_rounded),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 2
                  ? const Icon(Icons.shopping_bag)
                  : const Icon(Icons.shopping_bag_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: currentIndex == 3
                  ? const Icon(Icons.person_rounded)
                  : const Icon(Icons.person_outline_rounded),
              label: '',
            ),
          ],
        ),
      ),
      body: PagePickerProvider.read(context)
          ?.model
          .mainScreens
          .elementAt(currentIndex),
    );
  }
}
