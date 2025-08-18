import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/screens/bottom_navigation_bar/my_bottom_navigation_bar.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';

import '../components/custom_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileSection())),
            child: custom_row(width: width * 0.2, text: 'Video Downloader',)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.03,),
            Image.asset(AppIcons.downloadIcon),
            SizedBox(height: height * 0.01,),
            Text('Download Any Video',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            SizedBox(height: height * 0.01,),
            Text('Download Video From Any Platform',style: TextStyle(fontSize: 14,color: Color(0xff8F8F8F),fontWeight: FontWeight.w500)),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Image.asset(AppIcons.arrowIcon),
                  ),
                  hintText: 'Past url here',
                  hintStyle: TextStyle(color: Color(0xFF000066),fontSize: 16,fontFamily: 'Montserrat',fontWeight: FontWeight.w500),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xffffffff)
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xff2684FF),
                      width: 3.0
                    )
                  )
                ),
              ),
            ),
            SizedBox(height: height * 0.02,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppIcons.facebook),
                  SizedBox(width: width * 0.05,),
                  Image.asset(AppIcons.youTube),
                  SizedBox(width: width * 0.05,),
                  Image.asset(AppIcons.instagram),
                  SizedBox(width: width * 0.05,),
                  Container(
                    width: width * 0.19,
                    height: height * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: GestureDetector(
                      onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyBottomNavigationBar(initialIndex: 1)));
                        },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward_ios_sharp),
                          Text('View all',style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w500,fontSize: 10),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              width: width * 0.9,
              height: height * 0.39,
              decoration: BoxDecoration(
                  color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}

