import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:letutor/core/models/tutor.dart';

class TutorService {
  final _tutorCollection = Firestore.instance.collection("tutors");


  final StreamController<List<Tutor>> _controller =
      StreamController<List<Tutor>>.broadcast();

  Stream<List<Tutor>> listenToTutorsRealTime() {
     // Register the handler for when the tutors data changes
    _tutorCollection.snapshots().listen((snapshots) {
      if (snapshots.documents.isNotEmpty) {
        var tutors = snapshots.documents
            .map((snapshot) => Tutor.fromJson(snapshot.data))
            .toList();

        // Add the tutors onto the controller
        _controller.add(tutors);
      }
    });
    
    // Return the stream underlying our _controller.
    return _controller.stream;
  }

  Future createTutor(Tutor tutor) async {
    try {

      await _tutorCollection.document(tutor.uid).setData(tutor.toObjectJson());
    } catch (e) {
      return e.message;
    }
  }

  Future updateTutor(Tutor tutor ) async {
    try {
      await _tutorCollection
          .document(tutor.uid)
          .updateData(tutor.toJson());

    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  
  // Future<bool> _tutorExists(Tutor tutor) async {
  //   DocumentSnapshot snapshot =
  //       await _tutorCollection.document(tutor.uid).get();
  //   return snapshot.exists;
  // }
}
