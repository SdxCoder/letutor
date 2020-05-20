

import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';

class BookingSummaryView extends StatelessWidget {
  final Booking booking;

  const BookingSummaryView({Key key, this.booking}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text(booking.id)),
    );
  }
}