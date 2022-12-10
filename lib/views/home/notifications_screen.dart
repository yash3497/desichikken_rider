import 'package:amaze_rider/model/notifications_model.dart';
import 'package:amaze_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Text(
                  'Notifications',
                  style: bodyText20w700(color: black),
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Mark all as read',
                    style: bodyText14w600(color: primary),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: primary,
                            child: Icon(
                              Icons.person,
                              color: white,
                              size: 30,
                            ),
                          ),
                          title: Text(
                            notificationList[i]['title'],
                            style: bodyText14w600(
                                color: i == 0 || i == 1 ? primary : black),
                          ),
                          subtitle: Text(
                            notificationList[i]['subTitle'],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        )
                      ],
                    );
                  }))
        ],
      ),
    );
  }
}
