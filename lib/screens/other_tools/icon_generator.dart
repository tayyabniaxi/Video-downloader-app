import 'package:flutter/material.dart';
import 'package:qaisar/components/ToolsGenerateField.dart';

import '../../components/button.dart';
import '../../components/custom_text_field.dart';
import '../../components/tool_appbar_text.dart';

class IconGenerator extends StatefulWidget {
  const IconGenerator({super.key});

  @override
  State<IconGenerator> createState() => _IconGeneratorState();
}

class _IconGeneratorState extends State<IconGenerator> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Icon Generator',),
        backgroundColor: Colors.white,
      ),
      body: Center(child: ToolsGeneratorField(height: height, text: 'Icon Generator', subtitle: 'Generate stunning Icons in seconds...', buttonText: 'GENERATE ICON'))
    );
  }
}