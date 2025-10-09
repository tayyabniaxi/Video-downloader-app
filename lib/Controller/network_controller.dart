import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  final isOnline = true.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();

    // ✅ Updated API handling (list of results)
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      final status = results.isNotEmpty ? results.first : ConnectivityResult.none;
      _updateStatus(status);
    });
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    final status = results.isNotEmpty ? results.first : ConnectivityResult.none;
    _updateStatus(status);
  }

  void _updateStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      isOnline.value = false;
      if (Get.isDialogOpen != true) {
        Get.defaultDialog(
          title: "No Internet Connection",
          middleText: "Please check your network and try again.",
          textConfirm: "OK",
          onConfirm: () => Get.back(),
          barrierDismissible: false,
        );
      }
    } else {
      if (Get.isDialogOpen == true) Get.back(); // Close dialog when back online
      isOnline.value = true;
    }
  }
}
