import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/data/plateform_data.dart';
import 'package:qaisar/screens/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';
import '../components/custom_row.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedPlatform;

  const HomeScreen({super.key, this.selectedPlatform});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late Map<String, dynamic> currentPlateForm;

  void updatePlatform(Map<String, dynamic> platform) {
    debugPrint("Updating platform: $platform");
    setState(() {
      currentPlateForm = Map<String, dynamic>.from(platform);
    });
  }

  @override
  void initState() {
    super.initState();
    currentPlateForm = widget.selectedPlatform ??
        {
          "title": "Download Any Video",
          "subtitle": "Download Video From Any Platform",
          "icon": AppIcons.downloadIcon,
          "buttonColor": const Color(0xff9369DF),
        };
    debugPrint("Initial platform: $currentPlateForm");
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
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Container(
                      width: width * 0.15,
                      height: height * 0.01,
                      decoration: BoxDecoration(
                        color: currentPlateForm['buttonColor'] ??
                            const Color(0xff9369DF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(
                        AppIcons.arrow,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.arrow_forward),
                      ),
                    ),
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
                    borderSide: BorderSide(
                      color: const Color(0xff2684FF),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: height * 0.02),

            // Platforms row
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
                    debugPrint("Navigating to View all");
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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

            Container(
              width: width * 0.9,
              height: height * 0.39,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      AppImages.downloadVideoImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    bottom: 54,
                    left: 10,
                    right: 10,
                    child: Button(
                      color: currentPlateForm['buttonColor'] ??
                          const Color(0xff9369DF),
                      text: const Text(
                        'Download',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0.1,
                    left: 10,
                    right: 10,
                    child: Button(
                      color: Colors.white,
                      text: Text(
                        'Share',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformIcon(
      double width, double height, int index, String iconPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          currentPlateForm = PlateFormData.plateForms[selectedIndex];
        });
      },
      child: Image.asset(
        iconPath,
        height: height * 0.09,
        errorBuilder: (context, error, stackTrace) =>
        const Icon(Icons.error),
      ),
    );
  }
}