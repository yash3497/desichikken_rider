import 'dart:developer';

import 'package:amaze_rider/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../widget/custom_button.dart';
import 'otp_verify_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});


  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          width: width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(height(context) * 0.02),
              Stack(
                children: [
                  SizedBox(
                    height: height(context) * 0.36,
                    child: Image.asset(
                      'assets/images/loginbg.png',
                      color: ligthRed.withOpacity(0.3),
                    ),
                  ),
                  Positioned(
                      left: width(context) * 0.21,
                      top: 40,
                      child: Image.asset('assets/images/login1.png'))
                ],
              ),
              addVerticalSpace(10),
              SizedBox(
                width: width(context) * 0.6,
                child: Text(
                  'Welcome, Ride and earn',
                  textAlign: TextAlign.center,
                  style: bodyText20w700(color: black),
                ),
              ),
              addVerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: width(context) * 0.29,
                    color: Colors.black12,
                  ),
                  addHorizontalySpace(8),
                  Text(
                    'Login or signup',
                    style: bodyText13normal(color: Colors.black54),
                  ),
                  addHorizontalySpace(8),
                  Container(
                    height: 1,
                    width: width(context) * 0.29,
                    color: Colors.black12,
                  ),
                ],
              ),
              addVerticalSpace(30),
              SizedBox(
                width: width(context) * 0.9,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 12, left: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 1.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black38, width: 1.0),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.black38),
                      hintText: 'Enter Mobile Number',
                      fillColor: Colors.white70),
                ),
              ),
              addVerticalSpace(25),
              CustomButton(
                  buttonName: 'Verify',
                  onClick: () {

                    if(controller.text.trim().isNotEmpty&& controller.text.trim().length==10){
                      authProvider.verifyMobile(controller.text.trim(), () {
                        log("kk");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpVerifyScreen()));
                      });
                    }
                  }),
              addVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: width(context) * 0.37,
                    color: Colors.black12,
                  ),
                  addHorizontalySpace(8),
                  Text(
                    'OR',
                    style: bodyText13normal(color: Colors.black54),
                  ),
                  addHorizontalySpace(8),
                  Container(
                    height: 1,
                    width: width(context) * 0.37,
                    color: Colors.black12,
                  ),
                ],
              ),
              addVerticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/google.png'),
                  Image.asset('assets/images/fb.png'),
                  Image.asset('assets/images/apple.png'),
                ],
              ),
              addVerticalSpace(20),
              SizedBox(
                width: width(context) * .93,
                child: Text(
                  'By continuing you about to agree to the terms and conditions,privacy policay',
                  style: bodyText12Small(color: black.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
