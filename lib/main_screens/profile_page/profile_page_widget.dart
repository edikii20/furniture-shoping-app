import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key});

  @override
  State<ProfilePageWidget> createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: 'Profile',
          appBar: AppBar(),
          action: BaseAppBarAction.logout,
          leading: null,
          tabBar: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://sun1-98.userapi.com/s/v1/if2/ONaXSArMBF5bsPzMvMPXE5RrM7F2s8DkDGUp25Dco2xySFP7zJPPwryWiXhW6D7eJ7QJxx5jAVfvljEWONQ8cFoA.jpg?size=400x400&quality=96&crop=0,0,639,639&ava=1',
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eduard Kyulyan',
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFF303030),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'edikii20@mail.ru',
                      style: const TextStyle(
                        fontFamily: 'NunitoSans',
                        fontSize: 14,
                        color: Color(0xFF808080),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            const _ProfileRowButtonWidget(
                rowButtonTitle: 'My Orders',
                rowButtonSubTitle: 'Already have 10 orders',
                rowButtonRouteName: '/profile/orders'),
            const SizedBox(height: 15),
            const _ProfileRowButtonWidget(
                rowButtonTitle: 'Shipping Addresses',
                rowButtonSubTitle: '3 Addresses',
                rowButtonRouteName: '/profile/shipping_address'),
            const SizedBox(height: 15),
            const _ProfileRowButtonWidget(
                rowButtonTitle: 'Payment Method',
                rowButtonSubTitle: 'You have 2 cards',
                rowButtonRouteName: '/profile/payment_method'),
            const SizedBox(height: 15),
            const _ProfileRowButtonWidget(
                rowButtonTitle: 'My Reviews',
                rowButtonSubTitle: 'Reviews for 5 items',
                rowButtonRouteName: '/profile/my_reviews'),
            const SizedBox(height: 15),
            const _ProfileRowButtonWidget(
                rowButtonTitle: 'Settings',
                rowButtonSubTitle: 'Notification, Password, FAQ, Contact',
                rowButtonRouteName: '/profile/settings'),
          ],
        ),
      ),
    );
  }
}

class _ProfileRowButtonWidget extends StatelessWidget {
  const _ProfileRowButtonWidget(
      {Key? key,
      required this.rowButtonTitle,
      required this.rowButtonSubTitle,
      required this.rowButtonRouteName})
      : super(key: key);

  final String rowButtonTitle;
  final String rowButtonSubTitle;
  final String rowButtonRouteName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(rowButtonRouteName),
      child: Container(
        height: 78,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: const Color(0xFF303030).withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.fromLTRB(20, 18, 10, 17),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rowButtonTitle,
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Color(0xFF242424),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    rowButtonSubTitle,
                    style: const TextStyle(
                      fontFamily: 'NunitoSans',
                      fontSize: 12,
                      color: Color(0xFF808080),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
