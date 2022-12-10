import 'package:amaze_rider/views/auth/edit_profile.dart';
import 'package:amaze_rider/views/humburger_menus_screens/privacy_policy_screen.dart';
import 'package:amaze_rider/views/humburger_menus_screens/terns_and_conditions.dart';
import 'package:amaze_rider/views/humburger_menus_screens/wallets_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../utils/constants.dart';
import '../views/auth/signin_screen.dart';
import '../views/humburger_menus_screens/about_us_screen.dart';
import '../views/humburger_menus_screens/contact_us_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late AuthProvider authProvider;

  @override
  void initState() {
    authProvider = Provider.of(context, listen: false);
    authProvider.fetchRiderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of(context);

    return Drawer(
      child: ListView(
        children: [
          addVerticalSpace(20),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: authProvider.riderDetails != null
                  ? Image.network(authProvider.riderDetails["ProfileImage"] ==
                          ""
                      ? "https://firebasestorage.googleapis.com/v0/b/delicious-131ed."
                          "appspot.com/o/profile-icon-png-898.png?alt=media&token=fb0db0fa"
                          "-4d0e-4401-8029-c4190469b4da"
                      : authProvider.riderDetails["ProfileImage"])
                  : Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.fill,
                    ),
            ),
            title: Text(
              authProvider.riderDetails != null
                  ? authProvider.riderDetails["Name"]
                  : "Name",
              style: bodyText16w600(color: black),
            ),
            subtitle: Text(
              authProvider.riderDetails != null
                  ? authProvider.riderDetails["Number"]
                  : "+918765432109",
            ),
          ),
          addVerticalSpace(20),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: Text(
              'Wallet',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
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
            leading: const Icon(Icons.edit_note_rounded),
            title: Text(
              'Edit Profile',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()));
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
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(
              'Privacy Policy',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.report_gmailerrorred_outlined),
            title: Text(
              'About us',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUsScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: Text(
              'Contact us',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContactUsScreen()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.note_alt),
            title: Text(
              'Terms & Conditions ',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TermsAndConditons()));
            },
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text(
              'Logout',
              style: bodyText14w600(color: black),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () async {
              await FirebaseAuth.instance.signOut().then((value) => {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInScreen()))
                  });
            },
          ),
        ],
      ),
    );
  }
}
