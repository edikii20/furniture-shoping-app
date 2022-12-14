import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';

class HeaderLogoWidget extends StatelessWidget {
  const HeaderLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 36,
        ),
        Container(
          width: 111,
          height: 1,
          color: const Color(0xFFBDBDBD),
        ),
        const SizedBox(
          width: 23.7,
        ),
        const Icon(
          MyIcons.sofaLamp,
          size: 70,
        ),
        const SizedBox(
          width: 23.7,
        ),
        Container(
          width: 111,
          height: 1,
          color: const Color(0xFFBDBDBD),
        ),
        const SizedBox(
          width: 36,
        ),
      ],
    );
  }
}
