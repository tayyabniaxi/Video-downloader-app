import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/components/custom_text_field.dart';
import 'package:qaisar/components/tool_appbar_text.dart';
import 'package:qaisar/screens/other_tools/url_shortner_services.dart';

import '../../image_convert_service.dart';

class UrlEnhancer extends StatefulWidget {
  const UrlEnhancer({super.key});

  @override
  State<UrlEnhancer> createState() => _UrlEnhancerState();
}

class _UrlEnhancerState extends State<UrlEnhancer> {
  // final TinyUrlService _urlshortern = TinyUrlService();
  final TextEditingController longUrl = TextEditingController();
  final UrlShortenerController controller = Get.put(UrlShortenerController());
  final TextEditingController urlInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Url Enhancer'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Url Enhancer',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text('Customize your url size...', style: TextStyle(fontSize: 14)),
              SizedBox(height: height * 0.02),
              Container(
                width: width * 1,
                height: height * 0.49,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.02),
                    Text(
                      'Shorten a long url',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.02),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CustomTextField(
                        url: urlInputController,
                        hintText: 'Enter url here',
                      ),
                    ),

                Obx(
                        () => controller.shortUrl.value.isNotEmpty?
                  Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      Text(
                        'Tiny url',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Obx( ()=>controller.shortUrl.value.isNotEmpty?
                        TextField(
                          controller:  controller.shortUrlController, //,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "",
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff9999A2),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )
                            ),
                          ),
                        ): const SizedBox.shrink(),
                        ),
                      ),

                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Obx(
                              () => controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                            onTap: () {
                              controller.copyUrl();
                            },
                            child: Button(
                              color: Color(0xff726DDE),
                              text: Text(
                                'Copy Url',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):SizedBox(),
                ),
                    SizedBox(height: height * 0.02),

                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Obx(
                        () => controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  controller.shortenUrl(
                                    urlInputController.text.trim(),
                                  );
                                },
                                child: Button(
                                  color: Color(0xff726DDE),
                                  text: Text(
                                    'Shorten URL',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
              // Obx(
              //   () => controller.shortUrl.value.isNotEmpty
              //       ? Row(
              //           children: [
              //             Expanded(
              //               child: SelectableText(
              //                 controller.shortUrl.value,
              //                 style: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //             ),
              //             IconButton(
              //               icon: const Icon(Icons.copy),
              //               onPressed: controller.copyUrl,
              //             ),
              //           ],
              //         )
              //       : const SizedBox.shrink(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
