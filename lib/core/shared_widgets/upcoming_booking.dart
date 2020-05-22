import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core.dart';

class UpcomingBooking extends StatelessWidget {
  final model;

  const UpcomingBooking({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (model.isBusy)
        ? Center(child: CircularProgressIndicator())
        : _upcomingBookings(context, model);
  }

  Widget _upcomingBookings(context, BookingsViewModel model) {
    print("rebuilt");

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              //  height: 300.0,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height * 3));
                },
                blendMode: BlendMode.dstIn,
                child: ListView.builder(
                  itemCount: model.bookings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final booking = model.bookings[index];
                    if (index == 0) {
                      return _bookingCard(context, booking);
                    }
                    return UpcomingBookingCard(
                      avatarImage: model.user.role == Role.tutor
                          ? booking.user.photoUrl
                          : booking.tutor.photoUrl,
                      title: booking.user.name,
                      subtitle:
                          "${booking.slot.date.abbrDate} - ${booking.slot.timeSlot}",
                      heroTag: index.toString(),
                      onTap: () {
                        String id = "1"; // This id is of unconfirmed booking
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingDetailView(
                                    heroTag: index.toString(),
                                    booking: booking,
                                    role: model.user.role,
                                  ),
                              settings: RouteSettings(
                                  name: Routes.bookingDetail
                                      .replaceAll(":id", id))),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingCard(context, firstBooking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingCard(
          booking: firstBooking,
          actions: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  firstBooking.status,
                  style: bodyText1.copyWith(color: Colors.blue),
                ))
          ],
          heroTag: appointmentsHeroTag,
          role: model.user.role,
          onTap: () {
            String id = "1"; // This id is of unconfirmed booking
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookingDetailView(
                        heroTag: appointmentsHeroTag,
                        booking: firstBooking,
                        role: model.user.role,
                      ),
                  settings: RouteSettings(
                      name: Routes.bookingDetail.replaceAll(":id", id))),
            );
          },
        ),
        (model.bookings.length <= 1)
            ? Offstage()
            : Padding(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setSp(20)),
                child: Text("Next lessons",
                    style: subtitle1.copyWith(
                      color: Color(0xFF7283B5),
                    )),
              ),
      ],
    );
  }
}
