import 'package:flutter/cupertino.dart';

class ToolAppbarText extends StatelessWidget {
  final String text;
  const ToolAppbarText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold,fontSize: 14));
  }
}