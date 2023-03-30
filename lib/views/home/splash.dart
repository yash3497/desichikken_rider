import 'dart:async';

import 'package:amaze_rider/views/home/waiting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widget/my_bottom_navbar.dart';
import '../auth/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  fetchData()async{
    Timer(Duration(seconds: 1), () async {
      if(FirebaseAuth.instance.currentUser != null){
        var d = await FirebaseFirestore.instance
            .collection("Riders")
            .doc(FirebaseAuth.instance.currentUser!.uid).get();
        if(d.exists) {
          if (d['verified'] == true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WaitingScreen()));
          }
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignInScreen()));
        }
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SignInScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Loading..."),),
    );
  }
}
