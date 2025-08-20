import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double iconSize;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize = 28, // default size for icons
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8), // small space between cards

        elevation: 1,
        child: ListTile(
          leading: Image.asset(icon, height: iconSize, width: iconSize),
          title: Text(
            title,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          subtitle: subtitle.isNotEmpty
              ? Text(
            subtitle,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 10),
          )
              : null,
        ),
      ),
    );
  }
}