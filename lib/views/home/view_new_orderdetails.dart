import 'package:amaze_rider/providers/service_procider.dart';
import 'package:amaze_rider/views/home/map_screen.dart';
import 'package:amaze_rider/views/humburger_menus_screens/contact_us_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../widget/custom_appbar.dart';

class NewOrderDetails extends StatelessWidget {
  final String docId;
  const NewOrderDetails({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Orders")
                .doc(docId)
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var o = snapshot.data;
              ServiceProvider sp = Provider.of(context, listen: true);
              return Column(
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
                          o['customerName'],
                          style: bodyText14w600(color: black),
                        ),
                        addVerticalSpace(7),
                        Row(
                          children: [
                            Text(
                              'Order ID- ${o['orderId']}',
                              style: bodyText14normal(color: black),
                            ),
                            addHorizontalySpace(5),
                            Container(
                              height: 15,
                              width: width(context) * 0.1,
                              decoration: myOutlineBoxDecoration(1, primary, 1),
                              child: Center(
                                child: Text(
                                  o['isPaid'] ? 'PAID' : 'UNPAID',
                                  style: bodytext12Bold(color: primary),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              sp.findTime(o['createdAt']),
                              style: bodytext12Bold(color: black),
                            )
                          ],
                        ),
                        addVerticalSpace(10),
                        Row(
                          children: [
                            Text(
                              '${o['items'].length} Item(s) Order ',
                              style:
                                  bodyText14w600(color: black.withOpacity(0.3)),
                            ),
                            Spacer(),
                            Image.asset('assets/images/way.png'),
                            Text(
                              '${sp.calculateDistanceKM(o['customerLatlong']['lat'], o['customerLatlong']['long'], sp.riderLatitude, sp.riderLongitude).toStringAsFixed(2)} KM',
                              style: bodyText14w600(color: black),
                            ),
                            Spacer(),
                            Container(
                              height: height(context) * 0.03,
                              width: width(context) * 0.2,
                              decoration: myFillBoxDecoration(0, primary, 6),
                              child: Center(
                                child: Text(
                                  'Rs.${o['totalAmount']}',
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
                          decoration: myOutlineBoxDecoration(
                              1, black.withOpacity(0.3), 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup Address',
                                style: bodytext12Bold(color: black),
                              ),
                              Text(
                                o['vendorLocation'],
                                style: bodyText11Small(color: black),
                              ),
                              addVerticalSpace(15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      sp.openMap(o['vendorLatitude'],
                                          o['vendorLongitude']);
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
                                      sp.makePhoneCall(o['vendorNumber']);
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
                          decoration: myOutlineBoxDecoration(
                              1, black.withOpacity(0.3), 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery address',
                                style: bodytext12Bold(color: black),
                              ),
                              Text(
                                o['deliveryAddress'],
                                style: bodyText14w600(color: black).copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    overflow: TextOverflow.clip),
                              ),
                              addVerticalSpace(5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      sp.openMap(o['customerLatlong']['lat'],
                                          o['customerLatlong']['long']);
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
                                      sp.makePhoneCall(o['customerPhone']);
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
                                            'Call Customer',
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
                                itemCount: o['items'].length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: height(context) * 0.06,
                                            width: width(context) * 0.2,
                                            child: Image.network(
                                              o['items'][i]['image'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          addHorizontalySpace(5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                    color:
                                                        black.withOpacity(0.3)),
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
                        (o['deliveryPerson'] ==
                                    FirebaseAuth.instance.currentUser!.uid &&
                                o['status'] == "accepted")
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      sp.collectOrder(docId);
                                    },
                                    child: Container(
                                      height: height(context) * 0.05,
                                      width: width(context) * 0.53,
                                      decoration: myFillBoxDecoration(
                                          0, Color.fromRGBO(47, 168, 78, 1), 6),
                                      child: Center(
                                        child: Text(
                                          'Collect Order',
                                          style: bodyText14w600(color: white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : (o['deliveryPerson'] ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid &&
                                    o['status'] == "picked")
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          sp.completeOrder(docId);
                                        },
                                        child: Container(
                                          height: height(context) * 0.05,
                                          width: width(context) * 0.53,
                                          decoration: myFillBoxDecoration(
                                              0,
                                              Color.fromRGBO(47, 168, 78, 1),
                                              6),
                                          child: Center(
                                            child: Text(
                                              'Complete Order',
                                              style:
                                                  bodyText14w600(color: white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : (o['deliveryPerson'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid &&
                                        o['status'] == "completed")
                                    ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: height(context) * 0.05,
                                              width: width(context) * 0.53,
                                              decoration: myFillBoxDecoration(
                                                  0,
                                                  Color.fromRGBO(47, 168, 78, 1),
                                                  6),
                                              child: Center(
                                                child: Text(
                                                  'Completed',
                                                  style:
                                                      bodyText14w600(color: white),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              sp.rejectOrder(docId);
                                              Navigator.pop(context);
                                              sp.fetchNewOrder();
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
                                              sp.acceptOrder(docId);
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
                  ),
                ],
              );
            }));
  }
}
