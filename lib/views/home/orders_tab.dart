import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/views/home/orders_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/custom_appbar.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List ordersList = [
    {'status': 'Delivered', 'color': Colors.green},
    {'status': 'Cancelled', 'color': Colors.red},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Your Orders',
              style: bodyText20w700(color: black),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: ordersList.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {
                        if (ordersList[i]['status'] == 'Cancelled') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const OrdersDetails(
                                        boxColor: Colors.red,
                                        orderStatus: 'Cancelled',
                                      )));
                        } else if (ordersList[i]['status'] == 'Delivered') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => const OrdersDetails(
                                        boxColor: Colors.green,
                                        orderStatus: 'Delivered',
                                      )));
                        }
                      },
                      child: Container(
                        height: height(context) * 0.18,
                        width: width(context) * 0.95,
                        decoration: shadowDecoration(7, 6),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Kinjal Parmar',
                                  style: bodyText14w600(color: black),
                                ),
                                const Spacer(),
                                Container(
                                  height: height(context) * 0.04,
                                  width: width(context) * 0.3,
                                  decoration: myFillBoxDecoration(
                                      0, ordersList[i]['color'], 6),
                                  child: Center(
                                    child: Text(
                                      ordersList[i]['status'],
                                      style: bodyText14w600(color: white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order ID- 998070',
                                  style: bodyText13normal(color: black),
                                ),
                                Text(
                                  'Yesterday, 09:00PM',
                                  style: bodytext12Bold(color: black),
                                )
                              ],
                            ),
                            addVerticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Poultry chicken (1), Frozen chicken(1)',
                                  style: bodytext12Bold(
                                      color: black.withOpacity(0.3)),
                                ),
                                Text(
                                  'Rs. 400',
                                  style: bodytext12Bold(color: primary),
                                )
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.home_filled),
                                addVerticalSpace(5),
                                Text(
                                  'Sector 16, Old city 500088',
                                  style: bodyText14w600(color: black),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
