import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/custom_row.dart';
import 'package:qaisar/screens/other_tools/avatar_generator.dart';
import 'package:qaisar/screens/other_tools/dummy_text_generator.dart';
import 'package:qaisar/screens/other_tools/icon_generator.dart';
import 'package:qaisar/screens/other_tools/image_enhancer.dart';
import 'package:qaisar/screens/other_tools/url_enhancer.dart';
import 'package:qaisar/screens/other_tools/website_screenshot.dart';

import 'background_remover.dart';
import 'image_converter.dart';

class Tools extends StatefulWidget {
  const Tools({super.key});

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {

  List<Map<String,String>> tools = [
    {'name': 'Background Remover', 'icon': AppIcons.backgroundRemover},
    {'name': 'Image Converter', 'icon': AppIcons.imageConverter},
    {'name': 'Image Enhancer', 'icon': AppIcons.imageSizeEnhancer},
    {'name': 'Url Enhancer', 'icon': AppIcons.urlEnhancer},
    {'name': 'Icon Generator', 'icon': AppIcons.iconGenerator},
    {'name': 'Avatar Generator', 'icon': AppIcons.avatarGenerator},
    {'name': 'Dummy Text Generator', 'icon': AppIcons.dummyTextGenerator},
    {'name': 'Website Screenshot', 'icon': AppIcons.screenshot}
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: CustomRow(width: width * 0.4, text: 'Other Tools',logo: AppIcons.logo,)
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2
        ),
        itemCount: tools.length,
        itemBuilder: (context,index){
          final tool = tools[index];
          return GestureDetector(
            onTap: () {
              // Navigate based on tool name
              switch (tool['name']) {
                case 'Background Remover':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BackgroundRemover()),
                  );
                case 'Image Converter':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageConverter()),
                  );
                case 'Image Enhancer':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageEnhancer()),
                  );
                case 'Url Enhancer':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UrlEnhancer()),
                  );
                case 'Icon Generator':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IconGenerator()),
                  );
                case 'Avatar Generator':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AvatarGenerator()),
                  );
                case 'Dummy Text Generator':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DummyTextGenerator()),
                  );
                case 'Website Screenshot':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebsiteScreenshot()),
                  );
                default:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${tool['name']} page not implemented")),
                  );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5,top: 10,right: 5),
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(tools[index]['icon']!),
                      SizedBox(height: height * 0.02),
                      Text(tools[index]['name']!,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12),),
                    ],
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}