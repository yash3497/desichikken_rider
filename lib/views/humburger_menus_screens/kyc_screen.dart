import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/service_procider.dart';
import '../../utils/constants.dart';
import '../../widget/custom_textfield.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  TextEditingController nameAsBank = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  String imageUrl = "";
  File? image;
  bool loading = false;
  pickFile(ImageSource ims) async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ims).then((value) {
      if (value == null) return;
      setState(() {
        image = File(value.path);
      });
    });
  }

  fetchData() async {
    var d = await FirebaseFirestore.instance
        .collection("Riders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      nameAsBank.text = d.data()!['nameAsBank'] ?? "";
      accountNumber.text = d.data()!['accountNumber'] ?? "";
      ifsc.text = d.data()!['ifsc'] ?? "";
      imageUrl = d.data()!['personalKyc'] ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    ServiceProvider sp = Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kyc Screen",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: white,
        leadingWidth: width(context) * 0.24,
        leading: FlutterSwitch(
          padding: 1,
          width: 70,
          height: 25,
          toggleSize: 26,
          activeText: 'Online',
          inactiveText: 'Offline',
          valueFontSize: 10,
          activeToggleColor: Colors.white,
          inactiveToggleColor: Colors.white,
          activeTextFontWeight: FontWeight.w700,
          inactiveTextFontWeight: FontWeight.w700,
          showOnOff: true,
          activeColor: Colors.green,
          activeTextColor: Colors.white,
          inactiveTextColor: Colors.white,
          inactiveColor: Colors.red,
          onToggle: (val) {
            // setState(() {
            //   isToggle = val;
            // });
            sp.riderStatusUpdate();
          },
          value: sp.status,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Name as bank',
                controller: nameAsBank,
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
                width: width(context) * 0.91,
                child: TextFormField(
                  controller: ifsc,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.black38,
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      filled: true,
                      fillColor: black.withOpacity(0.05),
                      hintText: 'IFSC'),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                hintText: 'Account number',
                controller: accountNumber,
              )
            ],
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return SizedBox(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ListTile(
                            title: const Text("Camera"),
                            leading: const Icon(Icons.camera),
                            onTap: () {
                              Navigator.pop(context);
                              pickFile(ImageSource.camera);
                            },
                          ),
                          const Divider(),
                          ListTile(
                            title: const Text("Gallery"),
                            leading: const Icon(Icons.image),
                            onTap: () {
                              Navigator.pop(context);
                              pickFile(ImageSource.gallery);
                            },
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: black.withOpacity(0.05),
              ),
              width: MediaQuery.of(context).size.width * .8,
              child: image != null
                  ? Image.file(
                      image!,
                      fit: BoxFit.contain,
                    )
                  : imageUrl != ""
                      ? Image.network(imageUrl, fit: BoxFit.contain)
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.credit_card_rounded),
                              Text(
                                "Add driving Licence or Pan card",
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              )
                            ],
                          ),
                        ),
            ),
          ),
          const SizedBox(height: 40),
          loading
              ? const CircularProgressIndicator()
              : MaterialButton(
                  onPressed: () async {
                    String imaUrl = "";
                    if (accountNumber.text != "" &&
                        nameAsBank.text != "" &&
                        ifsc.text != "") {
                      RegExp r  = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
                      if(r.hasMatch(ifsc.text)) {
                        setState(() {
                          loading = true;
                        });

                        if (image != null) {
                          FirebaseStorage storage = FirebaseStorage.instance;
                          Reference ref = storage.ref().child(
                              "rider/kyc/${FirebaseAuth.instance.currentUser!
                                  .uid}");

                          UploadTask uploadTask = ref.putFile(image!);
                          setState(() {});
                          await uploadTask.whenComplete(() async {
                            var url = await ref.getDownloadURL();
                            imaUrl = url;
                          }).catchError((onError) {});
                        }

                        if (image != null) {
                          FirebaseFirestore.instance
                              .collection("Riders")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "nameAsBank": nameAsBank.text,
                            "ifsc": ifsc.text,
                            "accountNumber": accountNumber.text,
                            "personalKyc": imaUrl,
                            "lastUpdated": DateTime.now(),
                          });
                          Fluttertoast.showToast(msg: "Updated Successfully");
                        }
                        else {
                          FirebaseFirestore.instance
                              .collection("Riders")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "nameAsBank": nameAsBank.text,
                            "ifsc": ifsc.text,
                            "accountNumber": accountNumber.text,
                            "lastUpdated": DateTime.now(),
                          });
                          Fluttertoast.showToast(msg: "Updated Successfully");
                        }
                      }else{
                        Fluttertoast.showToast(msg: "Invalid IFSC code");
                        ifsc.clear();
                        setState(() {

                        });
                      }
                    }else{
                      Fluttertoast.showToast(msg: "Please Provide all details");
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  color: Colors.red,
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                )
        ],
      ),
    );
  }
}
