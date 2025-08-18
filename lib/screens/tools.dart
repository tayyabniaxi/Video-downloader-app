import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/custom_row.dart';

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
        backgroundColor: Colors.white,
        title: custom_row(width: width * 0.4, text: 'Other Tools',)
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2
        ),
        itemCount: tools.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.only(left: 5,top: 10,right: 5),
            child: Card(
              color: Colors.white,
              elevation: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(tools[index]['icon']!),
                  SizedBox(height: height * 0.02),
                  Text(tools[index]['name']!,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}