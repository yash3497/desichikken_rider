import 'dart:developer';

import 'package:amaze_rider/providers/service_procider.dart';
import 'package:amaze_rider/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfflineScreen extends StatefulWidget {
  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: width(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/offline.png'),
            addVerticalSpace(height(context) * 0.07),
            Text(
              'You are offline',
              style: bodyText20w700(color: black),
            ),
            addVerticalSpace(10),
            Text(
              'Go online to recieve orders',
              style: bodyText16w600(color: black.withOpacity(0.3)),
            ),
            addVerticalSpace(15),
            InkWell(
              onTap: () {
                ServiceProvider sp = Provider.of(context,listen: false);
                sp.riderStatusUpdate();
              },
              child: Container(
                height: height(context) * 0.045,
                width: width(context) * 0.5,
                decoration: BoxDecoration(
                    gradient: redGradient(),
                    borderRadius: BorderRadius.circular(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      color: white,
                    ),
                    addHorizontalySpace(8),
                    Text(
                      'Go online now',
                      style: bodyText14w600(color: white),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
