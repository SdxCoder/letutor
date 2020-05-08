import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/views/book_course_view.dart';
import 'package:stacked/stacked.dart';

import '../view_model/searchTutor_view_model.dart';
import 'tutor_details.dart';

class SearchTutorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SearchTutorViewModel(),
      builder: (context, model, child) => SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Find Tutors",
                    style: TextStyle(
                        color: Colors.black87.withOpacity(0.8),
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildLevelOptions(model),
                  _buildCourseOptions(model),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Tutors",
                    style: TextStyle(
                        color: Colors.black87.withOpacity(0.8),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildTutors(context, model)
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTutors(BuildContext context, SearchTutorViewModel model) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: (model.tutorsList ?? []).length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: TutorTile(
              tutor: model.tutorsList[index],
              onTapBook: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookCourseView(),
                        settings: RouteSettings(name: Routes.bookCourse)));
              },
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TutorProfileView(
                              tutor: model.tutorsList[index],
                            ),
                        settings: RouteSettings(name: Routes.tutorProfile)));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseOptions(SearchTutorViewModel model) {
    var courses = model.courses;
    return OptionsHorizontalScroll(
      options: ListView.builder(
        itemCount: (courses ?? []).length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryTile(
            id: courses[index].id,
            category: courses[index].name,
            isSelected: model.selectedCourse == courses[index].id,
            onTap: (category) => model.setSelectedCourse(category),
          );
        },
      ),
      title: "Courses",
    );
  }

  Widget _buildLevelOptions(SearchTutorViewModel model) {
    var levels = model.levels;
    return OptionsHorizontalScroll(
      options: ListView.builder(
        itemCount: (levels ?? []).length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryTile(
            id: levels[index].id,
            category: levels[index].name,
            isSelected: model.selectedLevel == levels[index].id,
            onTap: (category) => model.setSelectedLevel(category),
          );
        },
      ),
      title: "Academic Level",
    );
  }
}

// child: StreamBuilder(
//   stream: model.courses,
//   builder: (context, snapshot) {
//     if (snapshot.hasError)
//       return Text('Error: ${snapshot.error}');
//     switch (snapshot.connectionState) {
//       case ConnectionState.none:
//         return Text('Select lot');
//       case ConnectionState.waiting:
//         return Text('Awaiting bids...');
//       case ConnectionState.active:
//         return OptionsHorizontalScroll(
//           collection: snapshot.data ?? [],
//           title: "Courses",
//         );
//       case ConnectionState.done:
//         return Text('\$${snapshot.data} (closed)');
//     }
//     return null;
//   },
// ),
