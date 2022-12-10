import 'package:amaze_rider/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/constants.dart';

class RejectedDeliveryScreen extends StatelessWidget {
  const RejectedDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () {},
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
                                  'Kinjal Parmar',
                                  style: bodyText14w600(color: black),
                                ),
                                const Spacer(),
                                Container(
                                  height: height(context) * 0.04,
                                  width: width(context) * 0.3,
                                  decoration:
                                      myFillBoxDecoration(0, Colors.red, 6),
                                  child: Center(
                                    child: Text(
                                      'Rejected',
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
                                  'Order ID- 998070',
                                  style: bodyText13normal(color: black),
                                ),
                                Text(
                                  'Yesterday, 09:00PM',
                                  style: bodytext12Bold(color: black),
                                )
                              ],
                            ),
                            addVerticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Poultry chicken (1), Frozen chicken(1)',
                                  style: bodytext12Bold(
                                      color: black.withOpacity(0.3)),
                                ),
                                Text(
                                  'Rs. 400',
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
                                  'Sector 16, Old city 500088',
                                  style: bodyText14w600(color: black),
                                )
                              ],
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
