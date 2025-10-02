import 'package:flutter/cupertino.dart';
import '../assets/app_assets.dart';

class CustomPremium extends StatelessWidget {
  const CustomPremium({super.key, required this.width, required this.text});

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(AppIcons.tick),
        SizedBox(width: width * 0.04),
        Text(
          text,
          style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Color(0xff646464)),
        )
      ],
    );
  }
}