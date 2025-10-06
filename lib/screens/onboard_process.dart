import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qaisar/screens/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qaisar/screens/profile_section/onboarding_Controlle.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = Get.put(OnBoardingController());

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);

    // Navigate to Home (or BottomNavigation)
    Get.offAll(() => const MyBottomNavigationBar());
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: h * .1),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: _completeOnboarding,
                  child: Container(
                    height: h * .04,
                    width: w * .18,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Color(0xff726DDE),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: h * .06),
            Obx(() {
              return Container(
                height: h * .35,
                width: w * .8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      controller.images[controller.currentIndex.value],
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: h * .06),
            Obx(() {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: AnimatedContainer(
                              height: h * .02,
                              width: controller.currentIndex.value == index
                                  ? w * .05
                                  : w * .02,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == index
                                    ? const Color(0xff726DDE)
                                    : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              duration: const Duration(milliseconds: 300),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (controller.currentIndex.value == 2) {
                              // last slide → complete onboarding
                              _completeOnboarding();
                            } else {
                              controller.nextStep();
                            }
                          },
                          child: Container(
                            height: h * .04,
                            width: w * .18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xff726DDE),
                            ),
                            child: const Center(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            Container(
              height: h * .3,
              width: w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                color: Colors.grey.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
