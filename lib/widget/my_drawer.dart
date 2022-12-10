import 'package:amaze_rider/views/auth/create_profile_screen.dart';
import 'package:amaze_rider/views/humburger_menus_screens/privacy_policy_screen.dart';
import 'package:amaze_rider/views/humburger_menus_screens/terns_and_conditions.dart';
import 'package:amaze_rider/views/humburger_menus_screens/wallets_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/constants.dart';
import '../views/humburger_menus_screens/about_us_screen.dart';
import '../views/humburger_menus_screens/contact_us_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          addVerticalSpace(20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
              'Aryan Kumamr.',
              style: bodyText16w600(color: black),
            ),
            subtitle: Text('+91300000000'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => FillYourProfileScreen()));
            },
          ),
          addVerticalSpace(20),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_outlined),
            title: Text(
              'Wallet',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WalletScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.edit_note_rounded),
            title: Text(
              'Edit Profile',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateProfileScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text(
              'Privacy Policy',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.report_gmailerrorred_outlined),
            title: Text(
              'About us',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text(
              'Contact us',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUsScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.note_alt),
            title: Text(
              'Terms & Conditions ',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TermsAndConditons()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text(
              'Logout',
              style: bodyText14w600(color: black),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigator.push(context,MaterialPageRoute(builder: (context)=>))
            },
          ),
        ],
      ),
    );
  }
}
