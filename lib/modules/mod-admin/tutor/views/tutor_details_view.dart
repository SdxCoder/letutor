import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-admin/tutor/view_models/tutor_details_view_model.dart';
import 'package:letutor/modules/mod-admin/tutor/widgets/select_course_widget.dart';
import 'package:stacked/stacked.dart';

class TutorDetailsView extends StatelessWidget {
  final String id;
  final User user;

  TutorDetailsView({Key key, this.id, this.user}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("built");
    return ViewModelBuilder<TutorDetailsViewModel>.reactive(
      viewModelBuilder: () => TutorDetailsViewModel(),
      onModelReady: (model) => model.setEdittingUser(user),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          
          child: Icon(Icons.add),
          onPressed:(model.lessons.isEmpty) ? null : (){
          model.createlessons();
        }),
        appBar: buildAppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            title: Text(
              (model.editUser && user.role == Role.tutor)
                  ? "Add Courses"
                  : "Profile",
              style: subtitle1.copyWith(color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                    icon: Icon(Icons.edit,
                        color: model.editUser ? Colors.blue : Colors.black),
                    onPressed: () {
                      model.switchEditing();
                    }),
              )
            ]),
        body: (model.editUser && user.role == Role.tutor)
            ? _buildCourseForm(context, model)
            : Container(
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
                          backgroundImage: NetworkImage(
                              user.photoUrl ?? user.photoPlaceholder),
                        ),
                      ),
                      Center(
                          child: Text(
                        user.name.toUpperCase(),
                        style: bodyText1.copyWith(fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 16,
                      ),
                      InfoSection(
                        icon: Icons.email,
                        title: "Email",
                        value: Text(
                          user.email,
                          style: bodyText1,
                        ),
                      ),
                      _changeRoleWidget(context, model),
                      (user.role == Role.user)
                          ? Offstage()
                          : InfoSection(
                              icon: Icons.calendar_today,
                              title: "Booking Status",
                              value: Text(
                                "Confirmed",
                                style: bodyText1.copyWith(color: Colors.blue),
                              )),
                    ],
                  ),
                )),
      ),
    );
  }

  Widget _changeRoleWidget(context, TutorDetailsViewModel model) {
    return InfoSection(
      icon: Icons.person,
      title: "Role",
      value: (model.editUser && user.role == Role.user)
          ? Column(
              children: <Widget>[
                dropdownField(
                    collection: [
                      Role.tutor,
                    ],
                    onChanged: (val) {
                      model.changeUserRole(val);
                    },
                    title: "Change Role",
                    value: model.selectedUserRole),
                SizedBox(
                  height: 16,
                ),
                raisedButton(
                    btnText: "Update",
                    onPressed: () async {
                      await model.confirmBooking();
                    }),
              ],
            )
          : Text(
              user.role,
              style: bodyText1,
            ),
    );
  }

  Widget _buildCourseForm(context, TutorDetailsViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 16,
          ),
          dropdownField(
              value: model.selectedlevel,
              collection: model.modalities,
              onChanged: (value) {
                model.selectLevel(value);
              },
              title: "Academic Level"),
          SizedBox(
            height: 16,
          ),
          SelectCourseWidget(
            onChanged: (val){
              model.selectCourse(val);
            },
            value: model.selectedCourse.name,
          ),
          // dropdownField(
          //     value: model.selectedCourse,
          //     collection: model.courses,
          //     onChanged: (value) {
          //       model.selectCourse(value);
          //     },
          //     title: "Add Courses"),
          SizedBox(
            height: 8,
          ),
          _addCourseOptions(model),
          SizedBox(
            height: 16,
          ),
          ButtonBar(children: [
            raisedButton(
              btnText: "Add",
              onPressed:
                  (model.selectedCourses.isEmpty || model.selectedlevel == null)
                      ? null
                      : () {
                          model.addLesson();
                        },
            )
          ]),
          Divider(),
          (model.lessons.isEmpty)
              ? Offstage()
              : Center(
                  child: Text(
                  "Swipe to remove",
                  style: bodyText1.copyWith(color: lightBlackColor),
                )),
          Expanded(child: _buildLessonTile(model))
        ]),
      ),
    );
  }

  Widget _buildLessonTile(TutorDetailsViewModel model) {
    return ListView.builder(
      itemCount: model.lessons.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(index.toString()),
          onDismissed: (d) {
            model.removeLesson(model.lessons.elementAt(index));
          },
          child: Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Academic Level",
                    style: bodyText1.copyWith(color: lightBlackColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model.selectedlevel,
                      style: bodyText2.copyWith(height: 1),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Courses",
                    style: bodyText1.copyWith(color: lightBlackColor),
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    children: model.lessons
                        .elementAt(index)
                        .courses
                        .map<Widget>((course) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: CapsuleTile(
                              title: course,
                              titleColor: Colors.black,
                            )))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addCourseOptions(TutorDetailsViewModel model) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: model.selectedCourses
          .map((course) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: CapsuleTile(
                  title: course.name,
                  cancelIcon: Icon(
                    Icons.cancel,
                    size: ScreenUtil().setSp(45),
                  ),
                  onTapCancelIcon: () {
                    model.removeCourse(course);

                    print("remove");
                  },
                ),
              ))
          .toList(),
    );
  }
}
