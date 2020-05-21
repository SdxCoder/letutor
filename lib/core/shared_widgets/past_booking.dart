

import 'package:flutter/material.dart';
import 'package:letutor/modules/mod-user/appointments/views/booking_detail.dart';

import '../core.dart';

class PastBooking extends StatelessWidget {
  final model;

  const PastBooking({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (model.isBusy) ? 
    Center(child: CircularProgressIndicator())
    :_pastBookings(context, model);
  }

    Widget _pastBookings(context,BookingsViewModel model) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height * 3));
      },
      blendMode: BlendMode.dstIn,
      child: ListView.builder(
        itemCount:  model.bookings.length,
        itemBuilder: (BuildContext context, int index) {
            final booking = model.bookings[index];
          return PastBookingCard(
            actions: [
              Text("Status", style: bodyText2.copyWith(color: lightBlackColor)),
              Text(booking.status,
                  style: bodyText2.copyWith(height: 1, color: Colors.blue)),
            ],
            onTap: () {
              String id = "1"; // This id is of unconfirmed booking
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingDetailView(
                          heroTag: index.toString(),
                        ),
                    settings: RouteSettings(
                        name: Routes.bookingDetail.replaceAll(":id", id))),
              );
            },
          );
        },
      ),
    );
  }


}