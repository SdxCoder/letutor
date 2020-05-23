import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/models/booking.dart';
import 'package:letutor/core/shared_service/bookings_view_model.dart';
import 'package:letutor/core/shared_widgets/app_bar.dart';
import 'package:letutor/core/shared_widgets/info_section.dart';

import 'package:stacked/stacked.dart';

class BookingDetailView extends StatelessWidget {
  final String heroTag;
  final Booking booking;
  final String role;

  BookingDetailView({this.heroTag, this.booking, this.role});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingsViewModel>.reactive(
      viewModelBuilder: () => BookingsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: buildAppBar(
            backgroundColor: Colors.transparent,
            title: Text(
                model.user.role == Role.admin &&
                        booking.status == BookingStatus.pending
                    ? "Accept Booking"
                    : "Booking Details",
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
                Center(
                  child: CircleAvatar(
                    radius: ScreenUtil().setWidth(200),
                    backgroundImage: NetworkImage(role == Role.tutor
                        ? booking.user.photoUrl
                        : booking.tutor.photoUrl),
                  ),
                ),
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
                    style: bodyText1.copyWith(color: lightBlackColor),
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
                    style: bodyText1.copyWith(color: lightBlackColor),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.grade,
                  title: "Level",
                  value: Text(
                    booking.level.name,
                    style: bodyText1.copyWith(color: lightBlackColor),
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
                    style: bodyText1.copyWith(color: lightBlackColor),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.library_books,
                  title: "Topics",
                  value: Wrap(
                    children: [
                      ...booking.topics.map(
                        (topic) => Row(
                          children: [
                            Text(
                              topic,
                              style: bodyText2.copyWith(color: lightBlackColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.date_range,
                  title: "Selected Date",
                  value: Text(
                    booking.slot.date.abbrDate,
                    style: bodyText1.copyWith(color: lightBlackColor),
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
                    style: bodyText1.copyWith(color: lightBlackColor),
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
                    style: bodyText1.copyWith(color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InfoSection(
                  icon: Icons.check_circle,
                  title: "Booking Status",
                  value: Text(
                    booking.status,
                    style: bodyText1.copyWith(
                        color: booking.status == BookingStatus.pending
                            ? Colors.red
                            : Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                role == Role.admin && booking.status == BookingStatus.pending
                    ? ButtonBar(
                        children: [
                          raisedButton(
                              btnText: "Accept",
                              onPressed: () {
                                model.acceptBooking(booking.id);
                              }),
                        ],
                      )
                    : Offstage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
