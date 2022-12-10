import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/widget/custom_appbar.dart';

import 'package:flutter/material.dart';

enum gender { none, male, female, others }

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  gender selectedGender = gender.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Add a profile photo',
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              const SizedBox(
                height: 100,
              ),
              CustomTextField(hintText: 'Name'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'Mobile Number'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'Date of Birth'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'Address'),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(hintText: 'Store Name'),
              SizedBox(
                height: height(context) * 0.15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: height(context) * 0.06,
                  width: width(context) * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height(context) * 0.01),
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
