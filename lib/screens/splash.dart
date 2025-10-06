import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/screens/home_screen.dart';
import 'package:qaisar/screens/onboard_process.dart';
import 'package:qaisar/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation_bar/my_bottom_navigation_bar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int currentStep = 0;
  final int maxSteps = 30;
  bool Showcontiue = false; // Number of steps to fill progress in 3 seconds

  @override
  void initState() {
    super.initState();
    _check();
    // _checkFirstSeen();
  }

  void _check() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && currentStep < maxSteps) {
        setState(() {
          currentStep++;
        });
        _check();
        // keep progressing
      } else {
        setState(() {
          Showcontiue = true;
        });
      }
    });
  }
  //
  // void initState() {
  //   super.initState();
  //   Timer(const Duration(seconds: 2), () async {
  //     final prefs = await SharedPreferences.getInstance();
  //     bool seenOnboarding = prefs.getBool("seenOnboarding") ?? false;
  //
  //     if (seenOnboarding) {
  //       Get.offAllNamed("/home");
  //     } else {
  //       Get.offAllNamed("/onboarding");
  //     }
  //   });
  // }

  Future<void> _checkFirstSeen() async {
    final prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool("seenOnboarding") ?? false;

    //await Future.delayed(const Duration(seconds: 3)); // splash delay

    if (seenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MyBottomNavigationBar()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    }
  }

  void _navigateToSplashScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset(AppImages.splashImage)),
          SizedBox(height: height * 0.1),

          // Progress Bar
          Showcontiue
              ? GestureDetector(
                  onTap: _checkFirstSeen,
                  child: Button(
                    color: Color(0XFF726DDE),
                    text: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 180,
                  child: LinearProgressBar(
                    borderRadius: BorderRadius.circular(5),
                    minHeight: 5,
                    maxSteps: maxSteps,
                    currentStep: currentStep,
                    progressType: LinearProgressBar.progressTypeLinear,
                    progressColor: Color(0xff726DDE),
                    backgroundColor: Colors.grey[300]!,
                  ),
                ),
              ),

              const SizedBox(height: 30),
              Text(
                'Version 1.0',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff888888),
                  fontFamily: 'Montserrat-Regular.ttf',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
