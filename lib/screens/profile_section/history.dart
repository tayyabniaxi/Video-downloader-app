import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/button.dart';
import 'package:qaisar/components/profile_appbar_row.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  //  Dummy history data
  List<Map<String, dynamic>> history = [
    {
      'icon': AppIcons.historyPicture,
      'name': 'Video name will be here',
      'PlateForm': 'YouTube',
      'Date': '01/01/2025',
      'File Url': 'www.fileurl.com...',
    },
    {
      'icon': AppIcons.historyPicture,
      'name': 'Video name will be here',
      'PlateForm': 'YouTube',
      'Date': '01/01/2025',
      'File Url': 'www.fileurl.com...',
    },
  ];

  bool isPro = false; //  change this for testing (true = show history, false = upgrade screen)

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: ProfileAppbarRow(width: width, text: 'History'),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(width, height),
    );
  }

  //  main body logic
  Widget _buildBody(double width, double height) {
    if (!isPro) {
      //  NOT PRO USER → show Upgrade screen
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppImages.noHistoryImage)
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                  color:  Color(0xff726DDE),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:  [
                  Image.asset(AppIcons.proIcon,width: 30,height: 30,),
                  SizedBox(width: 6),
                  Text(
                    'History no found',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (history.isEmpty) {
      //  NO DATA → show empty state
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(""
             // AppImages.noHistoryImage, // faded history icon
            ),
            const SizedBox(height: 15),
            const Text(
              "No History Found",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    //  SHOW HISTORY LIST
    return ListView.builder(
      itemCount: history.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(history[index]['icon']),
                  const SizedBox(height: 8),

                  _buildRow("Name:", history[index]['name']),
                  _buildRow("Platform:", history[index]['PlateForm']),
                  _buildRow("Date:", history[index]['Date']),
                  _buildRow("File Url:", history[index]['File Url'],
                      color: const Color(0xffF5AF3E)),

                  const SizedBox(height: 15),
                  Button(
                    color: const Color(0xff726DDE),
                    text: const Text(
                      'Preview',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //  helper to align fields
  Widget _buildRow(String label, String value, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80, // fixed label width
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14, color: color),
            ),
          ),
        ],
      ),
    );
  }
}