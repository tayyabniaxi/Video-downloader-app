import 'package:get/get.dart';
import 'package:qaisar/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController{
  final isGuest=true.obs;
  final username= ''.obs;


  void onInit() {
    super.onInit();
    loadUser();
  }


  void loadUser() {
    final savedGuest = SharedPrefsService.getBool('isGuest');
    final savedName = SharedPrefsService.getString('username');

    isGuest.value = savedGuest ?? true; // default guest
    username.value = savedName ?? 'Guest';
  }
  void switchToUser(String name) async {
    await SharedPrefsService.setBool('isGuest', false);
    await SharedPrefsService.setString('username', name);
    isGuest.value = false;
    username.value = name;
  }

  void switchToGuest() async {
    await SharedPrefsService.setBool('isGuest', true);
    await SharedPrefsService.setString('username', 'Guest');
    isGuest.value = true;
    username.value = 'Guest';
  }

}