import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';

import 'package:letutor/modules/mod-user/appointments/views/appointments.dart';
import 'package:letutor/modules/mod-user/tutorSearch/views/search_tutors.dart';

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
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      body: tabs[_currentIndex],
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
