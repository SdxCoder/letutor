import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import 'booking_service.dart';
import '../models/booking.dart';

class BookingsViewModel extends BaseViewModel {
  final _authService = Modular.get<AuthService>();
  final _bookingServie = Modular.get<BookingService>();

  List<Booking> _bookings = [];
  StreamSubscription _subscription;

  List<Booking> get bookings => _bookings;

  void listenToBookings({bool flag = false}) {
    setBusy(true);
    _subscription =
        _bookingServie.listenToBookingsRealTime(flag).listen((data) {
      List<Booking> bookings = data;
      if (bookings != null && bookings.length > 0) {
        _bookings = bookings;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
