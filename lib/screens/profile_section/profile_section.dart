import 'package:flutter/material.dart';
import 'package:qaisar/screens/profile_section/account_settings.dart';
import 'package:qaisar/screens/profile_section/premium.dart';
import '../../assets/app_assets.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: profile_appbar_row(width: width, text: 'Settings',),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Column(
          children: [
            CircleAvatar(
                maxRadius: 35,
                backgroundImage: AssetImage(AppImages.profileImage)),
            SizedBox(height: height * 0.02),
            Text(
              'Mark Jonson',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Text(
              'jonson077@gmail.com',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            SizedBox(height: height * 0.025),

            // Equal cards with less spacing
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountSettings())),
              child: customListTile(
                icon: AppIcons.accountSettings,
                title: 'Account Settings',
                subtitle: 'Edit your profile',
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Premium())),
              child: customListTile(
                icon: AppIcons.proIcon,
                title: 'Premium',
                subtitle: 'Explore premium packages',
                iconSize: 27, // smaller icon for Pro
              ),
            ),
            customListTile(
              icon: AppIcons.history,
              title: 'History',
              subtitle: 'Check your activity',
            ),

            SizedBox(height: height * 0.008),
            
            Card(
              color: Colors.white,
              elevation: 1,
              child: ListTile(
                leading: Image.asset(AppIcons.logoutIcon),
                title: Text('Logout',style: TextStyle(color: Colors.red,fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class profile_appbar_row extends StatelessWidget {
  const profile_appbar_row({
    super.key,
    required this.width,
    required this.text,
  });

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
        SizedBox(width: width * 0.31),
        Image.asset(AppIcons.buttonPro), // smaller size
      ],
    );
  }
}

class customListTile extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final double iconSize;

  const customListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.iconSize = 28, // default size for icons
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0,right: 5),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8), // small space between cards

        elevation: 1,
        child: ListTile(
          leading: Image.asset(icon, height: iconSize, width: iconSize),
          title: Text(
            title,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          subtitle: subtitle.isNotEmpty
              ? Text(
            subtitle,
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: 10),
          )
              : null,
        ),
      ),
    );
  }
}