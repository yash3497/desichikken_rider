import 'package:amaze_rider/providers/service_procider.dart';
import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/views/home/rejected_screen.dart';
import 'package:amaze_rider/views/home/search_screen.dart';
import 'package:amaze_rider/views/home/view_new_orderdetails.dart';
import 'package:amaze_rider/widget/my_drawer.dart';
import 'package:amaze_rider/widget/offline_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geolocator/geolocator.dart';
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

  late ServiceProvider _serviceProvider;

  @override
  void initState() {
    fetch();
    // _serviceProvider.fetchNewOrder();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _serviceProvider = Provider.of(context, listen: false);
      // Provider.of<ServiceProvider>(context, listen: false)
      //     .runFetchOrderEveryTime();
      Provider.of<ServiceProvider>(context, listen: false).checkStatus();
      Provider.of<AuthProvider>(context, listen: false).getMsgToken();
    });
    super.initState();
  }

  fetch() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // return Future.error('Location services are disabled.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    _serviceProvider = Provider.of(context);
    ServiceProvider sp = Provider.of(context, listen: true);

    return Scaffold(
      key: _globalKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: white,
        actions: [
          // Container(
          //   width: width(context) * 0.23,
          //   padding: const EdgeInsets.only(right: 8.0),
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (ctx) => SearchScreen()));
          //     },
          //     child: Icon(
          //       Icons.search,
          //       color: primary,
          //       size: 30,
          //     ),
          //   ),
          // ),
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
              // setState(() {
              //   isToggle = val;
              //   authProvider.createUserProfile({"isOnline": val});
              // });

              sp.riderStatusUpdate();
            },
            value: sp.status,
          ),
        ),
      ),
      body: sp.status
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
                            StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("Riders").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                              builder: (context,AsyncSnapshot snapshot) {
                                return RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Balance: ',
                                      style: bodyText14normal(
                                          color: black.withOpacity(0.5))),
                                  TextSpan(
                                      text: 'Rs.${snapshot.data.data()['wallet']??0}',
                                      style: bodyText14w600(color: black))
                                ]));
                              }
                            )
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
                                    index == 2
                                        ? StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("Riders")
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              return Text(
                                                snapshot.data['rejectedOrder']
                                                    .length
                                                    .toString(),
                                                style: bodyText14w600(
                                                    color: black),
                                              );
                                            })
                                        : index == 0
                                            ? StreamBuilder(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection("Riders")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  return Text(
                                                    snapshot
                                                        .data['completedOrder']
                                                        .length
                                                        .toString(),
                                                    style: bodyText14w600(
                                                        color: black),
                                                  );
                                                })
                                            : FutureBuilder(
                                              future: sp.calculateTodayEarning(),
                                              builder: (context, snapshot) {
                                                if(!snapshot.hasData){
                                                  return Text(
                                                    '0',
                                                    style: bodyText14w600(
                                                        color: black),
                                                  );
                                                }else {
                                                  return Text(
                                                    snapshot.data!.toStringAsFixed(2),
                                                    style: bodyText14w600(
                                                        color: black),
                                                  );
                                                }
                                              }
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
                          'New orders (${_serviceProvider.newOrderList.length})',
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
                          'Delivered (${sp.deliveredOrderList.length})',
                          style:
                              bodyText13normal(color: isChange ? white : black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              addVerticalSpace(20),
              !isChange
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: sp.newOrderList.length,
                          itemBuilder: (context, i) {
                            var o = sp.newOrderList[i];
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
                                              builder: (ctx) => NewOrderDetails(
                                                    docId: o.id,
                                                  )));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              o['orderId'],
                                              style: bodyText14normal(
                                                  color: black),
                                            ),
                                            addHorizontalySpace(5),
                                            Container(
                                              height: 15,
                                              width: width(context) * 0.1,
                                              decoration:
                                                  myOutlineBoxDecoration(
                                                      1, primary, 1),
                                              child: Center(
                                                child: Text(
                                                  o['isPaid']
                                                      ? 'PAID'
                                                      : 'UNPAID',
                                                  style: bodytext12Bold(
                                                      color: primary),
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              sp.findTime(o['createdAt']),
                                              style:
                                                  bodyText14w600(color: black),
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(10),
                                        Row(
                                          children: [
                                            Text(
                                              o['items'].length.toString(),
                                              style:
                                                  bodyText14w600(color: black),
                                            ),
                                            Spacer(),
                                            Image.asset(
                                                'assets/images/way.png'),
                                            Text(
                                              '${sp.calculateDistanceKM(o['customerLatlong']['lat'], o['customerLatlong']['long'], sp.riderLatitude, sp.riderLongitude).toStringAsFixed(2)} KM',
                                              style:
                                                  bodyText14w600(color: black),
                                            ),
                                            Spacer(),
                                            Text(
                                              'Rs.${o['totalAmount']}',
                                              style:
                                                  bodyText14w600(color: black),
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
                                                  style: bodyText16w600(
                                                      color: primary),
                                                ),
                                                Text(
                                                  o['vendorLocation'],
                                                  style: bodyText14normal(
                                                      color: black
                                                          .withOpacity(0.4)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: width(context) * 0.05),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  o['deliveryAddress'],
                                                  style: bodyText14w600(
                                                          color: black)
                                                      .copyWith(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          overflow: TextOverflow
                                                              .clip),
                                                ),
                                                Text(
                                                  'Delivery location',
                                                  style: bodyText14normal(
                                                      color: black
                                                          .withOpacity(0.4)),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        addVerticalSpace(
                                            height(context) * 0.04),
                                      ],
                                    ),
                                  ),
                                  (o['deliveryPerson'] ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: height(context) * 0.05,
                                              width: width(context) * 0.53,
                                              decoration: myFillBoxDecoration(
                                                  0,
                                                  Color.fromRGBO(
                                                      47, 168, 78, 1),
                                                  6),
                                              child: Center(
                                                child: Text(
                                                  'Already Picked',
                                                  style: bodyText14w600(
                                                      color: white),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                sp.rejectOrder(o.id);
                                              },
                                              child: Container(
                                                height: height(context) * 0.05,
                                                width: width(context) * 0.3,
                                                decoration:
                                                    myOutlineBoxDecoration(
                                                        1, primary, 6),
                                                child: Center(
                                                  child: Text(
                                                    'Reject',
                                                    style: bodyText14w600(
                                                        color: primary),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                sp.acceptOrder(o.id);
                                              },
                                              child: Container(
                                                height: height(context) * 0.05,
                                                width: width(context) * 0.53,
                                                decoration: myFillBoxDecoration(
                                                    0,
                                                    Color.fromRGBO(
                                                        47, 168, 78, 1),
                                                    6),
                                                child: Center(
                                                  child: Text(
                                                    'Pick Order',
                                                    style: bodyText14w600(
                                                        color: white),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            );
                          }))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: sp.deliveredOrderList.length,
                          itemBuilder: (ctx, i) {
                            var o = sp.deliveredOrderList[i];
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
                                    o['customerName'],
                                    style: bodyText14w600(color: black),
                                  ),
                                  addVerticalSpace(7),
                                  Row(
                                    children: [
                                      Text(
                                        o['orderId'],
                                        style: bodyText14normal(color: black),
                                      ),
                                      addHorizontalySpace(5),
                                      Container(
                                        height: 15,
                                        width: width(context) * 0.1,
                                        decoration: myOutlineBoxDecoration(
                                            1, primary, 1),
                                        child: Center(
                                          child: Text(
                                            o['isPaid'] ? 'PAID' : 'UNPAID',
                                            style:
                                                bodytext12Bold(color: primary),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        sp.findTime(o['createdAt']),
                                        style: bodyText14w600(color: black),
                                      )
                                    ],
                                  ),
                                  addVerticalSpace(10),
                                  Row(
                                    children: [
                                      Text(
                                        '${o['items'].length} Item(s) Order ',
                                        style: bodyText14w600(
                                            color: black.withOpacity(0.3)),
                                      ),
                                      Spacer(),
                                      Image.asset('assets/images/way.png'),
                                      Text(
                                        '${sp.calculateDistanceKM(o['customerLatlong']['lat'], o['customerLatlong']['long'], sp.riderLatitude, sp.riderLongitude).toStringAsFixed(2)} KM',
                                        style: bodyText14w600(color: black),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Rs.${o['totalAmount']}',
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
                                                  o['vendorLocation'],
                                                  style: bodyText16w600(
                                                          color: primary)
                                                      .copyWith(fontSize: 10),
                                                ),
                                                Text(
                                                  'Pick up Location',
                                                  style: bodyText14normal(
                                                      color: black
                                                          .withOpacity(0.4)),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            // Text(
                                            //   '08:00PM',
                                            //   style: bodyText14w600(color: black),
                                            // )
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
                                                  o['deliveryAddress'],
                                                  style: bodyText13normal(
                                                          color: black)
                                                      .copyWith(fontSize: 10),
                                                ),
                                                Text(
                                                  'Delivery location',
                                                  style: bodyText14normal(
                                                      color: black
                                                          .withOpacity(0.4)),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            // Text(
                                            //   '08:25PM',
                                            //   style: bodyText14w600(color: black),
                                            // )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  addVerticalSpace(6),
                                  Expanded(
                                      child: ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: o['items'].length,
                                          itemBuilder: (context, i) {
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: height(context) *
                                                          0.06,
                                                      width:
                                                          width(context) * 0.2,
                                                      child: Image.network(
                                                        o['items'][i]['image'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    addHorizontalySpace(5),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${o['items'][i]['name']} (${o['items'][i]['productQty']})',
                                                          style: bodytext12Bold(
                                                              color: black),
                                                        ),
                                                        addVerticalSpace(5),
                                                        Text(
                                                          '${o['items'][i]['weight']}gms I Net: ${o['items'][i]['netWeight']}gms',
                                                          style: bodyText11Small(
                                                              color: black
                                                                  .withOpacity(
                                                                      0.3)),
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
                          }))
            ])
          : OfflineScreen(),
    );
  }
}
