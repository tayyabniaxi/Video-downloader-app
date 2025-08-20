import 'package:flutter/material.dart';
import 'package:qaisar/components/profile_appbar_row.dart';
import 'package:qaisar/screens/profile_section/account_settings.dart';
import 'package:qaisar/screens/profile_section/history.dart';
import 'package:qaisar/screens/profile_section/premium.dart';
import 'package:qaisar/screens/splash_screen.dart';
import '../../assets/app_assets.dart';
import '../../components/custom_list_tile.dart';

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
        title: ProfileAppbarRow(width: width, text: 'Settings',),
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
              child: CustomListTile(
                icon: AppIcons.accountSettings,
                title: 'Account Settings',
                subtitle: 'Edit your profile',
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Premium())),
              child: CustomListTile(
                icon: AppIcons.proIcon,
                title: 'Premium',
                subtitle: 'Explore premium packages',
                iconSize: 27, // smaller icon for Pro
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => History())),
              child: CustomListTile(
                icon: AppIcons.history,
                title: 'History',
                subtitle: 'Check your activity',
              ),
            ),

            SizedBox(height: height * 0.008),
            
            GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('Cancel')),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SplashScreen()));
                    }, child: Text('Logout'))
                  ],
                ));
              },
              // onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SplashScreen()), (route) => false),// remove everything
              child: Card(
                color: Colors.white,
                elevation: 1,
                child: ListTile(
                  leading: Image.asset(AppIcons.logoutIcon),
                  title: Text('Logout',style: TextStyle(color: Colors.red,fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}