import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letutor/core/models/lesson.dart';

class LessonService {
  final _lessonCollection = Firestore.instance.collection("lessons");

  Future createLesson(Lesson lesson) async {
     if(await _checkExistingLesson(lesson) == true){
        return "Lesson already exists";
      }
    try {
     
      await _lessonCollection.document().setData(lesson.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future _checkExistingLesson(Lesson createdLesson) async {
    var docs = await _lessonCollection.getDocuments();
    if (docs.documents.isNotEmpty) {
      for (DocumentSnapshot snapshot in docs.documents) {
        var lesson = Lesson.fromJson(snapshot.data, snapshot.documentID);
        print(lesson.toString());
        if (lesson == createdLesson) {
          return true;
        }
      }
    }

    return false;
  }
}
