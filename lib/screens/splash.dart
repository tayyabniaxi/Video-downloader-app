import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/screens/splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int currentStep = 0;
  final int maxSteps = 30; // Number of steps to fill progress in 3 seconds

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    // Fill the progress bar over 3 seconds
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && currentStep < maxSteps) {
        setState(() {
          currentStep++;
        });
        _startProgress();
      } else {
        _navigateToSplashScreen();
      }
    });
  }

  void _navigateToSplashScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
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
          SizedBox(height: height * 0.3),
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(width: 180,
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
          const SizedBox(height: 15),
          Text('Version 1.0',style: TextStyle(fontSize: 14,color: Color(0xff888888),fontFamily: 'Montserrat-Regular.ttf'),)
        ],
      ),
    );
  }
}