import 'package:amaze_rider/model/notifications_model.dart';
import 'package:amaze_rider/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Text(
                  'Notifications',
                  style: bodyText20w700(color: black),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance.collection("Riders").doc(FirebaseAuth.instance.currentUser!.uid).collection("notifications").where("read",isEqualTo: false).get().then((value) {
                      for (var docs in value.docs){
                        docs.reference.update({"read":true});
                      }
                    });
                  },
                  child: Text(
                    'Mark all as read',
                    style: bodyText14w600(color: primary),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Riders").doc(FirebaseAuth.instance.currentUser!.uid).collection("notifications").snapshots(),
                builder: (context,AsyncSnapshot snapshot) {
                  if(!snapshot.hasData){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (ctx, i) {
                        var n = snapshot.data.docs[i];
                        return Column(
                          children: [
                            ListTile(
                              onTap:(){
                                FirebaseFirestore.instance.collection("Riders").doc(FirebaseAuth.instance.currentUser!.uid).collection("notifications").doc(n.id).update({
                                  "read":true
                                });
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: primary,
                                child: Icon(
                                  Icons.person,
                                  color: white,
                                  size: 30,
                                ),
                              ),
                              title: Text(
                                n['msg'],
                                style: bodyText14w600(
                                    color: !n['read'] ? primary : black),
                              ),
                              subtitle: Text(
                                n['time'].toDate().toString().split(" ").first,
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            )
                          ],
                        );
                      });
                }
              ))
        ],
      ),
    );
  }
}
