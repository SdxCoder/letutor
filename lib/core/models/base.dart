import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseModel {
  fromDoc(DocumentSnapshot doc);
}

List<T> toList<T extends BaseModel>(QuerySnapshot snapshot, T model) =>
    snapshot.documents.map((doc) => model.fromDoc(doc)).toList();
