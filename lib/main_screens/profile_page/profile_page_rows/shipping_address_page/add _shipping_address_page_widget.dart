import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';

class AddShipingAddressPageWidget extends StatelessWidget {
  const AddShipingAddressPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: BaseAppBar(
              title: 'Add Shipping Address',
              appBar: AppBar(),
              action: null,
              leading: BaseAppBarLeading.back,
              tabBar: false),
          body: Container(),
        ),
      ),
    );
  }
}
