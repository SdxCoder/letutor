
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

import 'package:letutor/modules/mod-user/appointments/views/appointments.dart';
import 'package:letutor/modules/mod-user/tutorSearch/views/search_tutors.dart';
import 'package:letutor/modules/mod-user/userprofile/views/user_profile_view.dart';


class UserHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserHomeState();
}

class UserHomeState extends State<UserHome> {
  int _currentIndex = 0;
  List<Widget> tabs = [
     AppointmentsView(),
     SearchTutorsView()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    final currentScreen = tabs[_currentIndex];
    return  Scaffold(
        appBar: _buildAppBar(context),
        bottomNavigationBar: _buildBottomNavBar(),
        backgroundColor: Color(0xFFF3F6FE),
        body: currentScreen,
    );
  }

  Widget _buildBottomNavBar() {
    return SizedBox(
      height: 90.0,
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Search Tutors'),
            icon: Icon(Icons.people_outline),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfileView()));
            },
            child: CircleAvatar(
                backgroundImage: NetworkImage(Modular.get<AuthService>().currentUser.user.photoUrl ?? imageUrl,),
              ),
          ),
        )
      ],
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }
}
