import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/views/home/orders_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Orders").where('deliveryPerson', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context,AsyncSnapshot snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (ctx, i) {
                        var o = snapshot.data.docs[i];
                        return InkWell(
                          onTap: () {
                            if (snapshot.data.docs[i]['status'] == 'cancelled') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>  OrdersDetails(
                                            boxColor: Colors.red,
                                            orderStatus: 'Cancelled',
                                        docId: o.id,
                                          )));
                            } else if (snapshot.data.docs[i]['status'] == 'completed') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) =>  OrdersDetails(
                                            boxColor: Colors.green,
                                            orderStatus: 'Delivered',
                                        docId: o.id,
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
                                      o['customerName'],
                                      style: bodyText14w600(color: black),
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: height(context) * 0.04,
                                      width: width(context) * 0.3,
                                      decoration: myFillBoxDecoration(
                                          0, o['status'] == 'completed'?Colors.green:Colors.red, 6),
                                      child: Center(
                                        child: Text(
                                          snapshot.data.docs[i]['status'],
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
                                      o['orderId'],
                                      style: bodyText13normal(color: black),
                                    ),
                                    Text(
                                      (o['createdAt'].toDate()).toString().split(" ").first,
                                      style: bodytext12Bold(color: black),
                                    )
                                  ],
                                ),
                                addVerticalSpace(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height:20,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: o['items'].length,
                                          itemBuilder: (context, cnt) {
                                            return Text(
                                              '${o['items'][cnt]['name']} (${o['items'][cnt]['productQty']}),',
                                              style: bodytext12Bold(
                                                  color: black.withOpacity(0.3)),
                                            );
                                          }
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Rs. ${o['totalAmount']}',
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
                                      o['deliveryAddress'],
                                      style: bodyText14w600(color: black),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              ))
        ],
      ),
    );
  }
}
