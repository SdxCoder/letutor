import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/view_models/book_course_view_model.dart';
import 'package:stacked/stacked.dart';

import 'tutor_availability_view.dart';

class BookCourseView extends StatefulWidget {
  final Tutor tutor;

  const BookCourseView({Key key, this.tutor}) : super(key: key);
  @override
  BookCourseViewState createState() => BookCourseViewState();
}

class BookCourseViewState extends State<BookCourseView> {
  final _formKey = GlobalKey<FormState>();
  ScrollController scrollCtrlTopics = new ScrollController();
  final _topicTextController = TextEditingController();
  static const double SPACING = 40.0;

  @override
  void dispose() {
    _topicTextController.dispose();
    scrollCtrlTopics.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BookCourseViewModel(),
      builder: (context, BookCourseViewModel model, child) => Scaffold(
        appBar: buildAppBar(
            title: Text("Book Course",
                style: subtitle1.copyWith(color: Colors.black)),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true),
        floatingActionButton: raisedButton(
            btnText: "Next",
            onPressed: (model.selectedCourse == null ||
                    model.selectedLesson == null ||
                    model.topics.isEmpty)
                ? null
                : () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TutorAvailabilityView(tutor: widget.tutor,),
                            settings:
                                RouteSettings(name: Routes.tutorAvailability)));
                  }),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      dropdownField(
                        title: 'Select Level',
                        value: model.selectedLesson,
                        collection: widget.tutor.lessons,
                        onChanged: (value) {
                          model.selectLesson(value);
                        },
                      ),
                      SizedBox(height: 16),
                      dropdownField(
                        title: 'Select Course',
                        value: model.selectedCourse,
                        collection: model.selectedLesson?.courses ?? [],
                        onChanged: (value) {
                          model.selectCourse(value);
                        },
                      ),
                      SizedBox(height: 16),
                      (model.selectedCourse != null)
                          ? textField(
                              title: 'Add Topic',
                              controller: _topicTextController,
                              onFieldSubmit: (String val) {
                                model.addTopics(val.trim().toUpperCase());
                                _topicTextController.clear();
                              },
                              iconData: Icons.add,
                              onTapIcon: () {
                                model.addTopics(_topicTextController.text
                                    .trim()
                                    .toUpperCase());
                                _topicTextController.clear();
                              })
                          : Offstage(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Center(
                  child: Text("Swipe to remove",
                      style: bodyText2.copyWith(
                        color: lightBlackColor,
                      )),
                ),
                (model.topics.isEmpty)
                    ? Offstage()
                    : Expanded(
                        child: Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              controller: scrollCtrlTopics,
                              itemCount: model.topics.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (d) {
                                    model.removeTopics(index);
                                  },
                                  child: TopicCard(
                                    collection: model.topics,
                                    index: index,
                                  ),
                                );
                              }),
                        ),
                      ),
                  SizedBox(height:16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget textField({String title, BookCourseViewModel model}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Flexible(
  //         flex: 2,
  //         child: TextFormField(
  //           controller: topicTextController,
  //           style: TextStyle(
  //             color: Color(0xFF010101),
  //             fontSize: 17,
  //             fontWeight: FontWeight.w700,
  //           ),
  //           decoration: InputDecoration(
  //             // hintText: 'Are you studying in university or high school?',
  //             labelText: title,
  //             focusedBorder: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Color(0xFF2db5c1)),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Flexible(
  //         child: OutlineButton(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  //           color: Color(0xFF21BFBD),
  //           child: Text(
  //             'Add',
  //             style: TextStyle(color: Color(0xFF21BFBD)),
  //           ),
  //           borderSide: BorderSide(color: Color(0xFF21BFBD)),
  //           onPressed: () {
  //             model.addTopics(topicTextController.text);
  //             topicTextController.clear();
  //             scrollCtrlTopics.animateTo(
  //               scrollCtrlTopics.position.maxScrollExtent,
  //               curve: Curves.linear,
  //               duration: Duration(milliseconds: 300),
  //             );
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }
}
