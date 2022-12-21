import 'package:amaze_rider/providers/service_procider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../widget/custom_appbar.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails(
      {super.key, required this.orderStatus, required this.boxColor,required this.docId});

  final String orderStatus;
  final Color boxColor;
  final String docId;

  @override
  Widget build(BuildContext context) {
    ServiceProvider sp = Provider.of(context,listen: false);
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Orders").doc(docId).snapshots(),
          builder: (context,AsyncSnapshot snapshot) {
            return Column(
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
                          var o = snapshot.data;
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
                                      o['customerName'],
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
                                      o['orderId'],
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
                                         o['isPaid']? 'PAID':'UNPAID',
                                          style: bodytext12Bold(color: primary),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      DateTime.fromMillisecondsSinceEpoch(o['createdAt']).toString().split(" ").first,
                                      style: bodytext12Bold(color: black),
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
                                                o['vendorLocation'],
                                                style:
                                                    bodyText16w600(color: primary).copyWith(fontSize: 10),
                                              ),
                                              Text(
                                                'Pick up Location',
                                                style: bodyText14normal(
                                                    color: black.withOpacity(0.4)),
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
                                                style:
                                                    bodyText13normal(color: black).copyWith(fontSize: 10),
                                              ),
                                              Text(
                                                'Delivery location',
                                                style: bodyText14normal(
                                                    color: black.withOpacity(0.4)),
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
                                                      Text(  '${o['items'][i]['weight']}gms I Net: ${o['items'][i]['netWeight']}gms',

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
            );
          }
        ));
  }
}
