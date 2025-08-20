import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {

  const CustomProfileCard({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.lastText
  });

  final String text;
  final String lastText;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF6F6F6),
      child: SizedBox(
        height: height * 0.07,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(text),
              SizedBox(width: width * 0.43,),
              Text(lastText)
            ],
          ),
        ),
      ),
    );
  }
}