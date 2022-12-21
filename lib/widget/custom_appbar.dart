import 'package:amaze_rider/providers/service_procider.dart';
import 'package:amaze_rider/views/home/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import 'custom_textfield.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({required this.title});

  final String title;

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool isToggle = true;
  @override
  Widget build(BuildContext context) {
    ServiceProvider sp = Provider.of(context,listen:true);
    return AppBar(
      backgroundColor: white,
      actions: [
        // Padding(
        //   padding: const EdgeInsets.only(right: 8.0),
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (ctx) => SearchScreen()));
        //     },
        //     child: Icon(
        //       Icons.search,
        //       color: primary,
        //       size: 30,
        //     ),
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(right: 8.0),
        //   child: CircleAvatar(
        //     radius: 18,
        //     backgroundImage: AssetImage('assets/images/profile.png'),
        //   ),
        // ),
      ],
      leadingWidth: width(context) * 0.24,
      leading: FlutterSwitch(
        padding: 1,
        width: 70,
        height: 25,
        toggleSize: 26,
        activeText: 'Online',
        inactiveText: 'Offline',
        valueFontSize: 10,
        activeToggleColor: Colors.white,
        inactiveToggleColor: Colors.white,
        activeTextFontWeight: FontWeight.w700,
        inactiveTextFontWeight: FontWeight.w700,
        showOnOff: true,
        activeColor: Colors.green,
        activeTextColor: Colors.white,
        inactiveTextColor: Colors.white,
        inactiveColor: Colors.red,
        onToggle: (val) {
          // setState(() {
          //   isToggle = val;
          // });
          sp.riderStatusUpdate();
        },
        value: sp.status,
      ),
    );
  }
}
