import 'package:flutter/material.dart';
import '../assets/app_assets.dart';

class custom_row extends StatelessWidget {
  const custom_row({
    super.key,
    required this.width,
    required this.text
  });

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppIcons.logo),
        SizedBox(width: width * 0.05,),
        Expanded(child: Text(text,style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis)),
        SizedBox(width: width),
        CircleAvatar(maxRadius:17,backgroundImage: AssetImage(AppImages.profileImage))
      ],
    );
  }
}