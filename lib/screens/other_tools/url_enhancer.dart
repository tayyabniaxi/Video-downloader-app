import 'package:flutter/material.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/components/custom_text_field.dart';
import 'package:qaisar/components/tool_appbar_text.dart';

class UrlEnhancer extends StatefulWidget {
  const UrlEnhancer({super.key});

  @override
  State<UrlEnhancer> createState() => _UrlEnhancerState();
}

class _UrlEnhancerState extends State<UrlEnhancer> {
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
        child: Column(
          children: [
            Text('Url Enhancer',style: TextStyle(fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
            SizedBox(height: height * 0.01),
            Text('Customize your url size...',style: TextStyle(fontSize: 14)),
            SizedBox(height: height * 0.02),
            Container(
              width: width * 1,
              height: height * 0.25,
              decoration: BoxDecoration(
                color: Color(0xFFF5F2FF),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.02),
                  Text('Shorten a long url',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold)),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: CustomTextField(hintText: 'Enter url here'),
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Button(color: Color(0xff726DDE), text: Text('Shorten URL',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500))),
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}