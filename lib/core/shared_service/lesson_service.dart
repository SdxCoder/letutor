

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letutor/core/models/tutor.dart';

class LessonService {
    final _lessonCollection = Firestore.instance.collection("lessons");  

   Future createLesson(Lesson lesson) async {
    try {
      await _lessonCollection.document().setData(lesson.toJson());
    } catch (e) {
      return e.message;
    }
  }
}