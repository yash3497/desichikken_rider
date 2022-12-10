import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/constants.dart';
import '../../widget/custom_appbar.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails(
      {super.key, required this.orderStatus, required this.boxColor});

  final String orderStatus;
  final Color boxColor;

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
                'Order Details',
                style: bodyText20w700(color: black),
              ),
            ),
            SizedBox(
                height: height(context) * 0.82,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemCount: 1,
                    itemBuilder: (ctx, i) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        height: height(context) * 0.41,
                        width: width(context) * 0.95,
                        decoration: shadowDecoration(6, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kinjal Parmar',
                                  style: bodyText14w600(color: black),
                                ),
                                Container(
                                  height: height(context) * 0.035,
                                  width: width(context) * 0.3,
                                  decoration:
                                      myFillBoxDecoration(0, boxColor, 6),
                                  child: Center(
                                    child: Text(
                                      orderStatus,
                                      style: bodyText14w600(color: white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            addVerticalSpace(7),
                            Row(
                              children: [
                                Text(
                                  'Order ID- 998070',
                                  style: bodyText14normal(color: black),
                                ),
                                addHorizontalySpace(5),
                                Container(
                                  height: 15,
                                  width: width(context) * 0.1,
                                  decoration:
                                      myOutlineBoxDecoration(1, primary, 1),
                                  child: Center(
                                    child: Text(
                                      'PAID',
                                      style: bodytext12Bold(color: primary),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Yesterday, 09:00PM',
                                  style: bodytext12Bold(color: black),
                                )
                              ],
                            ),
                            addVerticalSpace(10),
                            Row(
                              children: [
                                Text(
                                  '2 Item(s) Order ',
                                  style: bodyText14w600(
                                      color: black.withOpacity(0.3)),
                                ),
                                Spacer(),
                                Image.asset('assets/images/way.png'),
                                Text(
                                  ' 8.6 KM',
                                  style: bodyText14w600(color: black),
                                ),
                                Spacer(),
                                Text(
                                  'Rs.400',
                                  style: bodyText14w600(color: primary),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              height: height(context) * 0.15,
                              width: width(context) * 0.92,
                              decoration: myOutlineBoxDecoration(
                                  1, black.withOpacity(0.3), 8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.houseboat_outlined,
                                        color: primary,
                                        size: 35,
                                      ),
                                      addHorizontalySpace(8),
                                      Column(
                                        children: [
                                          Text(
                                            'Supermarket',
                                            style:
                                                bodyText16w600(color: primary),
                                          ),
                                          Text(
                                            'Pick up Location',
                                            style: bodyText14normal(
                                                color: black.withOpacity(0.4)),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        '08:00PM',
                                        style: bodyText14w600(color: black),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.home_filled,
                                        color: black,
                                        size: 35,
                                      ),
                                      addHorizontalySpace(8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Sector 14, Karnal Haryana 132001',
                                            style:
                                                bodyText13normal(color: black),
                                          ),
                                          Text(
                                            'Delivery location',
                                            style: bodyText14normal(
                                                color: black.withOpacity(0.4)),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Text(
                                        '08:25PM',
                                        style: bodyText14w600(color: black),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            addVerticalSpace(6),
                            Expanded(
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (context, i) {
                                      return Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: height(context) * 0.06,
                                                width: width(context) * 0.2,
                                                child: Image.asset(
                                                  'assets/images/meat.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              addHorizontalySpace(5),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Polutry Chicken (1)',
                                                    style: bodytext12Bold(
                                                        color: black),
                                                  ),
                                                  addVerticalSpace(5),
                                                  Text(
                                                    '900gms I Net: 450gms',
                                                    style: bodyText11Small(
                                                        color: black
                                                            .withOpacity(0.3)),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          const Divider(
                                            height: 5,
                                            thickness: 1,
                                          )
                                        ],
                                      );
                                    }))
                          ],
                        ),
                      );
                    })),
          ],
        ));
  }
}
