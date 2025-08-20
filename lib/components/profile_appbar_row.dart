import 'package:flutter/material.dart';
import 'package:qaisar/screens/profile_section/premium.dart';
import '../assets/app_assets.dart';

class ProfileAppbarRow extends StatelessWidget {
  const ProfileAppbarRow({
    super.key,
    required this.width,
    required this.text,
  });

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        SizedBox(width: width * 0.31),
        GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Premium())),
            child: Image.asset(AppIcons.buttonPro)), // smaller size
      ],
    );
  }
}