import 'package:flutter/material.dart';

import 'package:letutor/core/core.dart';

import 'package:letutor/modules/mod-user/book_appointment/views/book_course_view.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stacked/stacked.dart';

import '../view_model/searchTutor_view_model.dart';
import 'tutor_details.dart';

class SearchTutorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchTutorViewModel>.reactive(
      viewModelBuilder: () => SearchTutorViewModel(),
      onModelReady: (model) async {
        model.listenToTutors();
        model.setBusy(true);
        await model.fetchCourses();
        await model.fetchLevels();
        model.setBusy(false);
      },
      builder: (context, model, child) => Scaffold(
        body: ResponsiveBuilder(
          builder: (context, sizingInfo) => Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: (model.isBusy)
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        SizedBox(height: 8),
                        TopNavBar(),
                        SizedBox(height: 16),
                        _buildLevelOptions(model),
                        SizedBox(height: 16),
                        _buildCourseOptions(model),
                        SizedBox(height: 32),
                        Text(
                          "Tutors",
                          style:
                              headline6.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Expanded(child: _buildTutors(context, model)),
                        SizedBox(
                          height: 32.0,
                        ),
                      ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTutors(BuildContext context, SearchTutorViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: model.tempList.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final tutor = model.tempList.elementAt(index);
        print(tutor.name);
        return TutorTile(
          tutor: tutor,
          onTapBook: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookCourseView(tutor: tutor),
                    settings: RouteSettings(name: Routes.bookCourse)));
          },
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TutorProfileView(
                          tutor: tutor,
                        ),
                    settings: RouteSettings(name: Routes.tutorProfile)));
          },
        );
      },
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
          return CapsuleTile(
            id: courses[index].id,
            title: courses[index].name,
            isSelected: model.selectedCourse == courses[index].id,
            onTap: (id) {
              print(id);
              model.setSelectedCourse(id);
              model.searchResults();
            },
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
          return CapsuleTile(
            id: levels[index].id,
            title: levels[index].name,
            isSelected: model.selectedLevel == levels[index].id,
            onTap: (id) {
              print(id);
              model.setSelectedLevel(id);
              model.searchResults();
            },
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
