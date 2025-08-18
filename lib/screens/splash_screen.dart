import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/screens/bottom_navigation_bar/my_bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImages.graphic)),
          SizedBox(height: height * 0.05),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));
            },
            child: Button(
              color: Color(0xFFF6F6F6),
              text: Text(
                'Continue With Google',
                style: TextStyle(
                  color: Color(0xFF726DDE),
                  fontWeight: FontWeight.w600,
                ),
              ),
              icon: Image.asset(AppIcons.search),
            ),
          ),
          SizedBox(height: height * 0.02),
          Button(
            color: Color(0xFF1877F2),
            text: Text(
              'Continue With Facebook',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
              ),
            ),
            icon: Image.asset(AppIcons.facebookLoginIcon),
          ),
          SizedBox(height: height * 0.02),
          Button(
            color: Color(0xff333333),
            text: Text(
              'Continue With Twitter',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              ),
            ),
            icon: Image.asset(AppIcons.twitterLogin),
          ),
          SizedBox(height: height * 0.03),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 12, color: Colors.black),
              children: const [
                TextSpan(text: 'By continuing, you agree to our'),
                TextSpan(
                  text: ' Terms & Conditions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: '\nand '),
                TextSpan(text: 'Privacy Policy.',style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}