import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/app_assets.dart';
import '../screens/profile_section/premium.dart';

class ToolAppbarText extends StatelessWidget {
  final String text;
  const ToolAppbarText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        //  SizedBox(width: width * 0.24),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Premium()),
          ),
          child: Image.asset(AppIcons.buttonPro),
        ),
      ],
    );
  }
}
