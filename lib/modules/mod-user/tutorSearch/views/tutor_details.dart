import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';

class TutorProfileView extends StatelessWidget {
  final Tutor tutor;

  const TutorProfileView({Key key, this.tutor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          backgroundColor: Colors.transparent,
          title:
              Text("Profile", style: subtitle1.copyWith(color: Colors.black)),
          automaticallyImplyLeading: true),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Center(
                child: CircleAvatar(
                  radius: ScreenUtil().setWidth(200),
                  backgroundImage:
                      NetworkImage(tutor.photoUrl ?? tutor.photoPlaceholder),
                ),
              ),
              Center(
                  child: Text(
                tutor.name.toUpperCase(),
                style: bodyText1.copyWith(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 16,
              ),
              InfoSection(
                icon: Icons.email,
                title: "Email",
                value: Text(
                  tutor.email,
                  style: bodyText1,
                ),
              ),
              (tutor.phoneNo.isEmpty)
                  ? Offstage()
                  : InfoSection(
                      icon: Icons.phone_android,
                      title: "Phone No",
                      value: Text(
                        tutor.phoneNo,
                        style: bodyText1,
                      ),
                    ),
              (tutor.lessons.isEmpty)
                  ? Offstage()
                  : InfoSection(
                      icon: Icons.library_books,
                      title: "Courses",
                      value: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...tutor.lessons
                              .map(
                                (lesson) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lesson.level,
                                      style: bodyText1,
                                    ),
                                    Wrap(
                                        spacing: 8,
                                        children: lesson.courses
                                            .map(
                                              (course) => Text(
                                                course.name,
                                                style: bodyText2.copyWith(
                                                    color: lightBlackColor),
                                              ),
                                            )
                                            .toList())
                                  ],
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
              (tutor.availableSlots == null)
                  ? Offstage()
                  : InfoSection(
                      icon: Icons.access_time,
                      title: "Available Dates",
                      value:
                      //  Wrap(
                      //   runSpacing: 4,
                      //   spacing: ScreenUtil().setSp(45),
                      //   children: [
                      //     ...tutor.availableSlots.entries.map(
                      //       (slot) {
                      //         var date = DateTime.parse(slot.key);
                      //         if (date.compareTo(DateTime.now()) == -1) {
                      //           return Offstage();
                      //         }
                      //         return Text(
                      //           DateTime.parse(slot.key).abbrDate,
                      //           style:
                      //               bodyText2.copyWith(color: lightBlackColor),
                      //         );
                      //       },
                      //     )
                      //   ],
                      // )

                      GridView.count(
                        physics: ClampingScrollPhysics(),
                        crossAxisCount: 3,
                        childAspectRatio: 2.8,
                        shrinkWrap: true,
                        children: [
                          ...tutor.availableSlots.entries.map(
                            (slot) {
                              var date = DateTime.parse(slot.key);
                              if(date.compareTo(DateTime.now()) == -1){
                                return Text(
                                DateTime.parse(slot.key).abbrDate,
                                style: bodyText2.copyWith(color: Colors.red.withOpacity(0.2)),
                              );
                              }
                              return Text(
                                DateTime.parse(slot.key).abbrDate,
                                style: bodyText2.copyWith(color: lightBlackColor),
                              );
                            },
                          )
                        ],
                     ),
                      ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSplash(BuildContext context) {
  //   return Container(
  //     height: 160,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         bottomRight: Radius.circular(30.0),
  //         bottomLeft: Radius.circular(30.0),
  //       ),
  //       color: Colors.blue,
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Text(
  //           "${tutor.name} ${tutor.lastName}",
  //           style: TextStyle(
  //             fontSize: 30,
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
