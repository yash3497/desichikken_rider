import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServiceProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  List newOrderList = [];
  List deliveredOrderList = [];

  void fetchNewOrder() {
    _firebaseFirestore
        .collection("Orders")
        .where("orderAccepted", isEqualTo: true)
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      newOrderList.clear();
      for (var doc in event.docs) {
        log(doc.data().toString());
        newOrderList.add(doc.data());
      }
    });
    notifyListeners();
  }

  void fetchDeliveredOrder() {
    _firebaseFirestore
        .collection("Orders")
        // .where("riderId",
        //     isEqualTo: _firebaseAuth.currentUser!.uid.substring(0, 20))
        .where("orderShipped", isEqualTo: true)
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      deliveredOrderList.clear();
      for (var doc in event.docs) {
        log(doc.data().toString());
        deliveredOrderList.add(doc.data());
      }
    });
    notifyListeners();
  }

  Future<void> rejectOrder(String docId) async {
    _firebaseFirestore
        .collection("Orders")
        .doc(docId)
        .update({}).then((value) {});
    notifyListeners();
  }

  Future<void> acceptOrder(String docId) async {
    _firebaseFirestore
        .collection("Orders")
        .doc(docId)
        .update({}).then((value) {});
    notifyListeners();
  }
}
