


import 'package:equatable/equatable.dart';
import 'course.dart';

class Lesson extends Equatable {
  final String documentId;
  final String tutorId;
  final String tutorName;
  final String level;
  final String levelId;
  final List<Course> courses;

  Lesson({this.tutorName, this.levelId, this.documentId, this.tutorId, this.level, this.courses});

  Lesson.fromJson(Map<String, dynamic> json, {documentId})
      : documentId = documentId,
        tutorId = json['tutorId'],
        tutorName = json['tutorName'],
        level = json['level'],
        levelId = json['levelId'],
        courses = json['courses'].map<Course>((v) => Course.fromJson(v)).toList();


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['tutorId'] = this.tutorId;
    data['level'] = this.level;
    data['levelId'] = this.levelId;
    data['tutorName'] = this.tutorName;

    if (this.courses != null) {
      data['courses'] = this.courses.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [ this.level,this.levelId, this.tutorId, this.tutorName, this.courses];
}
