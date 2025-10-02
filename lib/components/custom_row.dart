import 'package:flutter/material.dart';
import 'package:qaisar/screens/profile_section/profile_section.dart';
import '../assets/app_assets.dart';

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
        if (logo != null)
          Image.asset(logo!, height: 24, width: 24),

        if (logo != null)
          SizedBox(width: width * 0.05),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(width: width),

        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileSection()),
          ),
          child: CircleAvatar(
            maxRadius: 17,
            backgroundImage: AssetImage(AppImages.profileImage),
          ),
        ),
      ],
    );
  }
}
