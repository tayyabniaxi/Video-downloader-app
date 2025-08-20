import 'package:flutter/cupertino.dart';
import '../assets/app_assets.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 1,
      height: height * 0.1,
      decoration: BoxDecoration(
          color: Color(0xFFF5F2FF),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppIcons.uploadIcon),
          SizedBox(width: width * 0.02),
          Text('Upload Your Image',style: TextStyle(fontSize: 14,color: Color(0xff9591E6)),)
        ],
      ),
    );
  }
}