import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';

class AddPaymentMethodPageWidget extends StatelessWidget {
  const AddPaymentMethodPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: BaseAppBar(
              title: 'Add Payment Method',
              appBar: AppBar(),
              action: null,
              leading: BaseAppBarLeading.back,
              tabBar: false),
        ),
      ),
    );
  }
}
