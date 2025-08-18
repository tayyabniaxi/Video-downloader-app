import 'package:flutter/material.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: profile_appbar_row(
          width: width * 0.21,
          text: 'Account Settings',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
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
            Custom_text_field(hintText: 'Enter Your Full Name'),
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
            Custom_text_field(hintText: 'Enter Username'),
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
            Custom_text_field(hintText: 'username29@gmail.com'),
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
            Custom_text_field(hintText: '0000000000'),
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
                    Custom_profile_card(height: height, width: width, text: 'Account Id',lastText: '00000000'),
                    Custom_profile_card(height: height, width: width * 0.98, text: 'Account Id', lastText: '01/01/2025'),
                    Custom_profile_card(height: height, width: width * 0.98, text: 'Account Id', lastText: '01/01/2025')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Custom_profile_card extends StatelessWidget {

  const Custom_profile_card({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.lastText
  });

  final String text;
  final String lastText;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF6F6F6),
      child: SizedBox(
        height: height * 0.07,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(text),
              SizedBox(width: width * 0.43,),
              Text(lastText)
            ],
          ),
        ),
      ),
    );
  }
}

class Custom_text_field extends StatelessWidget {
  final String hintText;

  const Custom_text_field({
    super.key,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xff9999A2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.white,
          )
        ),
      ),
    );
  }
}