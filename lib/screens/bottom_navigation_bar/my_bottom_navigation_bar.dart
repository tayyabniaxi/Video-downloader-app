import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaisar/Screens/home_screen.dart';
import 'package:qaisar/screens/plateform.dart';
import 'package:qaisar/screens/tools.dart';
import '../../assets/app_assets.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int initialIndex;
  const MyBottomNavigationBar({super.key,this.initialIndex = 0});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Screens for each tab (replace with your real screens)
  final List<Widget> _pages = [
    const HomeScreen(),
    const PlateForm(),
    const Tools(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
DateTime? _lastPressedAt;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black87,
            ),
          );
          return;
        }

        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: _pages[_selectedIndex], // show the selected page
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory, //  remove splash
            highlightColor: Colors.transparent,    //  remove highlight
            splashColor: Colors.transparent,       //  remove splash color
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: const Color(0xff726DDE), // Purple color for selected item
            unselectedItemColor: Colors.grey, // Grey for unselected items
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.homeIcon,
                  color: _selectedIndex == 0 ? const Color(0xff726DDE) : Colors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.plateFormIcon,
                  color: _selectedIndex == 1 ? const Color(0xff726DDE) : Colors.grey,
                ),
                label: 'Platform',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppIcons.tools,
                  color: _selectedIndex == 2 ? const Color(0xff726DDE) : Colors.grey,
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