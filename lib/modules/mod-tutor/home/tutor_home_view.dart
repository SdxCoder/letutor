
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-tutor/courses/view/add_course_view.dart';


class TutorHome extends StatefulWidget {
  @override
  _TutorHomeState createState() => _TutorHomeState();
}

class _TutorHomeState extends State<TutorHome> {
  int _currentIndex  = 0;

  List<Widget> tabs = [
    AddCourseView(),
    Text("akask")
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        navItems: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text(
            'Add Courses',
            style: bodyText2,
          ),
          icon: Icon(Icons.calendar_today),
        ),
        BottomNavigationBarItem(
          title: Text(
            'History',
            style: bodyText2,
          ),
          icon: Icon(Icons.history),
        ),
      ],
      ),
    );
  }
}