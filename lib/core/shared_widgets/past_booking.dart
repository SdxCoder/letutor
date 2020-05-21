import 'package:flutter/material.dart';

import '../core.dart';

class PastBooking extends StatelessWidget {
  final model;

  const PastBooking({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (model.isBusy)
        ? Center(child: CircularProgressIndicator())
        : _pastBookings(context, model);
  }

  Widget _pastBookings(context, BookingsViewModel model) {
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
        itemCount: model.bookings.length,
        itemBuilder: (BuildContext context, int index) {
          final booking = model.bookings[index];
          return PastBookingCard(
            booking: booking,
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
                        name: Routes.bookingDetail.replaceAll(":id", id))),
              );
            },
          );
        },
      ),
    );
  }
}
