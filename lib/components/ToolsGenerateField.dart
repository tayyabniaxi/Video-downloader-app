import 'package:flutter/material.dart';
import 'button.dart';

class ToolsGeneratorField extends StatelessWidget {
  const ToolsGeneratorField({
    super.key,
    required this.height, required this.text, required this.subtitle, required this.buttonText,
  });

  final double height;
  final String text;
  final String subtitle;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(text,style: TextStyle(fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
          SizedBox(height: height * 0.01),
          Text(subtitle,style: TextStyle(fontSize: 14)),
          SizedBox(height: height * 0.02),
          Container(
            width: 328,
            height: 350,
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Color(0xff726DDE)
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.01),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    //controller: descriptionController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: "Enter description here...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Button(color: Color(0xff726DDE), text: Text(buttonText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500))),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          )
        ],
      ),
    );
  }
}