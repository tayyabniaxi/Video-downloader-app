import 'package:flutter/material.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';
import '../assets/app_assets.dart';
import '../screens/profile_section/premium.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.width,
    required this.text,
    this.logo, // 👈 optional logo
  });

  final double width;
  final String text;
  final String? logo; // 👈 nullable logo

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Show logo only if provided
        if (logo != null) Image.asset(logo!, height: 24, width: 24),

        if (logo != null) SizedBox(width: width * 0.05),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        //SizedBox(width: width),

        Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Premium()),
              ),
              child: Image.asset(AppIcons.buttonPro),
            ),
            SizedBox(width: 10),

            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileSection()),
              ),
              child: CircleAvatar(
                maxRadius: 17,
                backgroundImage: AssetImage(AppIcons.profileavatar),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
