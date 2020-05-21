

import 'package:cloud_firestore/cloud_firestore.dart';

import '../core.dart';

class BookingService{
    final _bookingCollection = Firestore.instance.collection("bookings");

   Future createBooking(Booking booking) async {
       await _bookingCollection.document(booking.id).setData(booking.toJson());
    try {
       if (await _bookingExists(booking.id) == true) return;
    
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> _bookingExists(String id) async {
    DocumentSnapshot snapshot = await _bookingCollection.document(id).get();
    return snapshot.exists;
  }
}