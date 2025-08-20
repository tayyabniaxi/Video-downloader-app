import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaisar/screens/plateform.dart';
import 'package:qaisar/screens/other_tools/tools.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/screens/home_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int initialIndex;
  const MyBottomNavigationBar({super.key, this.initialIndex = 0});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  // Hold selected platform here, so we can pass it to HomeScreen
  Map<String, dynamic>? _selectedPlatform;

  DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // When platform is selected inside PlateForm
  void _onPlatformSelected(Map<String, dynamic> platform) {
    debugPrint("Platform selected: $platform");
    setState(() {
      _selectedPlatform = platform;
      _selectedIndex = 0; // Jump back to Home tab
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(selectedPlatform: _selectedPlatform),
      PlateForm(onPlatformSelected: _onPlatformSelected),
      const Tools(),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black87,
            ),
          );
          return;
        }
        await SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: IndexedStack(   //  Keeps state of each page
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: const Color(0xff726DDE),
            unselectedItemColor: Colors.grey,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.homeIcon,
                  color: _selectedIndex == 0
                      ? const Color(0xff726DDE)
                      : Colors.grey,
                  height: 24,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.plateFormIcon,
                  color: _selectedIndex == 1
                      ? const Color(0xff726DDE)
                      : Colors.grey,
                  height: 24,
                ),
                label: 'Platform',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.tools,
                  color: _selectedIndex == 2
                      ? const Color(0xff726DDE)
                      : Colors.grey,
                  height: 24,
                ),
                label: 'Other Tools',
              ),
            ],
          ),
        ),
      ),
    );
  }
}