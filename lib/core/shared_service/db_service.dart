import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/models/course.dart';

class DbService {
  final _coursesCollection = Firestore.instance.collection("courses");
  final _levelsCollection = Firestore.instance.collection("levels");

  Future getAllCourses() async {
    try {
      var doc = await _coursesCollection
          .getDocuments();

          print(doc.documents.length);

      if (doc.documents.isNotEmpty) {
        return doc.documents
            .map((snapshot) => Course.fromJson(snapshot.data))
            .toList();
      }
      else{
        return List<Course>(); // return emply list
      }
      
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

   Future getAllLevels() async {
    try {
      var doc = await _levelsCollection
          .getDocuments();

      if (doc.documents.isNotEmpty) {
        return doc.documents
            .map((snapshot) => Level.fromJson(snapshot.data))
            .toList();
      }
      else{
        return List<Level>(); // return emply list
      }
      
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

}
