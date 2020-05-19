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
        appBar: buildAppBar(
          title: Text("Book Course", style:subtitle1.copyWith(color:Colors.black)),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: SPACING),
                      dropdownField(
                        title: 'Select Level',
                        value: model.selectedLesson,
                        collection: widget.tutor.lessons,
                        onChanged: ( value) {
                          model.selectLesson(value);
                        },
                      ),
                      SizedBox(height: SPACING),
                      (model.selectedLesson != null ) ? dropdownField(
                        title: 'Select Course',
                        value: model.selectedCourse,
                        collection: model.selectedLesson.courses,
                        onChanged: (value) {
                          model.selectCourse(value);
                        },
                      ): Offstage(),
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
                      onPressed: (model.selectedCourse == null || model.selectedLesson == null || model.topics.isEmpty ) ? null :() {
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
