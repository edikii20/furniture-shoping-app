import 'package:flutter/material.dart';

class BoardingPageWidget extends StatelessWidget {
  const BoardingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(color: Colors.white),
        Positioned(
          height: 731.4,
          width: 411.4,
          child: Image.asset(
            'assets/boarding_img.png',
            fit: BoxFit.cover,
          ),
        ),
        const Positioned(
          top: 205,
          left: 55,
          child: Text(
            'MAKE YOUR',
            style: TextStyle(
              color: Color(0xFF606060),
              fontSize: 24,
              fontFamily: 'Gelasio',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        const Positioned(
          top: 250,
          left: 55,
          child: Text(
            'HOME BEAUTIFUL',
            style: TextStyle(
              color: Color(0xFF303030),
              fontSize: 30,
              fontFamily: 'Gelasio',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        const Positioned(
          width: 286,
          height: 105,
          top: 303,
          left: 84,
          child: Text(
            'The best simple place where you discover most wonderful furnitures and make your home beautiful',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Color(0xFF808080),
              fontSize: 18,
              fontFamily: 'NunitoSans',
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              height: 1.9,
            ),
          ),
        ),
        Positioned(
          width: 159,
          height: 54,
          top: 542,
          child: ElevatedButton(
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('/login'),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              splashFactory: NoSplash.splashFactory,
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF242424)),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 18,
                fontFamily: 'Gelasio',
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
