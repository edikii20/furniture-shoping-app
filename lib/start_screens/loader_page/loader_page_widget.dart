import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderPageWidget extends StatefulWidget {
  const LoaderPageWidget({super.key});

  @override
  State<LoaderPageWidget> createState() => _LoaderPageWidgetState();
}

class _LoaderPageWidgetState extends State<LoaderPageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Lottie.asset(
          'assets/lottie/loader.json',
          controller: _animationController,
          height: 125,
          width: 125,
          onLoaded: (composition) => _animationController
            ..duration = composition.duration
            ..repeat(),
        ),
      ),
    );
  }
}
