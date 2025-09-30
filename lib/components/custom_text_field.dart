import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? url;

  const CustomTextField({
    super.key,
    required this.hintText,
     this.url
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: url,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xff9999A2),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.white,
            )
        ),
      ),
    );
  }
}