import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String name;

  Course({this.id, this.name});

  factory Course.fromDoc(DocumentSnapshot doc) {
    return Course(id: doc.documentID, name: doc.data['name']);
  }

  static Course fromMap(data) {
    return Course(id: data["id"], name: data["name"]);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class CourseTopic {
  final String id;
  final String topic;

  CourseTopic({this.id, this.topic});

  static CourseTopic fromMap(data) {
    return CourseTopic(
      id: data["id"],
      topic: data["topic"],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': topic,
      };
}
