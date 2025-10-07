import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/data/plateform_data.dart';
import 'package:qaisar/screens/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';
import 'package:qaisar/screens/video_player_screen.dart';
import 'package:share_plus/share_plus.dart';
//import 'package:video_player/video_player.dart'; // Add video_player import
import '../components/custom_row.dart';
//import '../components/textformfield.dart';
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
  //VideoPlayerController? _videoPlayerController; // Video player controller
  bool _isVideoInitialized = false;

  void updatePlatform(Map<String, dynamic> platform) {
    setState(() {
      currentPlateForm = Map<String, dynamic>.from(platform);
    });
  }

  @override
  void initState() {
    super.initState();
    currentPlateForm =
        widget.selectedPlatform ??
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
  void dispose() {
    //_videoPlayerController?.dispose(); // Dispose of video controller
    super.dispose();
  }

  @override
  // ... (previous imports and code remain unchanged)
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03),
              Container(
                height: MediaQuery.of(context).size.height * 0.065,
                child: Image.asset(
                  currentPlateForm['icon'] ?? AppIcons.downloadIcon,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                currentPlateForm['title'] ?? 'Download Any Video',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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

            Form(
              key: _formkey,
              child: Obx(() {
                return TextFormField(
                  controller: _link,
                  autovalidateMode: AutovalidateMode.onUserInteraction, // 👈 Live validation
                  onChanged: (_) {
                    // Force rebuild when typing so ❌ icon shows/hides properly
                    controller.isLoading.refresh();

                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "URL required";
                    }

                    // 🔹 Basic URL pattern validation
                    final urlPattern =
                        r'^(https?:\/\/)?([\w\-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/\S*)?$';
                    final regExp = RegExp(urlPattern);

                    if (!regExp.hasMatch(value.trim())) {
                      return "Enter a valid URL";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Paste URL Here',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
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

                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),

                    // ✅ Handle spinner / clear / send icons
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: controller.isLoading.value
                          ? SizedBox(
                        width: 30,
                        height: 30,
                        child: SpinKitThreeBounce(
                          color: currentPlateForm['buttonColor'] ??
                              const Color(0xff9369DF),
                          size: 20,
                        ),
                      )
                          : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ❌ Show only when text field has text
                          if (_link.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _link.clear();
                                controller.isLoading.refresh();

                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 22,
                              ),
                            ),
                          const SizedBox(width: 6),
                          // ➡️ Send button
                          GestureDetector(
                            onTap: () async {
                              // 🔹 Validate form before proceeding
                              if (_formkey.currentState?.validate() ?? false) {
                                final url = _link.text.trim();
                                controller.isLoading.value = true;
                                controller.thumbnail.value="";


                                await controller.videoDownloadApi(url);

                                controller.isLoading.value = false;
                              }
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: currentPlateForm['buttonColor'] ??
                                    const Color(0xff9369DF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Image.asset(AppIcons.arrow),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),

           SizedBox(height: height * 0.02),
              Obx((){
                final hasthumbnail = controller.thumbnail.value.isNotEmpty;
                return Column(
                  children: [
                  if(!hasthumbnail)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPlatformIcon(width, height, 0, AppIcons.fb1),
                        SizedBox(width: width * 0.035),
                        _buildPlatformIcon(width, height, 1, AppIcons.yt1),
                        SizedBox(width: width * 0.035),
                        _buildPlatformIcon(width, height, 2, AppIcons.insta1),
                        SizedBox(width: width * 0.035),
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
                            width: width * 0.17,
                            height: height * 0.08,
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
                    Container(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Obx(() {
                        // Only wrap the thumbnail/video part in Obx
                        if (controller.thumbnail.value.isNotEmpty) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1,color: Colors.grey.shade200)
                            ),
                            width: width * 0.72,
                            height: height * 0.42,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("Link ${controller.OriginalUrl.value}");
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (_) => VideoPage(videoUrl:
                                    //        controller.OriginalUrl.value,
                                    //       //thumbnailUrl: "",
                                    //     ),
                                    //   ),
                                    // );

                                    // if (_isVideoInitialized &&
                                    //     _videoPlayerController != null) {
                                    //   setState(() {
                                    //     _videoPlayerController!.value.isPlaying
                                    //         ? _videoPlayerController!.pause()
                                    //         : _videoPlayerController!.play();
                                    //   });
                                    // }
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      print("Link ${controller.OriginalUrl.value}");

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (_) =>
                                      //         VideoPage(videoUrl: _link.text),
                                      //   ),
                                      // );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: controller.isLoading.value
                                          ? Center(child: SizedBox())
                                          : Image.network(
                                        controller.thumbnail.value,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                        const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),

                                // Download button with separate Obx
                                Positioned(
                                  bottom: 65,
                                  left: 10,
                                  right: 10,
                                  child: Obx(() {
                                    final downloading = controller.isDownloading.value;
                                    return GestureDetector(
                                      onTap: downloading? null:() async {
                                        final originalUrl = _link.text.trim();
                                        final directUrl = controller.downloadUrl.value;
                                        controller.progress.value=0;

                                        if (originalUrl.isEmpty) {
                                          Get.snackbar("Error", "URL not found!");
                                          return;
                                        }

                                        if (directUrl.isEmpty) {
                                          Get.snackbar(
                                            "Error",
                                            "No direct URL available!",
                                          );
                                          return;
                                        }

                                        // 🔹 Ask user for quality
                                        // final selectedQuality = await showQualityPopup(
                                        //   context,
                                        // );
                                        if (controller.medias.isNotEmpty) {
                                          controller.showQualityDialog();
                                        } else {
                                          controller.downloadDirectUrl(
                                            controller.downloadUrl.value,
                                            "Default",
                                          );
                                          //   Get.snackbar("", "No quality options available!");
                                        }
                                        // if (selectedQuality != null) {
                                        //   // Pass quality to your download method
                                        //   await controller.videoDownloadApi(
                                        //     directUrl,
                                        //    // "video_$selectedQuality",
                                        //   );
                                        //   Get.snackbar(
                                        //     "Download",
                                        //     "Downloading $selectedQuality quality...",
                                        //   );
                                        // }
                                      },

                                      child: Button(
                                        color:   downloading?Colors.grey.shade300 :currentPlateForm['buttonColor'],
                                        text: Text(
                                          downloading
                                              ? "Downloading... ${controller.progress.value.toStringAsFixed(0)}%"
                                              : "Download",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                // Share button (no Obx needed, as it doesn't depend on reactive variables)
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
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                // Positioned(
                                //   bottom: 90,
                                //   left:10,
                                //   right: 10,
                                //   child: ElevatedButton(
                                //     onPressed: () async {
                                //       final result = await showQualityPopup(context);
                                //       if (result != null) {
                                //         print("Selected Quality: $result");
                                //       }
                                //     },
                                //     child: Text("Show Popup"),
                                //   ),
                                //
                                // ),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 12),
                              Obx(() {
                                return controller.isLoading.value
                                    ? Center(child: Container(
                                    height: height * 0.32,

                                    child: Center(child: CircularProgressIndicator())))
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppImages.HowToDownload,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                    const Icon(Icons.error),
                                  ),
                                );
                              }),
                              const SizedBox(height: 12),
                            ],
                          );
                        }
                      }),
                    ),
                    SizedBox(height: height * 0.02),

                    if(hasthumbnail)
                     Column(
                children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPlatformIcon(width, height, 0, AppIcons.fb1),
                          SizedBox(width: width * 0.035),
                          _buildPlatformIcon(width, height, 1, AppIcons.yt1),
                          SizedBox(width: width * 0.035),
                          _buildPlatformIcon(width, height, 2, AppIcons.insta1),
                          SizedBox(width: width * 0.035),
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
                              width: width * 0.17,
                              height: height * 0.08,
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
                      )


                  ,]),

                  ]
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // ... (rest of the code remains unchanged)
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
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Image.asset(
          iconPath,
          height: height * 0.09,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        ),
      ),
    );
  }

  void _clearData() {
    _link.clear();
    controller.thumbnail.value = "";
    controller.downloadUrl.value = "";
    // _videoPlayerController?.dispose(); // Dispose of previous controller
    // _videoPlayerController = null;
    _isVideoInitialized = false;
  }
}
