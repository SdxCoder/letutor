import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:letutor/core/models/user.dart';

class UserService {
  final _userCollection = Firestore.instance.collection("users");


  Future getUsersOnceOff() async {
    try {
      var doc = await _userCollection.getDocuments();
      if (doc.documents.isNotEmpty) {
        return doc.documents
            .map((snapshot) => User.fromJson(snapshot.data))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream<List<User>> getAllUsers() {
    try {
      return _userCollection.snapshots().map((snapshot) =>
          snapshot.documents.map((json) => User.fromJson(json.data)).toList());
    } on PlatformException catch (e) {
      print(e);
      return Stream.empty();
    }
  }
  
  Future createUser(User user) async {
    try {
      if(await _userExists(user) == true) return;
      await _userCollection.document(user.uid).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _userCollection.document(uid).get();
      return User.fromJson(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> _userExists(User user) async {
      DocumentSnapshot snapshot = await _userCollection.document(user.uid).get();
      return snapshot.exists;
    
  }
}
