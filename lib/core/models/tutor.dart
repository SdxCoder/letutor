
import 'package:equatable/equatable.dart';

import 'user.dart';

class Tutor extends User {
  final Map<String, List<dynamic>> availableSlots;

  Tutor(
      {this.availableSlots,
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

  Tutor.fromJson(Map<String, dynamic> json)
      : availableSlots = json["slots"],
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
    data.addAll( super.toJson());
   
    return data;
  }
}

// class Tutor extends Equatable {
//   final String documentId;
//   final String uid;
//   final String lessonId;
//   final String name;
//   final String firstName;
//   final String lastName;
//   final String email;
//   Map<DateTime, List> availableSlots;

//   Tutor(
//       {this.documentId,
//       this.uid,
//       this.lessonId,
//       this.name,
//       this.firstName,
//       this.lastName,
//       this.email,
//       this.availableSlots});

//   Tutor.fromJson(Map<String, dynamic> json)
//       : documentId = json['documentId'],
//         uid = json['uid'],
//         lessonId = json['lessonId'],
//         name = json['name'],
//         firstName = json['firstName'],
//         lastName = json['lastName'],
//         email = json['email'],
//         availableSlots = json['availableSlots'].cast<String>();

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['documentId'] = this.documentId;
//     data['uid'] = this.uid;
//     data['lessonId'] = this.lessonId;
//     data['name'] = this.name;
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['email'] = this.email;
//     data['availableSlots'] = this.availableSlots;
//     return data;
//   }

//   @override
//   List<Object> get props => throw UnimplementedError();
// }
