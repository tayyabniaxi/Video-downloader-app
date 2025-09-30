import 'package:get/get.dart';
import 'package:qaisar/assets/app_assets.dart';

import '../home_screen.dart';
import '../splash_screen.dart';

class OnBoardingController extends GetxController{

  var currentIndex = 0.obs;

  final List<String> images = [
AppImages.onBoard1,
AppImages.onBoard2,
AppImages.onBoard3,
  ];

  void nextStep() {
    if (currentIndex.value < images.length - 1) {
      currentIndex.value++;
    } else {
      // Navigate to HomeScreen after last index
      Get.offAll(() => SplashScreen());
      // OR if using named routes:
      // Get.offAllNamed('/');
    }
  }

}