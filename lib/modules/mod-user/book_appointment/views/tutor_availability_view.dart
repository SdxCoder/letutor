import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/view_models/tutor_availability_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class TutorAvailabilityView extends StatefulWidget {
  @override
  TutorAvailabilityViewState createState() => TutorAvailabilityViewState();
}

class TutorAvailabilityViewState extends State<TutorAvailabilityView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  DateTime _selectedDay;

  @override
  initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TutorAvailabilityViewModel(),
      builder: (context, TutorAvailabilityViewModel model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 15.0),
                child: Text(
                  "Availability",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              TableCalendar(
                  events: model.events,
                  calendarController: _calendarController,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    selectedColor: Colors.deepOrange[400],
                    todayColor: Colors.deepOrange[200],
                    markersColor: Colors.brown[700],
                    outsideDaysVisible: true,
                    holidayStyle: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(color: Colors.black),
                    outsideHolidayStyle:
                        Theme.of(context).textTheme.caption.copyWith(
                              color: Colors.orange,
                            ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonTextStyle: TextStyle()
                        .copyWith(color: Colors.white, fontSize: 15.0),
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.deepOrange[400],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onDaySelected: (dateTime, events) {
                    model.selectDate(dateTime, events);
                  }),
                  SizedBox(height: 20,),
                  Expanded(child: _buildEventList(model),),
                  Align(
                    alignment: Alignment.centerRight,
                                      child: Padding(
                      padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
                      child: RaisedButton(
                        disabledColor: buttonColor.withOpacity(0.5),
                        onPressed: (model.selectedDate == null ) ? null :() {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => TutorAvailabilityView(),
                          //         settings: RouteSettings(
                          //           name: Routes.tutorAvailability
                          //         )
                          //         ));
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Color(0xFF21BFBD),
                        child:
                            Text('Next', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventList(TutorAvailabilityViewModel model) {
    return ListView(
      children: model.selectedEvents
          .map((event) => Container(
                
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8, color: Colors.deepOrange[400]),
                  borderRadius: BorderRadius.circular(12.0),
                  
                  color: Colors.deepOrange[100]
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
