import 'package:amaze_rider/views/humburger_menus_screens/withdraw_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/constants.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

enum orderFilter {
  all,
  today,
  last15days,
  last1month,
}

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  List orderStatus = [
    {'status': 'Processing', 'color': Colors.orange},
    {'status': 'Recieved', 'color': Colors.green},
    {'status': 'Recieved', 'color': Colors.green},
    {'status': 'Recieved', 'color': Colors.green},
    {'status': 'Recieved', 'color': Colors.green},
    {'status': 'Recieved', 'color': Colors.green}
  ];
  orderFilter _value = orderFilter.today;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppbar(
            title: '',
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              height: height(context) * 0.12,
              width: width(context) * 0.95,
              decoration: BoxDecoration(
                  gradient: redGradient(),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2,
                        offset: Offset(1, 5)),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Riders").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
                      builder: (context,AsyncSnapshot snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text('Rs.${snapshot.data.data()['wallet']??0}',
                              style:const TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700)),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WithdrawalScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 15.0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.wallet,
                                  color: black,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('Withdraw',
                                    style: bodytext12Bold(color: black)),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showFiltersOrders(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Filter',
                          style: bodyText14w600(color: black),
                        ),
                        const Icon(
                          Icons.filter_alt_outlined,
                          size: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("riderPayments").where("riderId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (context,AsyncSnapshot snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (ctx, i) {
                        var a = snapshot.data.docs[i];
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          height: height(context) * 0.21,
                          width: width(context) * 0.93,
                          padding: EdgeInsets.all(10),
                          decoration: shadowDecoration(10, 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    a['name'],
                                    style: bodyText14w600(color: black),
                                  ),
                                  Container(
                                    height: 30,
                                    width: width(context) * 0.28,
                                    decoration: myFillBoxDecoration(
                                        0,a['status'] == 'pending' ?Colors.orange:Colors.green, 7),
                                    child: Center(
                                      child: Text(
                                        a['status'],
                                        style: bodytext12Bold(color: white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              addVerticalSpace(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order ID- ${a['orderId']}',
                                    style: bodyText14normal(color: black),
                                  ),
                                  Text(
                                    a['updated'].toDate().toString().split(" ").first,
                                    style: bodytext12Bold(color: black),
                                  )
                                ],
                              ),
                              addVerticalSpace(8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width:100,
                                      height: 30,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: a['items'].length,
                                        itemBuilder: (context, indi) {
                                          return Text(
                                            '${a['items'][indi]['name']} (${a['items'][indi]['productQty']}), Frozen chicken(1)',
                                            style: bodyText14w600(
                                                color: black.withOpacity(0.4)),
                                          );
                                        }
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Rs. ${a['total']}',
                                    style: bodyText14w600(color: primary),
                                  )
                                ],
                              ),
                              addVerticalSpace(8),
                              const Divider(
                                thickness: 1,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.home_filled,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5.0, left: 6),
                                    child: Text(
                                      a['address'],
                                      style: bodyText14normal(color: black),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showFiltersOrders(BuildContext context) {
    return showModalBottomSheet(
      context: context,

      backgroundColor: Colors.white,
      //elevates modal bottom screen
      elevation: 10,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
              padding: EdgeInsets.all(12),
              height: height(context) * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters Income',
                        style: bodyText16w600(color: black),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                  RadioListTile(
                      value: orderFilter.all,
                      activeColor: primary,
                      title: Text('Total earning'),
                      groupValue: _value,
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue as orderFilter;
                        });
                      }),
                  RadioListTile(
                      value: orderFilter.today,
                      activeColor: primary,
                      title: Text('Today earning'),
                      groupValue: _value,
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue as orderFilter;
                        });
                      }),
                  RadioListTile(
                      value: orderFilter.last15days,
                      activeColor: primary,
                      title: Text('Last 15 days earning'),
                      groupValue: _value,
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue as orderFilter;
                        });
                      }),
                  RadioListTile(
                      value: orderFilter.last1month,
                      activeColor: primary,
                      title: Text('Last 1 month earning'),
                      groupValue: _value,
                      onChanged: (newValue) {
                        setState(() {
                          _value = newValue as orderFilter;
                        });
                      }),
                  addVerticalSpace(20),
                  CustomButton(buttonName: 'Apply', onClick: () {})
                ],
              ));
        });
      },
    );
  }
}
