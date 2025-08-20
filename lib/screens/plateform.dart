import 'package:flutter/material.dart';
import '../components/custom_row.dart';
import '../data/plateform_data.dart';

class PlateForm extends StatelessWidget {
  final Function(Map<String, dynamic>)? onPlatformSelected;

  const PlateForm({super.key, this.onPlatformSelected});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomRow(width: width * 0.4, text: 'Select Platform'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: PlateFormData.plateForms.length,
        itemBuilder: (context, index) {
          final platform = PlateFormData.plateForms[index];
          return GestureDetector(
            onTap: () {
              final String name = platform["name"];
              final Map<String, dynamic> selectedPlatform = {
                "name": name,
                "icon": platform["icon"],
                "buttonColor": platform["buttonColor"],
                "title": "$name Video Downloader",
                "subtitle": "Download Video From $name",
              };

              if (Navigator.canPop(context)) {
                // case 1: View All
                Navigator.pop(context, selectedPlatform);
              } else {
                // case 2: BottomNav tab
                onPlatformSelected?.call(selectedPlatform);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(platform['icon']),
                    SizedBox(height: height * 0.01),
                    Text(platform['name']),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}