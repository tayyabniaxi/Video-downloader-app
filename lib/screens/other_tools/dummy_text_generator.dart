import 'package:flutter/material.dart';

import '../../components/ToolsGenerateField.dart';
import '../../components/tool_appbar_text.dart';

class DummyTextGenerator extends StatefulWidget {
  const DummyTextGenerator({super.key});

  @override
  State<DummyTextGenerator> createState() => _DummyTextGeneratorState();
}

class _DummyTextGeneratorState extends State<DummyTextGenerator> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: ToolAppbarText(text: 'Dummy Text',),
          backgroundColor: Colors.white,
        ),
        body: ToolsGeneratorField(height: height, text: 'Dummy Text Generator', subtitle: 'Generate Dummy Text', buttonText: 'GENERATE TEXT')
    );
  }
}