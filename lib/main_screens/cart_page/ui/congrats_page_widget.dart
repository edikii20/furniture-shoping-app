import 'package:flutter/material.dart';

class CongratsPageWidget extends StatelessWidget {
  const CongratsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SUCCESS!',
                  style: TextStyle(
                    color: Color(0xFF303030),
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                    letterSpacing: 1.05,
                  ),
                ),
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    const SizedBox(
                      height: 251,
                    ),
                    SizedBox(
                      width: 270,
                      height: 230,
                      child: Image.asset(
                        'assets/success_img_4.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      child: _CompleteIconWidget(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Your order will be delivered soon.\nThank you for choosing our app!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF606060),
                    fontFamily: 'NunitoSans',
                    fontSize: 18,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/profile/orders');
                  },
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF242424)),
                    splashFactory: NoSplash.splashFactory,
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    fixedSize: MaterialStateProperty.all(const Size(363.4, 60)),
                  ),
                  child: const Text(
                    'Track your orders',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NunitoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    side: MaterialStateProperty.all(
                      const BorderSide(
                        color: Color(0xFF303030),
                        width: 1,
                      ),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    fixedSize: MaterialStateProperty.all(const Size(363.4, 60)),
                    overlayColor: MaterialStateProperty.all(
                        const Color(0xFF999999).withOpacity(0.3)),
                  ),
                  child: const Text(
                    'BACK TO HOME',
                    style: TextStyle(
                      color: Color(0xFF303030),
                      fontFamily: 'NunitoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
      duration: const Duration(milliseconds: 1500),
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
        width: 42,
        height: 42,
        decoration: BoxDecoration(
            color: const Color(0xFF27AE60),
            borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.done_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
