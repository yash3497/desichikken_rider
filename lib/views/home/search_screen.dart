import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
            )),
        title: Text(
          'Search',
          style: bodyText16w600(color: black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(height(context) * 0.05),
            Text(
              'Search using order ID or name',
              style: bodyText14w600(color: black),
            ),
            addVerticalSpace(20),
            Container(
              height: 50,
              width: width(context) * 0.95,
              decoration: shadowDecoration(20, 10),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: primary,
                    ),
                    contentPadding: EdgeInsets.only(top: 15),
                    hintText: 'Search for an order'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
