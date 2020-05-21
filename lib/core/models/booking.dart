// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../core.dart';
// import 'base.dart';

import 'package:equatable/equatable.dart';

import 'course.dart';
import 'level.dart';
import 'tutor.dart';
import 'user.dart';

class Booking extends Equatable {
  final String id;
  final Slot slot;
  final String status;
  final Course course;
  final List<String> topics;
  final Level level;
  final Tutor tutor;
  final String tutorId;
  final String studentId;
  final User user;

  Booking(
      {this.tutorId, this.studentId, this.id,
      this.slot,
      this.status,
      this.course,
      this.topics,
      this.level,
      this.tutor,
      this.user});

  Booking.formJson(Map<String, dynamic> data, {String id})
      : this.id = id,
        this.tutorId = data['tutorId'],
        this.studentId = data['studentId'],
        this.status = data['status'],
        this.slot = Slot.fromJson(data['slot']),
        this.level = Level.fromJson(data['level']),
        this.course = Course.fromJson(data['course']),
        this.tutor = Tutor.fromJson(data['tutor']),
        this.topics = data['topics'].cast<String>(),
        this.user = User.fromJson(data['user']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'studentId':studentId,
        'tutorId':tutorId,
        'status': status,
        'topics':topics,
        'level': this.level.toJson(),
        'course': this.course.toJson(),
        'slot': this.slot.toJson(),
        'tutor': this.tutor.toJson(),
        'user': this.user.toJson()
      };

  @override
  List<Object> get props => [level, course, slot, tutor, topics];
}

class Slot extends Equatable{
  final String availablityStatus;
  final String timeSlot;
  final DateTime date;

  Slot({this.availablityStatus, this.timeSlot, this.date});

  Slot.fromJson(Map<String, dynamic> data)
      : availablityStatus = data['availablityStatus'],
        date = data['date'].toDate(),
        timeSlot = data['timeSlot'];

  Map<String, dynamic> toJson() =>
      {'availablityStatus': availablityStatus, 'timeSlot': this.timeSlot, 'date': this.date};

  @override
  List<Object> get props => [timeSlot, availablityStatus];
      
}
