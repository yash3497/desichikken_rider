import 'package:amaze_rider/views/home/map_screen.dart';
import 'package:amaze_rider/views/humburger_menus_screens/contact_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/constants.dart';
import '../../widget/custom_appbar.dart';

class NewOrderDetails extends StatelessWidget {
  const NewOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Order Details',
                style: bodyText20w700(color: black),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: height(context) * 0.6,
              width: width(context) * 0.95,
              decoration: shadowDecoration(6, 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kinjal Parmar',
                    style: bodyText14w600(color: black),
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
                        decoration: myOutlineBoxDecoration(1, primary, 1),
                        child: Center(
                          child: Text(
                            'PAID',
                            style: bodytext12Bold(color: primary),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        '25 min ago',
                        style: bodytext12Bold(color: black),
                      )
                    ],
                  ),
                  addVerticalSpace(10),
                  Row(
                    children: [
                      Text(
                        '2 Item(s) Order ',
                        style: bodyText14w600(color: black.withOpacity(0.3)),
                      ),
                      Spacer(),
                      Image.asset('assets/images/way.png'),
                      Text(
                        ' 8.6 KM',
                        style: bodyText14w600(color: black),
                      ),
                      Spacer(),
                      Container(
                        height: height(context) * 0.03,
                        width: width(context) * 0.2,
                        decoration: myFillBoxDecoration(0, primary, 6),
                        child: Center(
                          child: Text(
                            'Rs.400',
                            style: bodyText14w600(color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    height: height(context) * 0.12,
                    width: width(context) * 0.92,
                    decoration:
                        myOutlineBoxDecoration(1, black.withOpacity(0.3), 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup Address',
                          style: bodytext12Bold(color: black),
                        ),
                        Text(
                          'Super Market',
                          style: bodyText11Small(color: black),
                        ),
                        addVerticalSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapScreen()));
                              },
                              child: Container(
                                height: 38,
                                width: width(context) * 0.4,
                                decoration: myOutlineBoxDecoration(
                                    1, black.withOpacity(0.2), 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: primary,
                                    ),
                                    Text(
                                      'View on map',
                                      style: bodyText14w600(
                                          color: black.withOpacity(0.3)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContactUsScreen()));
                              },
                              child: Container(
                                height: 38,
                                width: width(context) * 0.4,
                                decoration: myOutlineBoxDecoration(
                                    1, black.withOpacity(0.2), 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: primary,
                                    ),
                                    Text(
                                      'Call Supermarket',
                                      style: bodyText14w600(
                                          color: black.withOpacity(0.3)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(10),
                  Container(
                    padding: EdgeInsets.all(6),
                    height: height(context) * 0.12,
                    width: width(context) * 0.92,
                    decoration:
                        myOutlineBoxDecoration(1, black.withOpacity(0.3), 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery address',
                          style: bodytext12Bold(color: black),
                        ),
                        Text(
                          'S-123, Sector 14, Karnal',
                          style: bodyText11Small(color: black),
                        ),
                        addVerticalSpace(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapScreen()));
                              },
                              child: Container(
                                height: 38,
                                width: width(context) * 0.4,
                                decoration: myOutlineBoxDecoration(
                                    1, black.withOpacity(0.2), 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: primary,
                                    ),
                                    Text(
                                      'View on map',
                                      style: bodyText14w600(
                                          color: black.withOpacity(0.3)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContactUsScreen()));
                              },
                              child: Container(
                                height: 38,
                                width: width(context) * 0.4,
                                decoration: myOutlineBoxDecoration(
                                    1, black.withOpacity(0.2), 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: primary,
                                    ),
                                    Text(
                                      'Call Supermarket',
                                      style: bodyText14w600(
                                          color: black.withOpacity(0.3)),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  addVerticalSpace(10),
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
                                          style: bodytext12Bold(color: black),
                                        ),
                                        addVerticalSpace(5),
                                        Text(
                                          '900gms I Net: 450gms',
                                          style: bodyText11Small(
                                              color: black.withOpacity(0.3)),
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
                          })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: height(context) * 0.05,
                        width: width(context) * 0.3,
                        decoration: myOutlineBoxDecoration(1, primary, 6),
                        child: Center(
                          child: Text(
                            'Reject',
                            style: bodyText14w600(color: primary),
                          ),
                        ),
                      ),
                      Container(
                        height: height(context) * 0.05,
                        width: width(context) * 0.53,
                        decoration: myFillBoxDecoration(
                            0, Color.fromRGBO(47, 168, 78, 1), 6),
                        child: Center(
                          child: Text(
                            'Pick Order',
                            style: bodyText14w600(color: white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
