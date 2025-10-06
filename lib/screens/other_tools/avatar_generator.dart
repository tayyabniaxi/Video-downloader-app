import 'package:flutter/material.dart';
import '../../components/ToolsGenerateField.dart';
import '../../components/button.dart';
import '../../components/tool_appbar_text.dart';

class AvatarGenerator extends StatefulWidget {
  const AvatarGenerator({super.key});

  @override
  State<AvatarGenerator> createState() => _AvatarGeneratorState();
}

class _AvatarGeneratorState extends State<AvatarGenerator> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Avatar Generator',),
        backgroundColor: Colors.white,
      ),
      body: Center(child: ToolsGeneratorField(height: height, text: 'Avatar Generator', subtitle: 'Generate Your Perfect Avatar', buttonText: 'GENERATE AVATAR')),
    );
  }
}