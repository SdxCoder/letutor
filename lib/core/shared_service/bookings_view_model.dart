import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/constants/constants.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

import '../core.dart';
import 'booking_service.dart';
import '../models/booking.dart';

class BookingsViewModel extends BaseViewModel {
  final _authService = Modular.get<AuthService>();
  final _bookingServie = Modular.get<BookingService>();
  final user = Modular.get<AuthService>().currentUser.user;

  List<Booking> _bookings = [];
  StreamSubscription _subscription;

  List<Booking> get bookings => _bookings;

  void listenToBookingsByUser({bool flag = false}) {
    setBusy(true);
    _subscription =
        _bookingServie.listenToBookingsRealTimeByUser(flag).listen((data) {
      List<Booking> bookings = data;
      if (bookings != null && bookings.length > 0) {
        _bookings = bookings;
        notifyListeners();
      }
      
    });
    setBusy(false);
  }

   void listenToBookingsByTutor({bool flag = false}) {
    setBusy(true);
    _subscription =
        _bookingServie.listenToBookingsRealTimeByTutor(flag).listen((data) {
      List<Booking> bookings = data;
      if (bookings != null && bookings.length > 0) {
        _bookings = bookings;
        notifyListeners();
      }
      setBusy(false);
    });
  }

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

  Future acceptBooking(String bookingId) async {
    var confirm = await showActionDialogBox(title: "Reminder", description: "Are you sure you want to accept this booking?");
    if(confirm != 'true') return;
    var result = await _bookingServie.updateBooking(bookingId, {
      'status' : BookingStatus.confirmed
    });
    
    if(result is String){
        await showDialogBox(title: "Error", description: result);
    }else{
       await showDialogBox(
          title: "Success", description: "Booking accepted");
      Modular.to.pop();
    }
    
  }

  @override
  void dispose() {
    if(_subscription != null){
       _subscription.cancel();
    }
   
    super.dispose();
  }
}
