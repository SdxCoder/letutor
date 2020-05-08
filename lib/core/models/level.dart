import 'package:cloud_firestore/cloud_firestore.dart';

class Level {
  final String id;
  final String name;

  Level({this.id, this.name});

  factory Level.fromDoc(DocumentSnapshot doc) {
    return Level(id: doc.documentID, name: doc.data['name']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  static Level fromMap(data) {
    return Level(
      id: data["id"],
      name: data["name"],
    );
  }
}
