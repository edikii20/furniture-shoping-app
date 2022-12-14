import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';
import 'package:furniture_shoping_app/utilities/my_icons_widget.dart';

class ShippingAddressPageWidget extends StatelessWidget {
  const ShippingAddressPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: BaseAppBar(
              title: 'Shipping Address',
              appBar: AppBar(),
              action: null,
              leading: BaseAppBarLeading.back,
              tabBar: false),
          floatingActionButton: const _AddShipingAddressButton(),
          body: const _ShippingAdressListViewWidget(),
        ),
      ),
    );
  }
}

class _ShippingAdressListViewWidget extends StatefulWidget {
  const _ShippingAdressListViewWidget({super.key});

  @override
  State<_ShippingAdressListViewWidget> createState() =>
      _ShippingAdressListViewWidgetState();
}

class _ShippingAdressListViewWidgetState
    extends State<_ShippingAdressListViewWidget> {
  List<ShippingAddressItem> shippingAddressList = [
    ShippingAddressItem(
        fullName: 'Eduard Kyulyan',
        address: 'Apsheronskaya street 11/2',
        zipCode: '354066',
        country: 'Russia',
        city: 'Sochi',
        district: 'Hostinsky',
        useAsDefault: true),
    ShippingAddressItem(
        fullName: 'Eduard Kyulyan',
        address: 'Apsheronskaya street 11/2',
        zipCode: '354066',
        country: 'Russia',
        city: 'Sochi',
        district: 'Hostinsky',
        useAsDefault: false),
    ShippingAddressItem(
        fullName: 'Eduard Kyulyan',
        address: 'Apsheronskaya street 11/2',
        zipCode: '354066',
        country: 'Russia',
        city: 'Sochi',
        district: 'Hostinsky',
        useAsDefault: false),
    ShippingAddressItem(
        fullName: 'Eduard Kyulyan',
        address: 'Apsheronskaya street 11/2',
        zipCode: '354066',
        country: 'Russia',
        city: 'Sochi',
        district: 'Hostinsky',
        useAsDefault: false),
    ShippingAddressItem(
        fullName: 'Eduard Kyulyan',
        address: 'Apsheronskaya street 11/2',
        zipCode: '354066',
        country: 'Russia',
        city: 'Sochi',
        district: 'Hostinsky',
        useAsDefault: false),
    ShippingAddressItem(
        fullName: 'Eduard Kyulyan',
        address: 'Apsheronskaya street 11/2',
        zipCode: '354066',
        country: 'Russia',
        city: 'Sochi',
        district: 'Hostinsky',
        useAsDefault: false),
  ];

  void callback(int index, bool value) {
    setState(() {
      shippingAddressList.asMap().forEach((key, element) {
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
        return _ShippingAdressCardWidget(
          shippingAddressItem: shippingAddressList.elementAt(index),
          callback: callback,
          index: index,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 30,
        );
      },
      itemCount: shippingAddressList.length,
    );
  }
}

class _ShippingAdressCardWidget extends StatelessWidget {
  const _ShippingAdressCardWidget(
      {super.key,
      required this.shippingAddressItem,
      required this.callback,
      required this.index});

  final ShippingAddressItem shippingAddressItem;
  final Function callback;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          shipingAddressCheckBoxWidget(),
          const Spacer(),
          shippingAddressInformationWidget(),
        ],
      ),
    );
  }

  Widget shippingAddressInformationWidget() {
    return Container(
      height: 127,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A959E).withOpacity(0.2),
            offset: const Offset(0, 8),
            blurRadius: 40,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 15, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    shippingAddressItem.fullName,
                    style: const TextStyle(
                      color: Color(0xFF242424),
                      fontFamily: 'NunitoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(0),
                  iconSize: 24,
                  splashRadius: 24,
                  color: const Color(0xFF242424),
                  constraints: BoxConstraints.tight(const Size(24, 24)),
                  icon: const Icon(
                    MyIcons.edit,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
            color: Color(0xFFF0F0F0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 15),
            child: Text(
              '${shippingAddressItem.country}, ${shippingAddressItem.city}, ${shippingAddressItem.district}, ${shippingAddressItem.address}, ${shippingAddressItem.zipCode}',
              style: const TextStyle(
                color: Color(0xFF808080),
                fontFamily: 'NunitoSans',
                fontSize: 14,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget shipingAddressCheckBoxWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            value: shippingAddressItem.useAsDefault,
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
            color: shippingAddressItem.useAsDefault
                ? const Color(0xFF242424)
                : const Color(0xFF999999),
            fontFamily: 'NunitoSans',
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _AddShipingAddressButton extends StatelessWidget {
  const _AddShipingAddressButton({
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
                Navigator.of(context).pushNamed(
                    '/profile/shipping_address/add_shipping_address');
              },
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
      ],
    );
  }
}

class ShippingAddressItem {
  final String fullName;
  final String address;
  final String zipCode;
  final String country;
  final String city;
  final String district;
  bool useAsDefault;

  ShippingAddressItem(
      {required this.fullName,
      required this.address,
      required this.zipCode,
      required this.country,
      required this.city,
      required this.district,
      required this.useAsDefault});
}
