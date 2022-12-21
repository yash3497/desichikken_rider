import 'dart:io';

import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/views/home/waiting.dart';
import 'package:amaze_rider/widget/custom_appbar.dart';
import 'package:amaze_rider/widget/custom_button.dart';
import 'package:amaze_rider/widget/custom_textfield.dart';
import 'package:amaze_rider/widget/my_bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

enum gender { none, male, female, others }

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  gender selectedGender = gender.none;


  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  File? image;
  bool load = false;
  void pickImage(ImageSource ims)async{
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ims).then((value) {
      if(value == null) return;
      setState((){
        image = File(value.path);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppbar(title: '')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpace(20),
              Center(
                child: InkWell(
                  onTap: (){
                    showModalBottomSheet(
                        context: context,
                        builder: (context){
                          return Container(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ListTile(
                                  title: Text("Camera"),
                                  leading: Icon(Icons.camera),
                                  onTap: (){
                                    Navigator.pop(context);
                                    pickImage(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  title: const Text("Gallery"),
                                  leading: Icon(Icons.image ),
                                  onTap: (){
                                    Navigator.pop(context);
                                    pickImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  },
                  child:image!=null?CircleAvatar(
                    radius: 35,
                    backgroundImage: FileImage(image!),
                  ): CircleAvatar(
                    radius: 35,
                    backgroundColor: primary,
                    child: Icon(
                      Icons.person_rounded,
                      color: white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              addVerticalSpace(5),
              Text(
                'Add a profile photo',
                style: bodyText14normal(color: black.withOpacity(0.5)),
              ),
              addVerticalSpace(40),
              CustomTextField(
                hintText: 'Name',
                controller: nameController,
              ),
              addVerticalSpace(20),
              CustomTextField(
                hintText: 'Surname',
                controller: surNameController,
              ),
              addVerticalSpace(20),
              CustomTextField(
                hintText: 'Date of Birth',
                controller: dobController,
              ),
              addVerticalSpace(20),
              CustomTextField(
                hintText: 'Email',
                controller: emailController,
              ),
              addVerticalSpace(20),
              CustomTextField(
                hintText: 'Driving license ID',
                controller: licenceController,
              ),
              addVerticalSpace(30),
              Padding(
                padding: EdgeInsets.only(right: width(context) * 0.5),
                child: Text(
                  'Gender preference',
                  style: bodyText16w600(color: Colors.black26),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Male',
                    style: bodyText14w600(color: black),
                  ),
                  Radio(
                      activeColor: primary,
                      value: gender.male,
                      groupValue: selectedGender,
                      onChanged: (val) {
                        setState(() {});
                        selectedGender = val as gender;
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Female',
                    style: bodyText14w600(color: black),
                  ),
                  Radio(
                      activeColor: primary,
                      value: gender.female,
                      groupValue: selectedGender,
                      onChanged: (val) {
                        setState(() {});
                        selectedGender = val as gender;
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Others',
                    style: bodyText14w600(color: black),
                  ),
                  Radio(
                      activeColor: primary,
                      value: gender.others,
                      groupValue: selectedGender,
                      onChanged: (val) {
                        setState(() {});
                        selectedGender = val as gender;
                      }),
                ],
              ),
              addVerticalSpace(height(context) * 0.05),
           !load ?  CustomButton(
                  buttonName: 'Save',
                  onClick: () async {
                    setState(() {
                      load = true;
                    });
                    // authProvider.getMsgToken();
                    String imaUrl = "";
                    if(image != null) {
                      FirebaseStorage storage = FirebaseStorage.instance;
                      Reference ref =
                      storage.ref().child("riders/${DateTime.now().toString()}");

                      UploadTask uploadTask = ref.putFile(image!);
                      setState(() {
                      });
                      await uploadTask.whenComplete(() async {
                        var url = await ref.getDownloadURL();
                        imaUrl = url;

                      }).catchError((onError) {
                      });
                    }
                    authProvider.createUserProfile({
                      "Name": nameController.text.trim(),
                      "Surname": surNameController.text.trim(),
                      "DOB": dobController.text.trim(),
                      "Email": emailController.text.trim(),
                      "LicenseNumber": licenceController.text.trim(),
                      "Number":
                      FirebaseAuth.instance.currentUser?.phoneNumber ?? "",
                      "Gender": selectedGender.toString(),
                      "riderId": FirebaseAuth.instance.currentUser?.uid ?? "",
                      "isOnline": true,
                      "token": authProvider.msgToken,
                      "ProfileImage": imaUrl,
                      'inTravel':false,
                      'verified':false,
                      'rejectedOrder':[],
                      "completedOrder":[],
                    }).then((value) {
                      setState(() {
                        load = false;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>const WaitingScreen()));
                    });
                  }):Row(
             mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
              addVerticalSpace(height(context) * 0.01),
            ],
          ),
        ),
      ),
    );
  }


  Future selectPhoto(BuildContext context, double d, int i) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
              onClosing: () {},
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text("Camera"),
                      onTap: () async {
                        Navigator.pop(context);

                        getImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.album),
                      title: const Text("Gallery"),
                      onTap: () async {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                    )
                  ],
                );
              });
        });
  }

  Future getImage(ImageSource source) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      final XFile? image =
      await ImagePicker().pickImage(source: source, imageQuality: 60);
      setState(() {});

      if (image == null) return;
      Reference reference = storage
          .ref()
          .child("riders")
          .child(FirebaseAuth.instance.currentUser!.uid);

      UploadTask uploadTask = reference.putFile(File(image.path));
      TaskSnapshot snapshot = await uploadTask;
      profileUrl = await (snapshot).ref.getDownloadURL();
      print(profileUrl);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  String profileUrl = '';
  final ImagePicker picker = ImagePicker();
}
