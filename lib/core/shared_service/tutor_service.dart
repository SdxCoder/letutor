import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letutor/core/models/tutor.dart';

class TutorService {
  final _tutorCollection = Firestore.instance.collection("tutors");

  Future createTutor(Tutor tutor) async {
     await _tutorCollection.document(tutor.uid).setData(tutor.toJson());
  
    try {
      if (await _tutorExists(tutor) == true) return;
     
      
    } catch (e) {
      return e.message;
    }
  }

  void call(){
    print("called");
  }

  Future<bool> _tutorExists(Tutor tutor) async {
    DocumentSnapshot snapshot =
        await _tutorCollection.document(tutor.uid).get();
    return snapshot.exists;
  }
}
