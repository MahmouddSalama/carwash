import 'package:carwash/consts/const_colors.dart';
import 'package:carwash/screens/body/bodys/home_screen.dart';
import 'package:carwash/screens/body/bodys/notification_screen.dart';
import 'package:carwash/screens/body/bodys/setting_xscreen.dart';
import 'package:flutter/material.dart';
class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex=1;
  List screens=[
    NotificationScreen(),
    HomeScreen(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: KbtnColor,
        elevation: 0,
        selectedItemColor: KselectColor,
        unselectedItemColor: Kwhite,
       currentIndex: _currentIndex,
       onTap: (value){
          setState(() {
            _currentIndex=value;
          });
       },
       type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.notifications,size: 30,) ,label: ''),
          BottomNavigationBarItem(icon:Icon(Icons.home,size: 30,) ,label: ''),
          BottomNavigationBarItem(icon:Icon(Icons.settings,size: 30,) ,label: ''),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}
