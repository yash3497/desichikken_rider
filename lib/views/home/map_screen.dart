import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../humburger_menus_screens/contact_us_screen.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int reviews = 40;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: black,
            )),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #1223537448',
              style: bodyText14w600(color: black),
            ),
            Text(
              '08:00 P.M.   1 Item, Rs. 400 ',
              style: bodyText11Small(color: black.withOpacity(0.3)),
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUsScreen()));
              },
              child: Text(
                'HELP',
                style: bodyText16w600(color: primary),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height(context) * 0.44,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/map.png'))),
            ),
            Container(
              height: height(context) * 0.48,
              width: width(context),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 2, color: Colors.grey)
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Supermarket, sector 12',
                        style: bodyText14w600(color: black),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUsScreen()));
                        },
                        child: Container(
                          height: 38,
                          width: width(context) * 0.4,
                          decoration: myOutlineBoxDecoration(
                              1, black.withOpacity(0.2), 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  ),
                  Text(
                    'Pickup location',
                    style: bodyText12Small(color: black.withOpacity(0.3)),
                  ),
                  SizedBox(
                    width: width(context) * 1,
                    height: 35,
                    child: Slider(
                      activeColor: primary,
                      value: reviews.toDouble(),
                      onChanged: (value) {
                        reviews = value.toInt();
                      },
                      min: 1,
                      max: 100,
                    ),
                  ),
                  addVerticalSpace(15),
                  Text(
                    'Order Details',
                    style: bodyText14w600(color: black),
                  ),
                  Container(
                      margin: EdgeInsets.all(9),
                      padding: EdgeInsets.all(9),
                      height: height(context) * 0.2,
                      width: width(context) * 0.9,
                      decoration: shadowDecoration(8, 6),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height(context) * 0.14,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
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
                                }),
                          ),
                          addVerticalSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Item Total'),
                              Text(
                                'Rs.400',
                                style: bodyText14w600(color: black),
                              )
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        buttonName: isPicked ? 'Delivered' : 'Picked Up',
                        onClick: () {
                          setState(() {
                            isPicked = !isPicked;
                          });
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
