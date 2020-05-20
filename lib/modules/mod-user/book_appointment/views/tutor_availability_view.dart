import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/view_models/tutor_availability_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class TutorAvailabilityView extends StatefulWidget {
  final Tutor tutor;

  const TutorAvailabilityView({Key key, this.tutor}) : super(key: key);
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
    return ViewModelBuilder<TutorAvailabilityViewModel>.reactive(
      viewModelBuilder: () => TutorAvailabilityViewModel(),
      onModelReady: (model) {
        model.setTutor(widget.tutor);
        model.mapEvents();
      },
      builder: (context, TutorAvailabilityViewModel model, child) => Scaffold(
        appBar: buildAppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
          title: Text("Select Date and Slot", style:subtitle1.copyWith(color:Colors.black)),
        centerTitle: true
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
      ),
    );
  }

  Widget _buildEventList(TutorAvailabilityViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Available Slots", style: subtitle1.copyWith(
            fontWeight:FontWeight.bold
          ),),
          SizedBox(height: 16,),
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2.1,
            shrinkWrap: true,
            children: model.selectedEvents
                .map((event) => TimeSlotTile(
                  title: event,
                  onSelection: (val){
                    print(val);
                  },
                  onCancelSelection: (val){
                    print(val);
                  },
                  titleColor: lightBlackColor,
                ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
