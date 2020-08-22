import 'package:flutter/material.dart';
import 'package:ugao/constants.dart';
import 'package:ugao/settings/change_password_screen.dart';
import 'package:ugao/settings/settings_screen.dart';

import 'faq_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/background.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Profile Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            //change to app color
                            color: kPrimaryLightColor,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[Text("Profile details here")],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('General Settings'),
                  subtitle: Text('Change account details and logout'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SettingsScreen())),
                ),
                Divider(),
                ListTile(
                  title: Text('Security Settings'),
                  subtitle: Text('Change password'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ChangePasswordScreen())),
                ),
                Divider(),
                ListTile(
                  title: Text('Orders'),
                  subtitle: Text('Check order placed status'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => SettingsScreen())),
                ),
                Divider(),
                ListTile(
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: kPrimaryLightColor,
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Image.asset('assets/icons/faq.png'),
                  trailing:
                      Icon(Icons.chevron_right, color: kPrimaryLightColor),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqScreen())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
