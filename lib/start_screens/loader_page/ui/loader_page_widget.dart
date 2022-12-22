import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:furniture_shoping_app/start_screens/loader_page/cubit/loader_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../../domain/repositories/authorization_repository.dart';

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
    context.read<LoaderCubit>().checkAuth();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderCubit, LoaderState>(
      listenWhen: (previous, current) => current is! LoaderInitial,
      listener: (context, state) {
        if (state is LoaderAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/page_picker');
        } else {
          Navigator.of(context).pushReplacementNamed('/boarding');
        }
      },
      child: Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/lottie/loader.json',
            controller: _animationController,
            height: 125,
            width: 125,
            onLoaded: (composition) {
              _animationController
                ..duration = composition.duration
                ..repeat();
              FlutterNativeSplash.remove();
            },
          ),
        ),
      ),
    );
  }
}
