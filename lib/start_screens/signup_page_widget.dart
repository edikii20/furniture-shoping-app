import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';
import 'package:furniture_shoping_app/start_screens/header_logo_widget.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 20,
              ),
              HeaderLogoWidget(),
              SizedBox(
                height: 30,
              ),
              Padding(
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
              ),
              SizedBox(
                height: 30,
              ),
              SignupFormWidget(),
            ],
          ),
        ],
      ),
    );
  }
}

class SignupFormWidget extends StatefulWidget {
  const SignupFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupFormWidget> createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  bool isObscure = false;

  void eyeOnPressed() => setState(() {
        isObscure = !isObscure;
      });

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
          TextField(
            obscureText: isObscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              suffixIcon: IconButton(
                icon: isObscure
                    ? const Icon(MyIcons.eyeoff)
                    : const Icon(MyIcons.eye),
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
          TextField(
            obscureText: isObscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              suffixIcon: IconButton(
                icon: isObscure
                    ? const Icon(MyIcons.eyeoff)
                    : const Icon(MyIcons.eye),
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
            margin: const EdgeInsets.only(left: 9.2),
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/login'),
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
                'SIGN UP',
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
            height: 10,
          ),
          Container(
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
                    fixedSize:
                        MaterialStateProperty.all(const Size.fromWidth(65)),
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
          ),
        ],
      ),
    );
  }
}
