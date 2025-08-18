import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  final Color color;
  final Text text;
  final Widget icon;

  const Button({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: BoxBorder.all(
          width: 1.0,
          color: Color(0xFF726DDE),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16,left: 8,right: 8,bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 20),
            text,
          ],
        ),
      ),
    );
  }
}
