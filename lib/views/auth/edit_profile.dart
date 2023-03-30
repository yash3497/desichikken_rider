import 'dart:io';

import 'package:amaze_rider/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

enum gender { none, male, female, others }

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  gender selectedGender = gender.none;

  late AuthProvider authProvider;

  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController licenceController = TextEditingController();

  @override
  void initState() {
    authProvider = Provider.of(context, listen: false);
    nameController.text = authProvider.riderDetails["Name"];
    surNameController.text = authProvider.riderDetails["Surname"];
    dobController.text = authProvider.riderDetails["DOB"];
    emailController.text = authProvider.riderDetails["Email"];
    licenceController.text = authProvider.riderDetails["LicenseNumber"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of(context);

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(title: 'Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpace(20),
              InkWell(
                onTap: () {
                  selectPhoto(context, 1.0, 0);
                },
                child: Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(authProvider
                                .riderDetails["ProfileImage"] ==
                            ""
                        ? "https://firebasestorage.googleapis.com/v0/b/delicious-131ed.appspot.com/o/profile-icon-png-898.png?alt=media&token=fb0db0fa-4d0e-4401-8029-c4190469b4da"
                        : authProvider.riderDetails["ProfileImage"]),
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
              CustomButton(
                  buttonName: 'Save',
                  onClick: () {
                    authProvider.getMsgToken();
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
                      "ProfileImage": profileUrl,

                    }).then((value) {
                      Navigator.pop(context);
                    });
                  }),
              addVerticalSpace(height(context) * 0.01),
            ],
          ),
        ),
      ),
    );
  }

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
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

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hintText, this.controller, this.suffixIcon});

  final String hintText;
  TextEditingController? controller;
  Icon? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: width(context) * 0.91,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
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
            fillColor: Colors.black.withOpacity(0.05),
            hintText: hintText),
      ),
    );
  }

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
