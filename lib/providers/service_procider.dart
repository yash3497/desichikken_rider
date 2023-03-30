import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart';

class ServiceProvider with ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool status = false;
  Timer? timer1;
  Timer? timer2;
  Timer? timer3;

  List newOrderList = [];
  List deliveredOrderList = [];
  double riderLatitude = 0.0;
  double riderLongitude = 0.0;
  int maxDis = 5;
// StreamController? stc1;
//   Stream st1 = FirebaseFirestore.instance
//       .collection("Orders")
//       .where("orderAccept", isEqualTo: true)
//       .where("orderCompleted", isEqualTo: false)
//       .snapshots();

  Future<void> fetchNewOrder() async {
    try {
      Position position = await determinePosition();

      riderLatitude = position.latitude;
      riderLongitude = position.longitude;
    } catch (e) {}
    List tempOrder = [];
    List tempOrder2 = [];
    FirebaseFirestore.instance
        .collection("Orders")
        .where("orderAccept", isEqualTo: true)
        .where("orderCompleted", isEqualTo: false)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        double dis = calculateDistanceKM(doc['customerLatlong']['lat'],
            doc['customerLatlong']['long'], riderLatitude, riderLongitude);
        print("Distance $dis");
        print("Rider lat $riderLatitude");
        print("Rider long $riderLongitude");
        if ((doc['orderAccepted'] == false ||
                doc['deliveryPerson'] == _firebaseAuth.currentUser!.uid) &&
            !doc['denied'].contains(_firebaseAuth.currentUser!.uid) &&
            dis <= maxDis) {
          tempOrder.add(doc);
        }

        if (doc['orderAccepted'] == false &&
            !doc['denied'].contains(_firebaseAuth.currentUser!.uid) &&
            dis <= maxDis) {
          print("adding");
          tempOrder2.add(doc);
        }
      }
      if (tempOrder2.isNotEmpty) {
        //  play audio here
        print("Play audio");
        FlutterRingtonePlayer.play(fromAsset: "assets/audio/alert.mpeg");
      } else {
        //  stop audio here
        FlutterRingtonePlayer.stop();
        print("stop audio");
      }

      newOrderList = tempOrder;
    });
    notifyListeners();
  }

  playSoundCheck() async {
    print("rrr");
    try {
      Position position = await determinePosition();

      riderLatitude = position.latitude;
      riderLongitude = position.longitude;
    } catch (e) {}
    List tempOrder = [];
    FirebaseFirestore.instance
        .collection("Orders")
        .where("orderAccept", isEqualTo: true)
        .where("orderCompleted", isEqualTo: false)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        double dis = calculateDistanceKM(doc['customerLatlong']['lat'],
            doc['customerLatlong']['long'], riderLatitude, riderLongitude);
        print(!doc['denied'].contains(_firebaseAuth.currentUser!.uid));
        print(doc['orderAccepted']);
        if (doc['orderAccepted'] == false &&
            !doc['denied'].contains(_firebaseAuth.currentUser!.uid) &&
            dis <= maxDis) {
          print("adding");
          tempOrder.add(doc);
        }
      }
      if (tempOrder.isNotEmpty) {
        //  play audio here
        print("Play audio");
        FlutterRingtonePlayer.play(fromAsset: "assets/audio/alert.mpeg");
      } else {
        //  stop audio here
        FlutterRingtonePlayer.stop();
        print("stop audio");
      }
    });
  }

  checkStatus() async {
    var rider = await _firebaseFirestore
        .collection("Riders")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    if (rider['isOnline'] == true) {
      status = true;
      runFetchOrderEveryTime();
    } else {
      // stop audio

      if (timer1 != null) {
        timer1!.cancel();
      }
      if (timer2 != null) {
        timer2!.cancel();
      }
      if (timer3 != null) {
        timer3!.cancel();
      }
      FlutterRingtonePlayer.stop();

      status = false;
    }
    notifyListeners();
  }

  void runFetchOrderEveryTime() {
    timer1 = Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchNewOrder();

      // playSoundCheck();
      // fetchDeliveredOrder();
    });
    // timer2 = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   // fetchNewOrder();
    //   playSoundCheck();
    //   // fetchDeliveredOrder();
    // });
    // timer3 = Timer.periodic(const Duration(seconds: 2), (timer) {
    //   // fetchNewOrder();
    //   // playSoundCheck();
    //   fetchDeliveredOrder();
    // });
  }

  void fetchDeliveredOrder() {
    List temp = [];
    _firebaseFirestore
        .collection("Orders")
        .where("deliveryPerson", isEqualTo: _firebaseAuth.currentUser!.uid)
        .where("orderCompleted", isEqualTo: true)
        .get()
        .then((event) {
      // deliveredOrderList.clear();
      for (var doc in event.docs) {
        temp.add(doc);
      }
      deliveredOrderList = temp;
    });
    notifyListeners();
  }

  Future<void> rejectOrder(String docId) async {
    _firebaseFirestore.collection("Orders").doc(docId).update({
      "denied": FieldValue.arrayUnion([_firebaseAuth.currentUser!.uid]),
    }).then((value) {
      newOrderList = [];
      notifyListeners();
      _firebaseFirestore
          .collection("Riders")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        "rejectedOrder": FieldValue.arrayUnion([
          {"id": docId, 'date': DateTime.now()}
        ])
      });
      fetchNewOrder();
    });
    notifyListeners();
  }

  Future<void> acceptOrder(String docId) async {
    var dd =
        await FirebaseFirestore.instance.collection("Orders").doc(docId).get();
    var did = FirebaseFirestore.instance.collection("riderPayments").doc();
    did.set({
      "name": dd['customerName'],
      "orderId": dd['orderId'],
      "items": dd['items'],
      "charge": dd['deliveryFees'],
      "total": dd['totalAmount'],
      "updated": DateTime.now(),
      "address": dd['deliveryAddress'],
      "status": "pending",
      "riderId": FirebaseAuth.instance.currentUser!.uid,
    });
    _firebaseFirestore.collection("Orders").doc(docId).update({
      "deliveryPerson": _firebaseAuth.currentUser!.uid,
      "orderAccepted": true,
      "status": "accepted",
      "riderPaymentId": did.id,
      "orderProcess": true,
    }).then((value) {
      _firebaseFirestore
          .collection("Riders")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({"inTravel": true});
    });
    notifyListeners();
  }

  Future<void> completeOrder(String docId) async {
    var dd =
        await FirebaseFirestore.instance.collection("Orders").doc(docId).get();
    _firebaseFirestore.collection("Orders").doc(docId).update({
      "deliveryPerson": _firebaseAuth.currentUser!.uid,
      "orderAccepted": true,
      "status": "completed",
      "orderCompleted": true,
    }).then((value) async {
      FirebaseFirestore.instance
          .collection("riderPayments")
          .doc(dd['riderPaymentId'])
          .update({
        "status": "completed",
      });
      var orderD = await FirebaseFirestore.instance
          .collection("Orders")
          .doc(docId)
          .get();
      double amount = orderD['deliveryFees'];
      _firebaseFirestore
          .collection("Riders")
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        "wallet": FieldValue.increment(amount),
        "completedOrder": FieldValue.arrayUnion([
          {"id": docId, 'date': DateTime.now(), "charge": amount}
        ]),
        "inTravel": false,
      });
      await sendNotification(orderD['uid']);
    });
    notifyListeners();
  }

  Future<void> collectOrder(String docId) async {
    _firebaseFirestore.collection("Orders").doc(docId).update({
      "deliveryPerson": _firebaseAuth.currentUser!.uid,
      "orderAccepted": true,
      "status": "picked"
    }).then((value) {});
    notifyListeners();
  }

  riderStatusUpdate() async {
    var rider = await _firebaseFirestore
        .collection("Riders")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    if (rider['isOnline'] == true) {
      if (rider.data()!['inTravel'] != null) {
        if (rider.data()!['inTravel'] == true) {
          Fluttertoast.showToast(
              msg: "You can't go offline without completing order");
        } else {
          rider.reference.update({'isOnline': false});
          status = false;
          if (timer1 != null) {
            timer1!.cancel();
          }
          if (timer2 != null) {
            timer2!.cancel();
          }
          if (timer3 != null) {
            timer3!.cancel();
          }
          FlutterRingtonePlayer.stop();
        }
      } else {
        rider.reference.update({'isOnline': false, 'inTravel': false});
        status = false;
        if (timer1 != null) {
          timer1!.cancel();
        }
        if (timer2 != null) {
          timer2!.cancel();
        }
        if (timer3 != null) {
          timer3!.cancel();
        }
        FlutterRingtonePlayer.stop();
      }
    } else {
      rider.reference.update({'isOnline': true});
      status = true;
      runFetchOrderEveryTime();
    }
    notifyListeners();
  }

  String findTime(var time) {
    DateTime t = time.toDate();
    DateTime ct = DateTime.now();
    Duration duration = ct.difference(t);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}h:${twoDigitMinutes}m:${twoDigitSeconds}s";
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  double calculateDistanceKM(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  makePhoneCall(String number) {
    try {
      launchUrl(Uri.parse("tel://$number"));
    } catch (e) {
      print(e);
    }
  }

  Future<void> openMap(double latitude, double longitude) async {
    print(latitude);
    print(longitude);
    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // await launchUrl(Uri.parse(googleUrl));

    bool isMap = await MapLauncher.isMapAvailable(MapType.google) ?? false;

    if (isMap) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(latitude, longitude),
        title: '',
      );
    }
  }

  Future<double> calculateTodayEarning() async {
    var a = await FirebaseFirestore.instance
        .collection("Riders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    List completed = a.data()!['completedOrder'] ?? [];
    double am = 0.0;
    for (var o in completed) {
      DateTime od = o['date'].toDate();
      DateTime td = DateTime.now();
      if (od.day == td.day && od.month == td.month && od.year == td.year) {
        am = am + o['charge'];
      }
    }
    return am;
  }

  Future<void> sendNotification(String userDocId) async {
    var postUrl = "https://fcm.googleapis.com/fcm/send";
    var f = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userDocId)
        .get();
    var token = f.data()!['token'] ?? "";
    print(token);
    final data = {
      "notification": {
        "body": "Successfully!!!",
        "title": "Your order delivered"
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": "$token"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAGl6VFKY:APA91bHLSjT-_c5cG3wkr8Gop-bhV6_Y0gyRW29s7SZHLyxh8l9LgedxUKOTOd-NGXNBmZIhEtNyMsfTYJWxC39bQaB_OahvZwbWKFptvnshLKRz7cguBbPcIccd9pgVIoa2LCmubAWJ'
    };

    BaseOptions options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: headers,
    );

    try {
      await Dio(options).post(postUrl, data: data);
    } catch (e) {
      print('exception $e');
    }
  }
}
