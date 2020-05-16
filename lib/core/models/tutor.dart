import 'package:equatable/equatable.dart';

import 'course.dart';

class Tutor extends Equatable {
  final String documentId;
  final String uid;
  final String lessonId;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  List<DateTime> availableSlots;

  Tutor(
      {this.documentId,
      this.uid,
      this.lessonId,
      this.name,
      this.firstName,
      this.lastName,
      this.email,
      this.availableSlots});

  Tutor.fromJson(Map<String, dynamic> json)
      : documentId = json['documentId'],
        uid = json['uid'],
        lessonId = json['lessonId'],
        name = json['name'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        availableSlots = json['availableSlots'].cast<String>();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentId'] = this.documentId;
    data['uid'] = this.uid;
    data['lessonId'] = this.lessonId;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['availableSlots'] = this.availableSlots;
    return data;
  }

  @override
  List<Object> get props => throw UnimplementedError();
}
