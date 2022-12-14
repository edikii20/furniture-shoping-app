import 'package:flutter/material.dart';

class NavigationErrorPageWidget extends StatelessWidget {
  const NavigationErrorPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Navigation Error Page',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
