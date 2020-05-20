import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/view_models/tutor_availability_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class TutorAvailabilityView extends StatefulWidget {
  final Booking booking;

  const TutorAvailabilityView({Key key, this.booking}) : super(key: key);
  @override
  TutorAvailabilityViewState createState() => TutorAvailabilityViewState();
}

class TutorAvailabilityViewState extends State<TutorAvailabilityView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  initState() {
    super.initState();

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
        model.setBooking(widget.booking);
        model.mapEvents();
      },
      builder: (context, TutorAvailabilityViewModel model, child) => Scaffold(
        appBar: buildAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            title: Text("Select Date and Slot",
                style: subtitle1.copyWith(color: Colors.black)),
            centerTitle: true),
        floatingActionButton: (model.selectedDate == null || model.selectedSlot == null)
            ? Offstage()
            : raisedButton(btnText: "Next", onPressed: () {
              model.updateBooking();
              // 1073373354
            }),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                    initialSelectedDay: model.selectedDate,
                    events: model.events,
                    calendarController: _calendarController,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      selectedColor: Colors.blue[400],
                      todayColor: Colors.blue[200],
                      markersColor: Colors.blue.withOpacity(0.5),
                      outsideDaysVisible: true,
                      holidayStyle: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.blue),
                      outsideHolidayStyle:
                          Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.blue,
                              ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonTextStyle: TextStyle().copyWith(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(30)),
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    onDaySelected: (dateTime, events) {
                      model.selectDate(dateTime, events);
                    }),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: _buildEventList(model),
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
          (model.selectedEvents.isEmpty)
              ? Offstage()
              : Text(
                  "Available Slots",
                  style: subtitle1.copyWith(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            height: 16,
          ),
          GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 2.1,
            shrinkWrap: true,
            children: model.selectedEvents
                .map((event) {
                  if(Slot.fromJson(event).availablityStatus == SlotStatus.booked){
                    return BookedTimeSlot(
                      slot : Slot.fromJson(event).timeSlot
                    );
                  }
                  return TimeSlotTile(
                      slot: Slot.fromJson(event),
                      color: (model.selectedSlot ==  Slot.fromJson(event))
                          ? Colors.blue
                          : Colors.transparent,
                      onSelection: ( val) {
                        model.selectSlot( val);
                        print(val.timeSlot);
                      },
                      titleColor: (model.selectedSlot ==  Slot.fromJson(event))
                          ? Colors.white
                          : lightBlackColor,
                    ); })
                .toList(),
          ),
        ],
      ),
    );
  }
}
