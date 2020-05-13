import 'dart:io';

import 'package:flutter/material.dart';
import 'package:letutor/core/utils/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> navItems;

  const BottomNavBar({Key key, this.currentIndex, this.onTap, this.navItems}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: Platform.isAndroid ? kBottomNavigationBarHeight : 90,
    child: BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      currentIndex: currentIndex,
      iconSize: 16,
      selectedItemColor: Colors.blue,
      onTap: onTap,
      items: navItems ?? <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text(
            'Search Tutors',
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
    ),
  );
  }
}
