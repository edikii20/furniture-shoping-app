import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';

import '../../domain/repositories/authorization_repository.dart';

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
    _checkAuth();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _checkAuth() async {
    await context.read<AuthorisationRepository>().checkAuth()
        ? Navigator.of(context).pushReplacementNamed('/page_picker')
        : Navigator.of(context).pushReplacementNamed('/boarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/loader.json',
          controller: _animationController,
          height: 125,
          width: 125,
          onLoaded: (composition) {
            FlutterNativeSplash.remove();
            _animationController
              ..duration = composition.duration
              ..repeat();
          },
        ),
      ),
    );
  }
}
