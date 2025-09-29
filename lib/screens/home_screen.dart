import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/data/plateform_data.dart';
import 'package:qaisar/screens/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';
import 'package:share_plus/share_plus.dart';
import '../components/custom_row.dart';
import '../video_downloader_service.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedPlatform;

  const HomeScreen({super.key, this.selectedPlatform});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<VideoDownloaderService>();
  final _formkey = GlobalKey<FormState>();
  int selectedIndex = 0;
  TextEditingController _link = TextEditingController();
  late Map<String, dynamic> currentPlateForm;

  void updatePlatform(Map<String, dynamic> platform) {
    setState(() {
      currentPlateForm = Map<String, dynamic>.from(platform);
    });
  }

  @override
  void initState() {
    super.initState();
    currentPlateForm = widget.selectedPlatform ??
        {
          "title": "Any Video Downloader",
          "subtitle": "Download Video From Any Platform",
          "icon": AppIcons.downloadIcon,
          "buttonColor": const Color(0xff9369DF),
        };
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedPlatform != null &&
        widget.selectedPlatform != oldWidget.selectedPlatform) {
      updatePlatform(widget.selectedPlatform!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileSection()),
          ),
          child: CustomRow(
            width: width * 0.2,
            text: 'Video Downloader',
            logo: AppIcons.logo,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.03),
            Image.asset(
              currentPlateForm['icon'] ?? AppIcons.downloadIcon,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            SizedBox(height: height * 0.01),
            Text(
              currentPlateForm['title'] ?? 'Download Any Video',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: height * 0.01),
            Text(
              currentPlateForm['subtitle'] ??
                  'Download Video From Any Platform',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff8F8F8F),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: _formkey,
                child: TextFormField(
                  controller: _link,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Url required";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Obx(() {
                        return controller.isLoading.value
                            ? SizedBox(
                                child: SpinKitThreeBounce(
                                  color: currentPlateForm['buttonColor'] ??
                                      const Color(0xff9369DF),
                                  size: 20,
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    final url = _link.text.trim();
                                    if (url.isNotEmpty) {
                                      controller.isLoading.value = true;
                                      await controller.VideoDownloadApi(url);
                                      controller.isLoading.value = false;
                                    }
                                  }
                                },
                                child: Container(
                                  width: width * 0.15,
                                  height: height * 0.01,
                                  decoration: BoxDecoration(
                                    color: currentPlateForm['buttonColor'] ??
                                        const Color(0xff9369DF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.all(6),
                                  child: Image.asset(AppIcons.arrow),
                                ),
                              );
                      }),
                    ),
                    hintText: 'Paste url here',
                    hintStyle: const TextStyle(
                      color: Color(0xFF000066),
                      fontSize: 16,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xff2684FF),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPlatformIcon(width, height, 0, AppIcons.facebook),
                SizedBox(width: width * 0.05),
                _buildPlatformIcon(width, height, 1, AppIcons.youTube),
                SizedBox(width: width * 0.05),
                _buildPlatformIcon(width, height, 2, AppIcons.instagram),
                SizedBox(width: width * 0.05),
                GestureDetector(
                  onTap: () async {
                    _clearData();
                    final selectedPlatform = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const MyBottomNavigationBar(initialIndex: 1),
                      ),
                    );
                    if (selectedPlatform != null) {
                      updatePlatform(selectedPlatform);
                    }
                  },
                  child: Container(
                    width: width * 0.19,
                    height: height * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_forward_ios_sharp, size: 18),
                        Text(
                          'View all',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Obx(() {
              final downloading = controller.isDownloading.value;
              return Container(
                width: width * 0.9,
                height: height * 0.39,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: controller.thumbnail.value.isNotEmpty
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              controller.thumbnail.value,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            bottom: 65,
                            left: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                final originalUrl = _link.text.trim();
                                final directUrl = controller.downloadUrl.value;

                                if (originalUrl.isNotEmpty) {
                                  if (directUrl.isNotEmpty) {
                                    await controller.downloadDirectUrl(
                                        directUrl, "video");
                                  } else {
                                    await controller.downloadVideo(
                                        originalUrl, "video");
                                  }
                                } else {
                                  Get.snackbar("Error", "URL not found!");
                                }
                              },
                              child: Button(
                                color: currentPlateForm['buttonColor'],
                                text: Text(
                                  downloading ? "Downloading..." : "Download",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () {
                                final url = _link.text.trim();
                                if (url.isNotEmpty) {
                                  Share.share(
                                    "Check out this video:\n$url",
                                    subject: "Video Download Link",
                                  );
                                } else {
                                  Get.snackbar("Error", "No link found!");
                                }
                              },
                              child: const Button(
                                color: Colors.white,
                                text: Text(
                                  'Share',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              AppImages.HowToDownload,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformIcon(
    double width,
    double height,
    int index,
    String iconPath,
  ) {
    return GestureDetector(
      onTap: () {
        _clearData();
        setState(() {
          selectedIndex = index;
          currentPlateForm = PlateFormData.plateForms[selectedIndex];
        });
      },
      child: Image.asset(
        iconPath,
        height: height * 0.09,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    );
  }

  void _clearData() {
    _link.clear();
    controller.thumbnail.value = "";
    controller.downloadUrl.value = "";
  }
}
