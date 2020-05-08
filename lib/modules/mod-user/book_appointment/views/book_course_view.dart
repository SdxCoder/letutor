import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/view_models/book_course_view_model.dart';
import 'package:stacked/stacked.dart';

import 'tutor_availability_view.dart';

class BookCourseView extends StatefulWidget {
  @override
  BookCourseViewState createState() => BookCourseViewState();
}

class BookCourseViewState extends State<BookCourseView> {
  final _formKey = GlobalKey<FormState>();
  
  ScrollController scrollCtrlTopics = new ScrollController();
  final topicTextController = TextEditingController();
  static const double SPACING = 40.0;

  @override
  void dispose() {
    topicTextController.dispose();
    scrollCtrlTopics.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BookCourseViewModel(),
      builder: (context, BookCourseViewModel model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0),
                child: Text(
                  "Book Course",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: SPACING),
                      dropdownField(
                        title: 'COURSE LEVEL',
                        value: model.selectedlevel,
                        collection: model.modalities,
                        onChanged: (String value) {
                          model.selectLevel(value);
                        },
                      ),
                      SizedBox(height: SPACING),
                      dropdownField(
                        title: 'COURSES',
                        value: model.selectedCourse,
                        collection: model.courses,
                        onChanged: (String value) {
                          model.selectCourse(value);
                        },
                      ),
                      SizedBox(height: SPACING),
                      textField(
                        title: 'TOPIC',
                        model: model,
                      ),
                      SizedBox(height: SPACING),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Color(0xFF838383),
                thickness: 0.5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 12.0, top: 12.0, left: 20.0),
                    child: Text(
                      "Added topics",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    height: model.topics.length > 0 ? 210 : 0,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: scrollCtrlTopics,
                        itemCount: model.topics.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TopicCard(
                            collection: model.topics,
                            index: index,
                            onPressed: () {
                              model.removeTopics(index);
                            },
                          );
                        }),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
                    child: RaisedButton(
                      disabledColor: buttonColor.withOpacity(0.5),
                      onPressed: (model.selectedCourse == null || model.selectedlevel == null || model.topics.isEmpty ) ? null :() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TutorAvailabilityView(),
                                settings: RouteSettings(
                                  name: Routes.tutorAvailability
                                )
                                ));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Color(0xFF21BFBD),
                      child:
                          Text('Next', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownField(
      {String title,
      String value,
      List<String> collection,
      Function onChanged}) {
    return DropdownButtonFormField(
      value: value,
      style: TextStyle(
        color: Color(0xFF010101),
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: title,
      ),
      items: collection.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget textField({String title, BookCourseViewModel model}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: TextFormField(
            controller: topicTextController,
            style: TextStyle(
              color: Color(0xFF010101),
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              // hintText: 'Are you studying in university or high school?',
              labelText: title,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2db5c1)),
              ),
            ),
          ),
        ),
        Flexible(
          child: OutlineButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: Color(0xFF21BFBD),
            child: Text(
              'Add',
              style: TextStyle(color: Color(0xFF21BFBD)),
            ),
            borderSide: BorderSide(color: Color(0xFF21BFBD)),
            onPressed: () {
              model.addTopics(topicTextController.text);
              topicTextController.clear();
              scrollCtrlTopics.animateTo(
                scrollCtrlTopics.position.maxScrollExtent,
                curve: Curves.linear,
                duration: Duration(milliseconds: 300),
              );
            },
          ),
        )
      ],
    );
  }
}
