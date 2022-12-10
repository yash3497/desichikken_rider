import 'package:amaze_rider/views/home/notifications_screen.dart';
import 'package:amaze_rider/views/home/orders_tab.dart';
import 'package:amaze_rider/views/home/rating_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../utils/constants.dart';
import '../views/home/home_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    const OrdersScreen(),
    const NotificationScreen(),
    RatingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              // hoverColor: Colors.red,
              tabBorderRadius: 15,
              gap: 6,
              activeColor: darkRed,
              iconSize: 25,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              // tabBackgroundColor: Colors.red[100]!,
              // color: Colors.green,
              tabBackgroundGradient: tabGradient(),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  iconColor: ligthRed,
                ),
                GButton(
                  icon: Icons.calendar_month_outlined,
                  text: 'Orders',
                  iconColor: ligthRed,
                ),
                GButton(
                  icon: Icons.notifications_rounded,
                  text: 'Notifications',
                  iconColor: ligthRed,
                ),
                GButton(
                  icon: Icons.star_rounded,
                  text: 'Ratings',
                  iconColor: ligthRed,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.blue, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
