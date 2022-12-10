import 'package:amaze_rider/utils/constants.dart';
import 'package:amaze_rider/views/home/home_screen.dart';
import 'package:amaze_rider/widget/custom_appbar.dart';
import 'package:amaze_rider/widget/custom_button.dart';
import 'package:amaze_rider/widget/custom_textfield.dart';
import 'package:amaze_rider/widget/my_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

enum gender { none, male, female, others }

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  gender selectedGender = gender.none;
  @override
  Widget build(BuildContext context) {
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
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: primary,
                  child: Icon(
                    Icons.person_rounded,
                    color: white,
                    size: 30,
                  ),
                ),
              ),
              addVerticalSpace(5),
              Text(
                'Add a profile photo',
                style: bodyText14normal(color: black.withOpacity(0.5)),
              ),
              addVerticalSpace(40),
              CustomTextField(hintText: 'Name'),
              addVerticalSpace(20),
              CustomTextField(hintText: 'Surname'),
              addVerticalSpace(20),
              CustomTextField(hintText: 'Date of Birth'),
              addVerticalSpace(20),
              CustomTextField(hintText: 'Email'),
              addVerticalSpace(20),
              CustomTextField(hintText: 'Driving license ID'),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NavBar()));
                  }),
              addVerticalSpace(height(context) * 0.01),
            ],
          ),
        ),
      ),
    );
  }
}
