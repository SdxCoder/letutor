import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-tutor/courses/view_model/addCourse_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/core.dart';

class AddCourseView extends StatelessWidget {
  final _courseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  CalendarController _calendarController = CalendarController();
  DateTime _selectedDay;
  var _bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddCourseViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 8,
                ),
                TopNavBar(
                  title: <Widget>[
                    Text(
                      'Add your',
                      style: headline6.copyWith(),
                    ),
                    Text('Courses',
                        style: headline5.copyWith(
                            height: 1, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(child: _buildCourseForm(context, model)),
              ],
            )),
      ),
    );
  }

  Widget _buildCourseForm(context, AddCourseViewModel model) {
    return SingleChildScrollView(
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
          textField(
            title: "Add Courses",
            controller: _courseController,
            hintText: "Add Courses",
            iconData: Icons.add,
            onTapIcon: () {
              model.addCourse(_courseController.text);
              _courseController.clear();
              print(_courseController.text);
            },
            validator: (String val) {},
            onFieldSubmit: (String val) {
              model.addCourse(val);
              _courseController.clear();
              print(val);
            },
          ),
          SizedBox(
            height: 8,
          ),
          _addCourseOptions(model),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Row(children: [
              Text(
                "Choose Availability",
                style: bodyText2.copyWith(color: lightBlackColor),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                     _bottomSheetController = showModalBottomSheet(

                        context: context, builder: (context) {
                          return _tableCalender(context, model);
                        });
                  },
                  child: Icon(Icons.add, size: ScreenUtil().setSp(45)))
            ]),
          ),
          ButtonBar(children: [])
        ]),
      ),
    );
  }

  Widget _tableCalender(context, model) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: TableCalendar(
          
              events: model.events,
              calendarController: _calendarController,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: CalendarStyle(
                selectedColor: Colors.deepOrange[400],
                todayColor: Colors.deepOrange[200],
                markersColor: Colors.brown[700],
                outsideDaysVisible: true,
                holidayStyle:
                    Theme.of(context).textTheme.caption.copyWith(color: Colors.black),
                outsideHolidayStyle: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.orange,
                    ),
              ),
              headerStyle: HeaderStyle(
                formatButtonTextStyle:
                    TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
                formatButtonDecoration: BoxDecoration(
                  color: Colors.deepOrange[400],
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onDaySelected: (dateTime, events) {
                model.selectDate(dateTime, events);
              }),
        ),
      ],
    );
  }

  Widget _addCourseOptions(AddCourseViewModel model) {
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
