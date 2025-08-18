import 'package:flutter/material.dart';
import '../assets/app_assets.dart';

class PlateForm extends StatefulWidget {
  const PlateForm({super.key});

  @override
  State<PlateForm> createState() => _PlateFormState();
}

class _PlateFormState extends State<PlateForm> {
  final List<Map<String,String>> plateForms = [
    {'name': 'Facebook', 'icon':AppIcons.facebookIcon,},
    {'name': 'Instagram', 'icon': AppIcons.instagram,},
    {'name': 'Youtube' , 'icon': AppIcons.youTube,},
    {'name': 'Twitter', 'icon': AppIcons.twitter,},
    {'name': 'Linkedin', 'icon': AppIcons.linkedin,},
    {'name': 'Dailymotion', 'icon': AppIcons.dailyMotion,},
    {'name': 'Reddit', 'icon': AppIcons.reddit,},
    {'name': 'Vimeo', 'icon': AppIcons.vimeo,},
    {'name': 'Twitch', 'icon': AppIcons.twitch,},
    {'name': 'Periscope', 'icon': AppIcons.periscope,},
    {'name': 'Tiktok', 'icon': AppIcons.tikTok,},
    {'name': 'Coursera', 'icon': AppIcons.coursera,},
    {'name': 'Udemy', 'icon': AppIcons.udemy,},
    {'name': 'BBC IPlayer', 'icon': AppIcons.bbcIcon,},
    {'name': 'CNN', 'icon': AppIcons.cnnIcon,},
    {'name': 'ESPN', 'icon': AppIcons.espnIcon,},
    {'name': 'Arte', 'icon': AppIcons.arte,},
    {'name': 'Hot Star', 'icon': AppIcons.hotStar,},
    {'name': 'Zee5', 'icon': AppIcons.zee5,},
    {'name': 'SonyLiv', 'icon': AppIcons.sonyLiv}
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text('Select Platform',style: TextStyle(fontSize: 16,fontFamily: 'Montserrat',fontWeight: FontWeight.w600)),
            SizedBox(width: width * 0.5),
            CircleAvatar(maxRadius:17,backgroundImage: AssetImage(AppImages.profileImage),)
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1
        ),
        itemCount: plateForms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 5,top: 10,right: 5),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(plateForms[index]['icon']!),
                  SizedBox(height: height * 0.01,),
                  Text(plateForms[index]['name']!),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}