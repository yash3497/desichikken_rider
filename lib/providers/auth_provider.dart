import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _verificationId;

  // set setVerificationId(verificationId){
  //   _verificationId = verificationId;
  // }

  get verificationId => _verificationId;

  Future<void> verifyMobile(phone, VoidCallback onOtpSent) async {
    _auth.verifyPhoneNumber(
        phoneNumber: "+91$phone",
        verificationCompleted: (PhoneAuthCredential credential) async {
          _auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              var response = await FirebaseFirestore.instance
                  .collection("Riders")
                  .where("Number", isEqualTo: "+91${phone}")
                  .get();

              if (response.docs.isNotEmpty) {
              } else {}
            }
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          // print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          _verificationId = verificationID;
          onOtpSent();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          _verificationId = verificationID;
          onOtpSent();
        },
        timeout: const Duration(seconds: 60));
    notifyListeners();
  }

  Future<void> verifyOtp(
      verificationId, smsCode, VoidCallback onVerifyOtp) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await _auth.signInWithCredential(credential).then((value) {
      onVerifyOtp();
    });

    notifyListeners();
  }

  var _token;

  get msgToken => _token;

  Future<void> getMsgToken() async {
    _token = await FirebaseMessaging.instance.getToken();
    notifyListeners();
  }

  Future<void> createUserProfile(Map<String, dynamic> mapData) async {

    await _firebaseFirestore
        .collection("Riders")
        .where("riderId", isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        _firebaseFirestore
            .collection("Riders")
            .doc(_auth.currentUser!.uid)
            .set(mapData);
      } else {
        _firebaseFirestore
            .collection("Riders")
            .doc(_auth.currentUser!.uid)
            .update(mapData);
      }
    });
    notifyListeners();
  }

  var _riderDetails;

  get riderDetails => _riderDetails;

  Future<void> fetchRiderDetails() async {
    log("message");
    await _firebaseFirestore
        .collection("Riders")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      _riderDetails = value.data();
      log(riderDetails.toString());
    });

    notifyListeners();
  }



}
