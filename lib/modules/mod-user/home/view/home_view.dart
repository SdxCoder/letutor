import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

import 'package:letutor/modules/mod-user/appointments/views/appointments.dart';
import 'package:letutor/modules/mod-user/tutorSearch/views/search_tutors.dart';
import 'package:letutor/modules/mod-user/userprofile/views/user_profile_view.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

class UserHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserHomeState();
}

class UserHomeState extends State<UserHome> {
  int _currentIndex = 0;
  List<Widget> tabs = [
    SearchTutorsView(),
    AppointmentsView(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    final currentScreen = tabs[_currentIndex];
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(),
      backgroundColor: Color(0xFFF3F6FE),
      body: currentScreen,
    );
  }

  Widget _buildBottomNavBar() {
    return SizedBox(
      height: Platform.isAndroid ? kBottomNavigationBarHeight : 90,
      child: 
      // RollingNavBar.iconData(
      //   animationCurve:
      //       Curves.linear, // `linear` is recommended for `shrinkOutIn`
      //   animationType: AnimationType.shrinkOutIn,
      //   baseAnimationSpeed: 500,
      //   activeIndex: _currentIndex,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //   },
      //  iconSize: ScreenUtil().setSp(30),
      //   iconData: <IconData>[
      //     Icons.people_outline,
      //     Icons.calendar_today,
      //   ],
      //   iconText: <Widget>[
      //     Text('Search Tutor',
      //         style: TextStyle(color: lightColor, fontSize: ScreenUtil().setSp(30))),
      //     Text('Bookings', style: TextStyle(color: lightColor, fontSize: ScreenUtil().setSp(30))),
      //   ],
      //   indicatorColors: <Color>[
      //     Colors.blue,
      //     Colors.blue,
      //   ],
      // ),
      BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _currentIndex,
        iconSize: 16,
        
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Search Tutors', style: bodyText2,),
            icon: Icon(Icons.people_outline),
          ),
          BottomNavigationBarItem(
            title: Text('Bookings',  style: bodyText2,),
            icon: Icon(Icons.calendar_today),
          ),

        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
