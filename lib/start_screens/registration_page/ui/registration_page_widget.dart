import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';
import 'package:furniture_shoping_app/utilities/start_screens_header_logo_widget.dart';

import '../bloc/registration_bloc.dart';

class RegistrationPageWidget extends StatelessWidget {
  const RegistrationPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) => current.error != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error ?? 'Unknown',
                style: const TextStyle(
                  color: Color(0xFF242424),
                  fontSize: 14,
                  fontFamily: 'NunitoSans',
                ),
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              width: 262,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
        child: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  HeaderLogoWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  _WelcomeTextWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  _RegistrationFormWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeTextWidget extends StatelessWidget {
  const _WelcomeTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 36),
      child: Text(
        'WELCOME',
        style: TextStyle(
          color: Color(0xFF303030),
          fontSize: 25,
          fontFamily: 'Merriweather',
          fontWeight: FontWeight.w700,
          letterSpacing: 0.05,
        ),
      ),
    );
  }
}

class _RegistrationFormWidget extends StatefulWidget {
  const _RegistrationFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RegistrationFormWidget> createState() =>
      _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<_RegistrationFormWidget> {
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  final confirmPasswordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.4,
      height: 495,
      padding: const EdgeInsets.only(left: 36, top: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            color: const Color(0xFF303030).withOpacity(0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Name',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 14,
              fontFamily: 'NunitoSans',
            ),
          ),
          _RegistrationNameInputWidget(
              nameInputController: nameInputController),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Email',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 14,
              fontFamily: 'NunitoSans',
            ),
          ),
          _RegistrationEmailInputWidget(
              emailInputController: emailInputController),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Password',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 14,
              fontFamily: 'NunitoSans',
            ),
          ),
          _RegistrationPasswordInputWidget(
              passwordInputController: passwordInputController),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Confirm Password',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 14,
              fontFamily: 'NunitoSans',
            ),
          ),
          _RegistrationConfirmPasswordInputWidget(
              confirmPasswordInputController: confirmPasswordInputController),
          const SizedBox(
            height: 30,
          ),
          _RegistrationSignUpButtonWidget(
            confirmPasswordInputController: confirmPasswordInputController,
            emailInputController: emailInputController,
            nameInputController: nameInputController,
            passwordInputController: passwordInputController,
          ),
          const SizedBox(
            height: 10,
          ),
          const _RegistrationSignInButtonWidget(),
        ],
      ),
    );
  }
}

class _RegistrationSignInButtonWidget extends StatelessWidget {
  const _RegistrationSignInButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50.2),
      child: Row(
        children: [
          const Text(
            'Already have account?',
            style: TextStyle(
              color: Color(0xFF808080),
              fontSize: 14,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(const Size.fromWidth(65)),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
            ),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/login'),
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                color: Color(0xFF303030),
                fontSize: 14,
                fontFamily: 'NunitoSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegistrationSignUpButtonWidget extends StatelessWidget {
  const _RegistrationSignUpButtonWidget({
    Key? key,
    required this.confirmPasswordInputController,
    required this.passwordInputController,
    required this.nameInputController,
    required this.emailInputController,
  }) : super(key: key);

  final TextEditingController nameInputController;
  final TextEditingController emailInputController;
  final TextEditingController passwordInputController;
  final TextEditingController confirmPasswordInputController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) =>
          current.status == RegistrationStatus.complete,
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 1),
            () => Navigator.of(context).pushReplacementNamed('/login'));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 9.2),
        child: BlocBuilder<RegistrationBloc, RegistrationState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state.status == RegistrationStatus.uncomplete
                  ? () => context
                      .read<RegistrationBloc>()
                      .add(RegistrationSignUpEvent(
                        name: nameInputController.text,
                        email: emailInputController.text,
                        password: passwordInputController.text,
                        confirmPassword: confirmPasswordInputController.text,
                      ))
                  : null,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(10),
                splashFactory: NoSplash.splashFactory,
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xFF242424),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                fixedSize: MaterialStateProperty.all(const Size(285, 50)),
              ),
              child: state.status == RegistrationStatus.inprogress
                  ? const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  : state.status == RegistrationStatus.complete
                      ? const _CompleteIconWidget()
                      : const Text(
                          'SIGN UP',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 18,
                            fontFamily: 'NunitoSans',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}

class _RegistrationConfirmPasswordInputWidget extends StatelessWidget {
  const _RegistrationConfirmPasswordInputWidget({
    Key? key,
    required this.confirmPasswordInputController,
  }) : super(key: key);

  final TextEditingController confirmPasswordInputController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.isPasswordObscure != current.isPasswordObscure,
      builder: (context, state) {
        return TextField(
          controller: confirmPasswordInputController,
          obscureText: state.isPasswordObscure,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
          ),
          cursorColor: const Color(0xFF303030),
          style: const TextStyle(
            color: Color(0xFF303030),
            fontSize: 20,
            fontFamily: 'NunitoSans',
          ),
        );
      },
    );
  }
}

class _RegistrationPasswordInputWidget extends StatelessWidget {
  const _RegistrationPasswordInputWidget({
    Key? key,
    required this.passwordInputController,
  }) : super(key: key);

  final TextEditingController passwordInputController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.isPasswordObscure != current.isPasswordObscure,
      builder: (context, state) {
        return TextField(
          controller: passwordInputController,
          obscureText: state.isPasswordObscure,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            suffixIcon: IconButton(
              icon: state.isPasswordObscure
                  ? const Icon(MyIcons.eye)
                  : const Icon(MyIcons.eyeoff),
              onPressed: () => context
                  .read<RegistrationBloc>()
                  .add(RegistrationOnPressEyeEvent()),
              color: const Color(0xFF242424),
              iconSize: 20,
              padding: const EdgeInsets.only(right: 5),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
          cursorColor: const Color(0xFF303030),
          style: const TextStyle(
            color: Color(0xFF303030),
            fontSize: 20,
            fontFamily: 'NunitoSans',
          ),
        );
      },
    );
  }
}

class _RegistrationEmailInputWidget extends StatelessWidget {
  const _RegistrationEmailInputWidget({
    Key? key,
    required this.emailInputController,
  }) : super(key: key);
  final TextEditingController emailInputController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailInputController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
      cursorColor: const Color(0xFF303030),
      style: const TextStyle(
        color: Color(0xFF303030),
        fontSize: 20,
        fontFamily: 'NunitoSans',
      ),
    );
  }
}

class _RegistrationNameInputWidget extends StatelessWidget {
  const _RegistrationNameInputWidget({
    Key? key,
    required this.nameInputController,
  }) : super(key: key);

  final TextEditingController nameInputController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameInputController,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
      cursorColor: const Color(0xFF303030),
      style: const TextStyle(
        color: Color(0xFF303030),
        fontSize: 20,
        fontFamily: 'NunitoSans',
      ),
    );
  }
}

class _CompleteIconWidget extends StatefulWidget {
  const _CompleteIconWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_CompleteIconWidget> createState() => _CompleteIconWidgetState();
}

class _CompleteIconWidgetState extends State<_CompleteIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    final curve = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            color: const Color(0xFF27AE60),
            borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.done_rounded,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
