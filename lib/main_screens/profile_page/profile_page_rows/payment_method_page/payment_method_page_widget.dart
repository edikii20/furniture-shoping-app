import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';

class PaymentMethodPageWidget extends StatelessWidget {
  const PaymentMethodPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: BaseAppBar(
              title: 'Payment Method',
              appBar: AppBar(),
              action: null,
              leading: BaseAppBarLeading.back,
              tabBar: false),
          floatingActionButton: const _AddPaymentMethodButton(),
          body: const _PaymentMethodListViewWidget(),
        ),
      ),
    );
  }
}

class _PaymentMethodListViewWidget extends StatefulWidget {
  const _PaymentMethodListViewWidget({super.key});

  @override
  State<_PaymentMethodListViewWidget> createState() =>
      _PaymentMethodListViewWidgetState();
}

class _PaymentMethodListViewWidgetState
    extends State<_PaymentMethodListViewWidget> {
  List<PaymentCardItem> paymentCardsList = [
    PaymentCardItem(
        cardNumber: '4016306641663454',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '05/24',
        cardType: PaymentCardType.visa,
        useAsDefault: true),
    PaymentCardItem(
        cardNumber: '5132754241474279',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '15/25',
        cardType: PaymentCardType.mastercard,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '4016306641663454',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '05/24',
        cardType: PaymentCardType.visa,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '5132754241474279',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '15/25',
        cardType: PaymentCardType.mastercard,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '4016306641663454',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '05/24',
        cardType: PaymentCardType.visa,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '5132754241474279',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '15/25',
        cardType: PaymentCardType.mastercard,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '4016306641663454',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '05/24',
        cardType: PaymentCardType.visa,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '5132754241474279',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '15/25',
        cardType: PaymentCardType.mastercard,
        useAsDefault: false),
    PaymentCardItem(
        cardNumber: '4016306641663454',
        cardHolderName: 'Eduard Kyulyan',
        expiryDate: '05/24',
        cardType: PaymentCardType.visa,
        useAsDefault: false),
  ];

  void callback(int index, bool value) {
    setState(() {
      paymentCardsList.asMap().forEach((key, element) {
        if (key == index) {
          element.useAsDefault = value;
        } else {
          element.useAsDefault = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      itemBuilder: (context, index) {
        return _SinglePaymentMethodWidget(
          paymentCardItem: paymentCardsList.elementAt(index),
          callback: callback,
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 30,
        );
      },
      itemCount: paymentCardsList.length,
    );
  }
}

class _SinglePaymentMethodWidget extends StatelessWidget {
  const _SinglePaymentMethodWidget(
      {super.key,
      required this.paymentCardItem,
      required this.callback,
      required this.index});
  final PaymentCardItem paymentCardItem;
  final Function callback;
  final int index;

  Image _pickCardTypeIcon() {
    switch (paymentCardItem.cardType) {
      case PaymentCardType.visa:
        return Image.asset(
          'assets/icons/visa.png',
          fit: BoxFit.contain,
          opacity: paymentCardItem.useAsDefault
              ? null
              : const AlwaysStoppedAnimation(0.5),
        );
      case PaymentCardType.mastercard:
        return Image.asset(
          'assets/icons/mastercard.png',
          fit: BoxFit.contain,
          opacity: paymentCardItem.useAsDefault
              ? null
              : const AlwaysStoppedAnimation(0.5),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          paymentCardWidget(),
          const Spacer(),
          paymentCardCheckBoxWidget(),
        ],
      ),
    );
  }

  Widget paymentCardWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CustomPaint(
        painter: CurvePainter(
            cardType: paymentCardItem.cardType,
            useAsDefault: paymentCardItem.useAsDefault),
        child: Container(
          height: 200,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 15, 40, 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                width: 48,
                child: _pickCardTypeIcon(),
              ),
              const Spacer(flex: 1),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: '**** **** **** ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    TextSpan(
                      text: paymentCardItem.cardNumber.substring(12),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'NunitoSans',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Card Holder Name\n',
                            style: TextStyle(
                              color: paymentCardItem.useAsDefault
                                  ? const Color(0xFF999999)
                                  : Colors.white.withOpacity(0.6),
                              fontFamily: 'NunitoSans',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 2.5,
                            ),
                          ),
                          TextSpan(
                            text: paymentCardItem.cardHolderName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'NunitoSans',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Expiry Date\n',
                          style: TextStyle(
                            color: paymentCardItem.useAsDefault
                                ? const Color(0xFF999999)
                                : Colors.white.withOpacity(0.6),
                            fontFamily: 'NunitoSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 2.5,
                          ),
                        ),
                        TextSpan(
                          text: paymentCardItem.expiryDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'NunitoSans',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentCardCheckBoxWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            value: paymentCardItem.useAsDefault,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            splashRadius: 0,
            fillColor: MaterialStateProperty.all(const Color(0xFF303030)),
            onChanged: (value) {
              callback(index, value!);
            },
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'Use as the shipping address',
          style: TextStyle(
            color: paymentCardItem.useAsDefault
                ? const Color(0xFF222222)
                : const Color(0xFF999999),
            fontFamily: 'NunitoSans',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _AddPaymentMethodButton extends StatelessWidget {
  const _AddPaymentMethodButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8A959E).withOpacity(0.3),
                blurRadius: 60,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.add),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/profile/payment_method/add_payment_method');
              },
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ],
    );
  }
}

