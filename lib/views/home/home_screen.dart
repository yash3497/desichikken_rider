import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/views/home/rejected_screen.dart';
import 'package:amaze_rider/views/home/search_screen.dart';
import 'package:amaze_rider/views/home/view_new_orderdetails.dart';
import 'package:amaze_rider/widget/my_drawer.dart';
import 'package:amaze_rider/widget/offline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../humburger_menus_screens/wallets_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final List todaysDashboard = [
    {'img': 'assets/images/home2.png', 'status': 'Deliveries', 'total': '42'},
    {
      'img': 'assets/images/home1.png',
      'status': 'Today’s Earning',
      'total': 'Rs.1,000'
    },
    {'img': 'assets/images/home3.png', 'status': 'Rejected', 'total': '3'},
  ];

  bool isChange = false;
  bool isToggle = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      key: _globalKey,
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: white,
        actions: [
          Container(
            width: width(context) * 0.23,
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => SearchScreen()));
              },
              child: Icon(
                Icons.search,
                color: primary,
                size: 30,
              ),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.only(right: 8.0),
          //   child: CircleAvatar(
          //     radius: 18,
          //     backgroundImage: AssetImage('assets/images/profile.png'),
          //   ),
          // ),
        ],
        leading: IconButton(
            onPressed: () {
              _globalKey.currentState!.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: black,
            )),
        title: Padding(
          padding: EdgeInsets.only(right: width(context) * 0.35),
          child: FlutterSwitch(
            padding: 1,
            width: 70,
            height: 25,
            toggleSize: 26,
            activeText: 'Online',
            inactiveText: 'Offline',
            valueFontSize: 10,
            activeToggleColor: Colors.white,
            inactiveToggleColor: Colors.white,
            activeTextFontWeight: FontWeight.w700,
            inactiveTextFontWeight: FontWeight.w700,
            showOnOff: true,
            activeColor: Colors.green,
            activeTextColor: Colors.white,
            inactiveTextColor: Colors.white,
            inactiveColor: Colors.red,
            onToggle: (val) {
              setState(() {
                isToggle = val;
                authProvider.createUserProfile({"isOnline": val});
              });
            },
            value: isToggle,
          ),
        ),
      ),
      body: isToggle
          ? Column(children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today’s dashboard',
                      style: bodyText20w700(color: black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletScreen()));
                      },
                      child: Container(
                        height: height(context) * 0.05,
                        width: width(context) * 0.4,
                        decoration: shadowDecoration(30, 3),
                        child: Row(
                          children: [
                            Image.asset('assets/images/home1.png'),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Balance: ',
                                  style: bodyText14normal(
                                      color: black.withOpacity(0.5))),
                              TextSpan(
                                  text: 'Rs.5,000',
                                  style: bodyText14w600(color: black))
                            ]))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              addVerticalSpace(10),
              SizedBox(
                  height: height(context) * 0.17,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: todaysDashboard.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              WalletScreen()));
                                }
                                if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RejectedDeliveryScreen()));
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.all(
                                  10,
                                ),
                                height: height(context) * 0.13,
                                width: width(context) * 0.27,
                                decoration: shadowDecoration(10, 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(todaysDashboard[index]['img']),
                                    Text(
                                      todaysDashboard[index]['status'],
                                      style: bodyText13normal(color: black),
                                    ),
                                    Text(
                                      todaysDashboard[index]['total'],
                                      style: bodyText14w600(color: black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      })),
              addVerticalSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChange = false;
                      });
                    },
                    child: Container(
                      height: height(context) * 0.05,
                      width: width(context) * 0.4,
                      decoration: !isChange
                          ? BoxDecoration(
                              gradient: redGradient(),
                              borderRadius: BorderRadius.circular(30))
                          : myFillBoxDecoration(0, Colors.grey.shade200, 30),
                      child: Center(
                        child: Text(
                          'New orders(2)',
                          style: bodyText13normal(
                              color: !isChange ? white : black),
                        ),
                      ),
                    ),
                  ),
                  addHorizontalySpace(8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isChange = true;
                      });
                    },
                    child: Container(
                      height: height(context) * 0.05,
                      width: width(context) * 0.4,
                      decoration: isChange
                          ? BoxDecoration(
                              gradient: redGradient(),
                              borderRadius: BorderRadius.circular(30))
                          : myFillBoxDecoration(0, Colors.grey.shade200, 30),
                      child: Center(
                        child: Text(
                          'Delivered',
                          style:
                              bodyText13normal(color: isChange ? white : black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              addVerticalSpace(20),
              !isChange ? NewOrderListWidget() : DeliveredOrdersWidget()
            ])
          : OfflineScreen(),
    );
  }
}

class DeliveredOrdersWidget extends StatelessWidget {
  const DeliveredOrdersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: 5,
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
                          '25 min',
                          style: bodyText14w600(color: black),
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
                        Text(
                          'Rs.126',
                          style: bodyText14w600(color: black),
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
                      decoration:
                          myOutlineBoxDecoration(1, black.withOpacity(0.3), 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    style: bodyText16w600(color: primary),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sector 14, Karnal Haryana 132001',
                                    style: bodyText13normal(color: black),
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
                            }))
                  ],
                ),
              );
            }));
  }
}

class NewOrderListWidget extends StatelessWidget {
  const NewOrderListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, i) {
              return Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                height: height(context) * 0.35,
                width: width(context) * 0.95,
                decoration: shadowDecoration(6, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => NewOrderDetails()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'ID: 35473473737783',
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
                                '5 min ago',
                                style: bodyText14w600(color: black),
                              )
                            ],
                          ),
                          addVerticalSpace(10),
                          Row(
                            children: [
                              Text(
                                '2 Items',
                                style: bodyText14w600(color: black),
                              ),
                              Spacer(),
                              Image.asset('assets/images/way.png'),
                              Text(
                                '8.6 KM',
                                style: bodyText14w600(color: black),
                              ),
                              Spacer(),
                              Text(
                                'Rs.126',
                                style: bodyText14w600(color: black),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                          ),
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
                                    style: bodyText16w600(color: primary),
                                  ),
                                  Text(
                                    'Pick up Location',
                                    style: bodyText14normal(
                                        color: black.withOpacity(0.4)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(left: width(context) * 0.05),
                            height: height(context) * 0.07,
                            width: 1,
                            color: black,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sector 14, Karnal Haryana 132001',
                                    style: bodyText14w600(color: black),
                                  ),
                                  Text(
                                    'Delivery location',
                                    style: bodyText14normal(
                                        color: black.withOpacity(0.4)),
                                  ),
                                ],
                              )
                            ],
                          ),
                          addVerticalSpace(height(context) * 0.04),
                        ],
                      ),
                    ),
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
              );
            }));
  }
}
