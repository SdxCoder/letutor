import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/book_appointment/view_models/booking_summary_view_model.dart';
import 'package:stacked/stacked.dart';

class BookingSummaryView extends StatelessWidget {
  final Booking booking;

  const BookingSummaryView({Key key, this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingSummaryViewModel>.reactive(
      viewModelBuilder: ()=> BookingSummaryViewModel(),
      builder: (context, model, child)=>
           Scaffold(
        appBar: buildAppBar(
            backgroundColor: Colors.transparent,
            title: Text("Confirm Booking",
                style: subtitle1.copyWith(color: Colors.black)),
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
                // Center(
                //   child: CircleAvatar(
                //     radius: ScreenUtil().setWidth(200),
                //     backgroundImage: NetworkImage(tutor.photoUrl),
                //   ),
                // ),
                Center(
                    child: Text(
                  booking.tutor.name.toUpperCase(),
                  style: bodyText1.copyWith(fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.person,
                  title: "Tutor",
                  value: Text(
                    booking.tutor.name,
                    style: bodyText1.copyWith(
                      color : lightBlackColor
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.person_outline,
                  title: "Student",
                  value: Text(
                    booking.user.name,
                    style: bodyText1.copyWith(
                      color : lightBlackColor
                    ),
                  ),
                ),

                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.grade,
                  title: "Level",
                  value: Text(
                    booking.course.name,
                    style: bodyText1.copyWith(
                      color : lightBlackColor
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.book,
                  title: "Course",
                  value: Text(
                    booking.course.name,
                    style: bodyText1.copyWith(
                      color : lightBlackColor
                    ),
                  ),
                ),
                 SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.library_books,
                  
                  title: "Topics",
                  value: ListView(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ...booking.topics.map(
                        (topic) => Text(
                          topic,
                          style: bodyText2.copyWith(color: lightBlackColor),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.timer,
                  title: "Selected Slot",
                  value: Text(
                    booking.slot.timeSlot,
                    style: bodyText1.copyWith(
                      color : lightBlackColor
                    ),
                  ),
                ),
                 SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.check_circle,
                  title: "Slot Status",
                  value: Text(
                    booking.slot.availablityStatus,
                    style: bodyText1.copyWith(
                      color : Colors.blue
                    ),
                  ),
                ),

                 SizedBox(
                  height: 16,
                ),
                ButtonBar(
                  children: [
                    raisedButton(
                      btnText: "Confirm",
                      onPressed: (){
                        model.createBooking(booking);
                      }
                    ),
                  ],
                )
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
