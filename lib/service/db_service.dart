import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:letutor/core/core.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<List<Level>> getLevels() {
    try {
      var ref = _db.collection('levels');
      return ref.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Level.fromDoc(doc)).toList());
    } on PlatformException catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  Stream<List<Course>> getCourses() {
    try {
      var ref = _db.collection('courses');
      return ref.snapshots().map((snapshot) =>
          snapshot.documents.map((doc) => Course.fromDoc(doc)).toList());
    } on PlatformException catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  Stream<List<Tutor>> getTutors(String level, String course) {
    try {
      var ref = _db.collection('tutors');
      return ref
          .where('courses.$course', isEqualTo: true)
          .where('levels.$level', isEqualTo: true)
          .snapshots()
          .map((snapshot) =>
              snapshot.documents.map((doc) => Tutor.fromDoc(doc)).toList());
    } on PlatformException catch (e) {
      print(e);
      return Stream.empty();
    }
  }

  Stream<List<AvailableSlot>> getAvailability(DateTime date) {
    var ref = _db.collection('slots');
    return ref.snapshots().map((snapshot) => AvailableSlot.fromQuery(snapshot));
  }

  Stream<List<Booking>> getBookings() {
    var ref = _db.collection('bookings');
    return ref.snapshots().map((snapshot) => Booking.fromQuery(snapshot));
  }

  Future<dynamic> createBooking(Booking booking) {
    var ref = _db.collection('bookings');
    return ref.add(booking.toJson());
  }
}