class CurvePainter extends CustomPainter {
  CurvePainter({required this.cardType, required this.useAsDefault});
  final PaymentCardType cardType;
  final bool useAsDefault;

  Color _pickCurveColor() {
    if (useAsDefault) {
      switch (cardType) {
        case PaymentCardType.visa:
          return const Color(0xFF00296B);
        case PaymentCardType.mastercard:
          return const Color(0xFF2F2F2F);
      }
    } else {
      return const Color(0xFF999999);
    }
  }

  Color _pickCardTypeColor() {
    if (useAsDefault) {
      switch (cardType) {
        case PaymentCardType.visa:
          return const Color(0xFF023e8a);
        case PaymentCardType.mastercard:
          return const Color(0xFF242424);
      }
    } else {
      return const Color(0xFF999999);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..color = _pickCurveColor()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Paint paint0 = Paint()
      ..color = _pickCardTypeColor()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: size.width,
            height: size.height),
        paint0);

    Path path0 = Path();
    path0.moveTo(size.width * 0.1896167, size.height * 1.0007143);
    path0.quadraticBezierTo(size.width * 0.2357167, size.height * 0.5669286,
        size.width * 0.4593500, size.height * 0.5492857);
    path0.cubicTo(
        size.width * 0.5656833,
        size.height * 0.5489286,
        size.width * 0.5712000,
        size.height * 0.6246143,
        size.width * 0.7499417,
        size.height * 0.6431571);
    path0.cubicTo(
        size.width * 0.9148333,
        size.height * 0.6336286,
        size.width * 0.9239250,
        size.height * 0.4535000,
        size.width,
        size.height * 0.4587857);
    path0.quadraticBezierTo(size.width * 1.0006083, size.height * 0.6203429,
        size.width * 1.0001333, size.height * 1.0008571);
    path0.lineTo(size.width * 0.1896167, size.height * 1.0007143);
    path0.close();

    canvas.drawPath(path0, paint1);
  }

  @override
  bool shouldRepaint(covariant CurvePainter oldDelegate) =>
      oldDelegate.useAsDefault != useAsDefault;
}

enum PaymentCardType { visa, mastercard }

class PaymentCardItem {
  final String cardHolderName;
  final String expiryDate;
  final String cardNumber;
  final PaymentCardType cardType;
  bool useAsDefault;

  PaymentCardItem(
      {required this.cardNumber,
      required this.cardHolderName,
      required this.expiryDate,
      required this.cardType,
      required this.useAsDefault});
}
