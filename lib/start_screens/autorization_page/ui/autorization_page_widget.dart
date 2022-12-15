import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';
import 'package:furniture_shoping_app/utilities/start_screens_header_logo_widget.dart';

class AutorizationPageWidget extends StatelessWidget {
  const AutorizationPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  height: 50,
                ),
                _HeaderWelcomeTextWidget(),
                SizedBox(
                  height: 24,
                ),
                _AutorizationFormWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AutorizationFormWidget extends StatelessWidget {
  const _AutorizationFormWidget({
    Key? key,
  }) : super(key: key);
  final bool isObscure = true;

  void eyeOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.4,
      height: 440,
      padding: const EdgeInsets.only(left: 36, top: 41),
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
            'Email',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 14,
              fontFamily: 'NunitoSans',
            ),
          ),
          const TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            cursorColor: Color(0xFF303030),
            style: TextStyle(
              color: Color(0xFF303030),
              fontSize: 20,
              fontFamily: 'NunitoSans',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Password',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 14,
              fontFamily: 'NunitoSans',
            ),
          ),
          TextField(
            obscureText: isObscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              suffixIcon: IconButton(
                icon: isObscure
                    ? const Icon(MyIcons.eye)
                    : const Icon(MyIcons.eyeoff),
                onPressed: () => eyeOnPressed(),
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
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(left: 76.2),
            child: TextButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size.fromWidth(155)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 18,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            margin: const EdgeInsets.only(left: 9.2),
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/main_page'),
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
              child: const Text(
                'Log in',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 103.2),
            child: TextButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size.fromWidth(95)),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/signup'),
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Color(0xFF303030),
                  fontSize: 18,
                  fontFamily: 'NunitoSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderWelcomeTextWidget extends StatelessWidget {
  const _HeaderWelcomeTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hello !',
            style: TextStyle(
              color: Color(0xFF909090),
              fontSize: 30,
              fontFamily: 'Merriweather',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'WELCOME BACK',
            style: TextStyle(
              color: Color(0xFF303030),
              fontSize: 24,
              fontFamily: 'Merriweather',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.05,
            ),
          ),
        ],
      ),
    );
  }
}
