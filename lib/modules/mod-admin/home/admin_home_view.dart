

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-admin/bookings/views/bookings_view.dart';
import '../tutor/views/search_tutor_view.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _currentIndex  = 0;

  List<Widget> tabs = [
    SearchTutorView(),
    BookingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        navItems: [
           BottomNavigationBarItem(
          title: Text(
            'Search Users',
            style: bodyText2,
          ),
          icon: Icon(Icons.people_outline),
        ),
        BottomNavigationBarItem(
          title: Text(
            'Bookings',
            style: bodyText2,
          ),
          icon: Icon(Icons.calendar_today),
        ),
        ],
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}