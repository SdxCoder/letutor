import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// level: PJGt5OmGessfkNMrBIG5
// course: mYTqffX7cjq4yFDPRDOY

// level: 416w2hGqJoKNCGJ4CAoE
// course: 0Z9yd8jX11lp2ZvvRIpm
class Tutor {
  final String id;
  final String name;
  final String lastName;
  Tutor({this.id, this.name, this.lastName});

  factory Tutor.fromDoc(DocumentSnapshot doc) {
    return Tutor(
        id: doc.documentID,
        name: doc.data['name'],
        lastName: doc.data['last_name']);
  }

  static Tutor fromMap(data) {
    return Tutor(
        id: data["id"], name: data["name"], lastName: data["last_name"]);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'lastName': lastName};
}
