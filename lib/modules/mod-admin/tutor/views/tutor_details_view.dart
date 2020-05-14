import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-admin/tutor/view_models/tutor_details_view_model.dart';
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
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            title: Text(
              (model.editUser) ? "Add Courses" :"Profile",
              style: subtitle1.copyWith(color: Colors.black),
            ),
            actions: [
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(icon: Icon(Icons.edit, color: model.editUser ? Colors.blue : Colors.black), onPressed: () {
                  model.switchEditing();
                }
                ),
              )
            ]),
        body: (model.editUser) 
            ? (user.role == "Tutor") ? _buildCourseForm(context, model) 
            : _changeRoleWidget(context, model)
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
                          backgroundImage: NetworkImage(user.photoUrl ?? user.photoPlaceholder),
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
                      InfoSection(
                        icon: Icons.person,
                        title: "Role",
                        value: Text(
                          user.role,
                          style: bodyText1,
                        ),
                      ),
                      (user.bookingStatus == "none" ) ? Offstage() : InfoSection(
                        icon: Icons.calendar_today,
                        title: "Booking Status",
                        value: Text(
                          user.bookingStatus,
                          style: bodyText1.copyWith(color: (user.bookingStatus == "Pending") ? Colors.red : Colors.blue),
                        )
                      ),
                       (user.bookingStatus == "none" ||  user.bookingStatus == "Confirmed") ? Offstage() : Center(
                        child:
                            raisedButton(btnText: "Confirm", onPressed: () async {
                              await model.confirmBooking(user);
                            }),
                      )
                    ],
                  ),
                )),
      ),
    );
  }

  Widget _changeRoleWidget(context, model){
    return dropdownField(
      collection: [
        "user",
        "tutor"
      ],
      onChanged: (val){

      },
      title: "Change Role",
      value: "user"
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
          dropdownField(
              value: model.selectedCourse,
              collection: model.courses,
              onChanged: (value) {
                model.selectCourse(value);
              },
              title: "Add Courses"),
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
                      : () {},
            )
          ]),
          Divider(),
          Expanded(child: _buildTutorAvailableCoursesTile(model))
        ]),
      ),
    );
  }

  Widget _buildTutorAvailableCoursesTile(model) {
    return ListView.builder(
      itemCount:1,
      itemBuilder: (context, index) {
        return Card(
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
                  children: model.selectedCourses
                      .map<Widget>((course) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: CapsuleTile(title: course, titleColor: Colors.black,)
                          ))
                      .toList(),
                )
              ],
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
                  title: course,
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
