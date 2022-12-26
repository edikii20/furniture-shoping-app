import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shoping_app/main_screens/page_picker/cubit/page_picker_cubit.dart';

class PagePickerWidget extends StatelessWidget {
  const PagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocBuilder<PagePickerCubit, PagePickerState>(
          buildWhen: (previous, current) =>
              previous.selectedItemIndex != current.selectedItemIndex,
          builder: (context, state) {
            return Scaffold(
              appBar: state.appBars[state.selectedItemIndex],
              bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  iconSize: 28,
                  currentIndex: state.selectedItemIndex,
                  onTap: (index) =>
                      context.read<PagePickerCubit>().onItemTapped(index),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: state.selectedItemIndex == 0
                          ? const Icon(Icons.home)
                          : const Icon(Icons.home_outlined),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedItemIndex == 1
                          ? const Icon(Icons.bookmark_rounded)
                          : const Icon(Icons.bookmark_border_rounded),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedItemIndex == 2
                          ? const Icon(Icons.shopping_bag)
                          : const Icon(Icons.shopping_bag_outlined),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: state.selectedItemIndex == 3
                          ? const Icon(Icons.person_rounded)
                          : const Icon(Icons.person_outline_rounded),
                      label: '',
                    ),
                  ],
                ),
              ),
              body: state.mainScreens[state.selectedItemIndex],
            );
          },
        ),
      ),
    );
  }
}
