
import 'package:equatable/equatable.dart';

import 'booking.dart';
import 'lesson.dart';
import 'level.dart';
import 'user.dart';

class Tutor extends User {
  final Map<String, List<dynamic>> availableSlots;
  final List<Lesson> lessons;

  Tutor(
      {this.availableSlots,
      this.lessons,
      uid,
      email,
      photoUrl,
      phoneNo,
      name,
      role,
      DateTime dob,
      firstName,
      lastName,
      photoPlaceholder})
      : super(
            uid: uid,
            email: email,
            photoUrl: photoUrl,
            phoneNo: phoneNo,
            name: name,
            role: role,
            dob: dob,
            firstName: firstName,
            lastName: lastName,
            photoPlaceholder: photoPlaceholder);

   Map<String , List> map = Map<String , List> ();

  Tutor.fromJson(Map<String, dynamic> json,)
      : 
    
      availableSlots =  json['slots'] == null ? null : Map<String, List<dynamic>>.from(json["slots"]),
        lessons =  json['lessons'].map<Lesson>((v) => Lesson.fromJson(v)).toList(),
        super(
            uid: json['uid'],
            firstName: json['firstName'],
            lastName: json['lastName'],
            name: json['name'],
            phoneNo: json['phoneNo'],
            photoUrl: json['photoUrl'],
            photoPlaceholder: json['photoPlaceholder'],
            dob: json['dob'].toDate(),
            role: json['role'],
            email: json['email']);

  @override
  Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['slots'] = this.availableSlots;

     if (this.lessons != null) {
      data['lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
     data.addAll( super.toJson());
   
    return data;
  }

  Map<String, dynamic> toObjectJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     Map<String , List> map = Map<String , List> ();
     this.availableSlots.forEach((key, value) {
       map.addAll({
         key: value.map((e) => e.toJson()).toList()
       });
     });
    data['slots'] = map;

     if (this.lessons != null) {
      data['lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
     data.addAll( super.toJson());
   
    return data;
  }
}

class Slots{
  final Map<String, List<dynamic>> availableSlots;

  Slots({this.availableSlots});
}
