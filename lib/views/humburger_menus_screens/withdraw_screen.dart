import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/constants.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  List lookingForList = [
    '50',
    '100',
    '300',
    '500',
    '750',
    '1000',
  ];

  List<bool> listBool = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  String amount = '0';

  int select = 0;

  bool isTrue = false;
  TextEditingController a = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppbar(
          title: '',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 21, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Center(
                          child: Text("Enter the amount you like to withdraw",
                              style: bodyText14w600(color: black))),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        height: height(context) * 0.1,
                        width: width(context),
                        decoration: myOutlineBoxDecoration(2, primary, 10),
                        child: Center(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (v){
                              amount = v;
                              setState(() {

                              });
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Rs $amount",
                                hintStyle: bodyText20w700(color: black)),
                          ),
                        ),
                      ),
                      Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children:
                              List.generate(lookingForList.length, (index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    a.clear();
                                    listBool[index] = !listBool[select];
                                    isTrue = !isTrue;
                                    select = index;
                                    amount = lookingForList[index];
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.all(5),
                                  width: width(context) * 0.28,
                                  decoration: select == index
                                      ? myFillBoxDecoration(0, primary, 20)
                                      : BoxDecoration(
                                          border: Border.all(
                                              color: primary, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                  child: SizedBox(
                                    height: height(context) * 0.03,
                                    width: width(context) * 0.19,
                                    child: Center(
                                      child: Text(
                                       "Rs "+ lookingForList[index],
                                        textAlign: TextAlign.center,
                                        style: bodyText14w600(
                                            color: select == index
                                                ? white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ));
                          })),
                      SizedBox(
                        height: height(context) * 0.1,
                      ),
                      CustomButton(
                          buttonName: 'Continue',
                          onClick: () async{
                            print(amount);
                            var riderD = await FirebaseFirestore.instance.collection("Riders").doc(FirebaseAuth.instance.currentUser!.uid).get();
                            double wall = riderD.data()!['wallet'] ?? 0.0;
                            if(double.parse(amount)<= wall) {
                              showDialog(context: context, builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      "Are you sure want to withdraw $amount ?"),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(_);
                                    }, child: const Text("cancel")),
                                    TextButton(onPressed: () {
                                      var a = FirebaseFirestore.instance
                                          .collection("WithdrawRequest").doc();
                                      a.set({
                                        "date": DateTime.now(),
                                        "riderId": FirebaseAuth.instance
                                            .currentUser!.uid,
                                        "amount": double.parse(amount),
                                        "paymentId": a.id,
                                        "paid": false,
                                      });
                                      FirebaseFirestore.instance.collection(
                                          "Riders").doc(
                                          FirebaseAuth.instance.currentUser!
                                              .uid).update({
                                        "wallet": FieldValue.increment(
                                            -(double.parse(amount)))
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Withdraw requested Successfully");
                                      Navigator.pop(_);
                                      Navigator.pop(context);
                                    }, child: const Text("yes"))
                                  ],
                                );
                              });
                            }else{
                              Fluttertoast.showToast(msg: "Not enough balance");
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SelectBankAccount()));
                          })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectBankAccount extends StatelessWidget {
  SelectBankAccount({super.key});

  final List bankAcList = [
    {
      'img': 'assets/images/sbi.png',
      'title': 'Sumit Patil',
      'subTitle': 'State bank of India - XX7890'
    },
    {
      'img': 'assets/images/federal.png',
      'title': 'Aryan Kumar',
      'subTitle': 'Federal bank - XX7890'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
        title: Text(
          'Select the bank account',
          style: bodyText16w600(color: black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: bankAcList.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      decoration: myFillBoxDecoration(0, white, 10),
                      margin: EdgeInsets.all(6),
                      height: height(context) * 0.1,
                      width: width(context) * 0.95,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage(bankAcList[index]['img']),
                              ),
                              title: Text(bankAcList[index]['title']),
                              subtitle: Text(bankAcList[index]['subTitle']),
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
