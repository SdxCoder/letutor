import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

import '../core.dart';

class BookingService {
  final _bookingCollection = Firestore.instance.collection("bookings");
  final _user = Modular.get<AuthService>().currentUser.user;

  StreamController<List<Booking>> _controller =
      StreamController<List<Booking>>.broadcast();

  StreamController<List<Booking>> _pastBookingController =
      StreamController<List<Booking>>.broadcast();

  Stream<List<Booking>> listenToBookingsRealTime(
    bool upcomingBookings,
  ) {
    // Register the handler for when the tutors data changes
    print(upcomingBookings);
    if (upcomingBookings == true) {
      print("upcoming");
      _bookingCollection
          .where('status', isEqualTo: BookingStatus.pending)
          .snapshots()
          .listen((snapshots) {
        if (snapshots.documents.isNotEmpty) {
          var bookings = snapshots.documents
              .map((snapshot) =>
                  Booking.formJson(snapshot.data, id: snapshot.documentID))
              .toList();
          // Add the tutors onto the controller
          _controller.add(bookings);
        } else {
          _controller.add(List<Booking>());
        }
      });

      // Return the stream underlying our _controller.
      return _controller.stream;
    } else {
      _bookingCollection
          .where('status', isEqualTo: BookingStatus.confirmed)
          .snapshots()
          .listen((snapshots) {
        if (snapshots.documents.isNotEmpty) {
          var bookings = snapshots.documents
              .map((snapshot) =>
                  Booking.formJson(snapshot.data, id: snapshot.documentID))
              .toList();
          // Add the tutors onto the controller
          _pastBookingController.add(bookings);
        } else {
          _pastBookingController.add(List<Booking>());
        }
      });

      // Return the stream underlying our _controller.
      return _pastBookingController.stream;
    }
  }

  Stream<List<Booking>> listenToBookingsRealTimeByUser(
    bool upcomingBookings,
  ) {
    // Register the handler for when the tutors data changes
    if (upcomingBookings == true) {
      _bookingCollection
          .where("studentId", isEqualTo: _user.uid)
          .where('status', isEqualTo: BookingStatus.pending)
          .snapshots()
          .listen((snapshots) {
        if (snapshots.documents.isNotEmpty) {
          var bookings = snapshots.documents
              .map((snapshot) =>
                  Booking.formJson(snapshot.data, id: snapshot.documentID))
              .toList();
          // Add the tutors onto the controller
          _controller.add(bookings);
        } else {
          _controller.add(List<Booking>());
        }
      });

      // Return the stream underlying our _controller.
      return _controller.stream;
    } else {
      _bookingCollection
          .where("studentId", isEqualTo: _user.uid)
          .where('status', isEqualTo: BookingStatus.confirmed)
          .snapshots()
          .listen((snapshots) {
        if (snapshots.documents.isNotEmpty) {
          var bookings = snapshots.documents
              .map((snapshot) =>
                  Booking.formJson(snapshot.data, id: snapshot.documentID))
              .toList();
          // Add the tutors onto the controller
          _pastBookingController.add(bookings);
        } else {
          _pastBookingController.add(List<Booking>());
        }
      });

      // Return the stream underlying our _controller.
      return _pastBookingController.stream;
    }
  }

  Stream<List<Booking>> listenToBookingsRealTimeByTutor(
    bool upcomingBookings,
  ) {
    // Register the handler for when the tutors data changes
    if (upcomingBookings == true) {
      _bookingCollection
          .where("tutorId", isEqualTo: _user.uid)
          .where('status', isEqualTo:BookingStatus.pending)
          .snapshots()
          .listen((snapshots) {
        if (snapshots.documents.isNotEmpty) {
          var bookings = snapshots.documents
              .map((snapshot) =>
                  Booking.formJson(snapshot.data, id: snapshot.documentID))
              .toList();
          // Add the tutors onto the controller
          _controller.add(bookings);
        } else {
          _controller.add(List<Booking>());
        }
      });

      // Return the stream underlying our _controller.
      return _controller.stream;
    } else {
       _bookingCollection
          .where("tutorId", isEqualTo: _user.uid)
          .where('status', isEqualTo:BookingStatus.confirmed)
          .snapshots()
          .listen((snapshots) {
        if (snapshots.documents.isNotEmpty) {
          var bookings = snapshots.documents
              .map((snapshot) =>
                  Booking.formJson(snapshot.data, id: snapshot.documentID))
              .toList();
          // Add the tutors onto the controller
          _pastBookingController.add(bookings);
        } else {
          _pastBookingController.add(List<Booking>());
        }
      });

      // Return the stream underlying our _controller.
      return _pastBookingController.stream;
    }
  }

  Future createBooking(Booking booking) async {
    await _bookingCollection.document(booking.id).setData(booking.toJson());
    try {
      if (await _bookingExists(booking.id) == true) return;
    } catch (e) {
      return e.message;
    }
  }

  Future updateBooking(String id, Map<String, dynamic> map) async {
    try {
      await _bookingCollection.document(id).updateData(map);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<bool> _bookingExists(String id) async {
    DocumentSnapshot snapshot = await _bookingCollection.document(id).get();
    return snapshot.exists;
  }
}
