import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qaisar/components/custom_profile_card.dart';
import 'package:qaisar/components/custom_text_field.dart';
import 'package:qaisar/components/profile_appbar_row.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool? isLoggedIn;
  void Loadstate() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  void initState() {
    super.initState();
    Loadstate();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Account Settings'),
            InkWell(
              onTap: () {
                Get.to(ProfileSection());
              },
              child: Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff726DDE),
                ),
                child: Center(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // title: ProfileAppbarRow(
        //   width: width * 0.21,
        //   text: 'Account Settings',
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: isLoggedIn == "false"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Your Profile',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Color(0xff726DDE),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff646464),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(hintText: 'Enter Your Full Name'),
                    SizedBox(height: height * 0.01),
                    Text(
                      'User Name',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff646464),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(hintText: 'Enter Username'),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff646464),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(hintText: 'username29@gmail.com'),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xff646464),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    CustomTextField(hintText: '0000000000'),
                    SizedBox(height: height * 0.03),
                    Container(
                      width: width * 1,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Edit Your Profile',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xff726DDE),
                              ),
                            ),
                            CustomProfileCard(
                              height: height,
                              width: width,
                              text: 'Account Id',
                              lastText: '00000000',
                            ),
                            CustomProfileCard(
                              height: height,
                              width: width,
                              text: 'Account Id',
                              lastText: '01/01/2025',
                            ),
                            CustomProfileCard(
                              height: height,
                              width: width,
                              text: 'Account Id',
                              lastText: '01/01/2025',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
               //   Center(child: Text("Guest User")),
                ],
              ),
        ),
      ),
    );
  }
}
