import 'package:amaze_rider/views/auth/create_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../utils/constants.dart';
import '../../widget/custom_button.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({super.key});

  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // addVerticalSpace(30),
                Stack(
                  children: [
                    SizedBox(
                      height: height(context) * 0.35,
                      child: Image.asset(
                        'assets/images/otpbg.png',
                        color: ligthRed.withOpacity(0.3),
                      ),
                    ),
                    Positioned(
                        top: 57,
                        left: 80,
                        child: Image.asset('assets/images/otp1.png'))
                  ],
                ),
                addVerticalSpace(10),
                Text(
                  'Verification Code',
                  style: bodyText20w700(color: black),
                ),

                addVerticalSpace(30),
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
                      'Verify Phone',
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
                    width: width(context) * 0.8,
                    child: const Text(
                      'We have sent to your registerd to your mobile number',
                      textAlign: TextAlign.center,
                    )),
                addVerticalSpace(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+91 95425 78945',
                      style: bodyText16w600(color: black),
                    ),
                    addHorizontalySpace(10),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: primary,
                      child: const Icon(
                        Icons.edit,
                        size: 15,
                      ),
                    )
                  ],
                ),
                addVerticalSpace(20),
                SizedBox(
                  width: width(context) * 0.9,
                  child: Pinput(
                    controller: _pinController,
                    length: 6,
                  ),
                ),
                addVerticalSpace(20),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "Didn't receive an OTP? ",
                      style: bodyText13normal(color: black)),
                  TextSpan(
                      text: "Resent OTP",
                      style: TextStyle(
                          color: primary,
                          decoration: TextDecoration.underline)),
                ])),
                addVerticalSpace(50),
                CustomButton(
                    buttonName: 'Verify',
                    onClick: () {

                   /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateProfileScreen()));*/
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextEditorForPhoneVerify extends StatelessWidget {
  final TextEditingController controller;

  TextEditorForPhoneVerify(this.controller);
  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        autofocus: true,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
          counterText: '',
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ));
  }
}
