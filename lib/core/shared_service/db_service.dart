import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/models/course.dart';

class DbService {
  final _coursesCollection = Firestore.instance.collection("courses");
  final _levelsCollection = Firestore.instance.collection("levels");

  final StreamController<List<Course>> _coursesController =
      StreamController<List<Course>>.broadcast();

  final StreamController<List<Level>> _levelsController =
      StreamController<List<Level>>.broadcast();

  Stream<List<Course>> getAllCourses() {
    _coursesCollection.snapshots().listen((snapshots) {
      if (snapshots.documents.isNotEmpty) {
        var users = snapshots.documents
            .map((snapshot) => Course.fromJson(snapshot.data))
            .toList();

        _coursesController.add(users);
      }
    });

    return _coursesController.stream;
  }

  Stream<List<Level>> getAllLevels() {
    _levelsCollection.snapshots().listen((snapshots) {
      if (snapshots.documents.isNotEmpty) {
        var levels = snapshots.documents
            .map((snapshot) => Level.fromJson(snapshot.data))
            .toList();

        _levelsController.add(levels);
      }
    });

    return _levelsController.stream;
  }

}
