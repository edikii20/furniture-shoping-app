import 'package:flutter/material.dart';
import 'package:furniture_shoping_app/utilities/app_bars_widget.dart';

class OrdersPageWidget extends StatelessWidget {
  const OrdersPageWidget({super.key});

  static List<Order> ordersList = [
    Order(
        orderNumber: '21231231231',
        orderCost: 15.5,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.delivered),
    Order(
        orderNumber: '2468236482',
        orderCost: 1500,
        orderDate: '1/04/2022',
        orderQuantity: 20,
        orderStatus: OrderStatus.delivered),
    Order(
        orderNumber: '5498574957',
        orderCost: 30,
        orderDate: '20/03/2020',
        orderQuantity: 2,
        orderStatus: OrderStatus.delivered),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.delivered),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.delivered),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.delivered),
    Order(
        orderNumber: '21231231231',
        orderCost: 15.5,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.processing),
    Order(
        orderNumber: '2468236482',
        orderCost: 1500,
        orderDate: '1/04/2022',
        orderQuantity: 20,
        orderStatus: OrderStatus.processing),
    Order(
        orderNumber: '5498574957',
        orderCost: 30,
        orderDate: '20/03/2020',
        orderQuantity: 2,
        orderStatus: OrderStatus.processing),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.processing),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.processing),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.processing),
    Order(
        orderNumber: '21231231231',
        orderCost: 15.5,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.canceled),
    Order(
        orderNumber: '2468236482',
        orderCost: 1500,
        orderDate: '1/04/2022',
        orderQuantity: 20,
        orderStatus: OrderStatus.canceled),
    Order(
        orderNumber: '5498574957',
        orderCost: 30,
        orderDate: '20/03/2020',
        orderQuantity: 2,
        orderStatus: OrderStatus.canceled),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.canceled),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.canceled),
    Order(
        orderNumber: '21231231231',
        orderCost: 15,
        orderDate: '20/03/2020',
        orderQuantity: 1,
        orderStatus: OrderStatus.canceled),
  ];

  static List<Order> deliveredOrders = ordersList
      .where((element) => element.orderStatus == OrderStatus.delivered)
      .toList();
  static List<Order> processingOrders = ordersList
      .where((element) => element.orderStatus == OrderStatus.processing)
      .toList();
  static List<Order> canceledOrders = ordersList
      .where((element) => element.orderStatus == OrderStatus.canceled)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
            appBar: BaseAppBar(
                title: 'My Orders',
                appBar: AppBar(),
                action: null,
                leading: BaseAppBarLeading.back,
                tabBar: true),
            body: TabBarView(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return _OrderCardWidget(
                        orderItem: deliveredOrders.elementAt(index));
                  },
                  itemCount: deliveredOrders.length,
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return _OrderCardWidget(
                        orderItem: processingOrders.elementAt(index));
                  },
                  itemCount: processingOrders.length,
                ),
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return _OrderCardWidget(
                        orderItem: canceledOrders.elementAt(index));
                  },
                  itemCount: canceledOrders.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderCardWidget extends StatelessWidget {
  const _OrderCardWidget({super.key, required this.orderItem});
  final Order orderItem;

  Color _orderStatusColor() {
    switch (orderItem.orderStatus) {
      case OrderStatus.delivered:
        return const Color(0xFF27AE60);

      case OrderStatus.processing:
        return const Color(0xFF242424);

      case OrderStatus.canceled:
        return const Color(0xFFD90429);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      margin: const EdgeInsets.only(top: 25, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A959E).withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 10, left: 20, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Order No${orderItem.orderNumber}',
                    style: const TextStyle(
                      color: Color(0xFF242424),
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  orderItem.orderDate,
                  style: const TextStyle(
                    color: Color(0xFF808080),
                    fontFamily: 'NunitoSans',
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: Color(0xFFF0F0F0),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Color(0xFF808080),
                        fontFamily: 'NunitoSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        const TextSpan(text: 'Quantity: '),
                        TextSpan(
                          text: '${orderItem.orderQuantity}',
                          style: const TextStyle(
                            color: Color(0xFF303030),
                            fontFamily: 'NunitoSans',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Color(0xFF808080),
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      const TextSpan(text: 'Total Amount: '),
                      TextSpan(
                        text:
                            '\$${orderItem.orderCost * 100 % 100 == 0 ? orderItem.orderCost.toInt() : orderItem.orderCost}',
                        style: const TextStyle(
                          color: Color(0xFF242424),
                          fontFamily: 'NunitoSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    fixedSize: MaterialStateProperty.all(const Size(100, 40)),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF242424)),
                    splashFactory: NoSplash.splashFactory,
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NunitoSans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                orderItem.orderStatus == OrderStatus.processing
                    ? const Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.watch_later_outlined,
                          size: 20,
                          color: Color(0xFF242424),
                        ),
                      )
                    : const Icon(null),
                Text(
                  orderItem.orderStatus.name[0].toUpperCase() +
                      orderItem.orderStatus.name.substring(1),
                  style: TextStyle(
                    color: _orderStatusColor(),
                    fontFamily: 'NunitoSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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

enum OrderStatus { delivered, processing, canceled }

class Order {
  final String orderNumber;
  final String orderDate;
  final int orderQuantity;
  final double orderCost;
  final OrderStatus orderStatus;

  Order(
      {required this.orderNumber,
      required this.orderCost,
      required this.orderDate,
      required this.orderQuantity,
      required this.orderStatus});
}
