// import 'package:cloud_firestore/cloud_firestore.dart';


// import '../core.dart';
// import 'base.dart';

// class Booking {
//   final String id;
//   final AvailableSlot slot;
//   final BookingStatus status;
//   final Course course;
//   final List<CourseTopic> topics;
//   final Level level;

//   Booking(
//       {this.id, this.slot, this.status, this.course, this.topics, this.level});
//   factory Booking.fromDoc(DocumentSnapshot doc) {
//     return Booking(
//       id: doc.documentID,
//       slot: AvailableSlot.fromMap(doc['slot']),
//       status: BookingStatus.values[doc["status"]],
//       course: Course.fromMap(doc["course"]),
//       topics: doc["topics"].map((topic) => CourseTopic.fromMap(topic)),
//       level: Level.fromMap(doc["level"]),
//     );
//   }

//   int get statusValue => (status ?? BookingStatus.unconfirmed).index;

//   static List<Booking> fromQuery(QuerySnapshot snapshot) =>
//       snapshot != null ? toList(snapshot, Booking) : [];

//   Map<String, dynamic> toJson() => {
//         'slot': slot.toJson(),
//         'status': statusValue,
//         'course': course.toJson(),
//         'topics': topics.map((topic) => topic.toJson()),
//         'level': level.name,
//       };
// }

// enum BookingStatus {
//   unconfirmed, // default status when created
//   confirmed // payment has been made
// }

// class AvailableSlot {
//   final String id;
//   final SlotStatus status;
//   final Tutor tutor;
//   final DateTime date;

//   AvailableSlot({this.id, this.status, this.tutor, this.date});

//   factory AvailableSlot.fromDoc(DocumentSnapshot doc) {
//     return AvailableSlot(
//       id: doc.documentID,
//       status: SlotStatus.values[doc['status']],
//       tutor: Tutor.fromMap(doc["tutor"]),
//       date: DateTime.fromMicrosecondsSinceEpoch(doc["date"]),
//     );
//   }

//   int get statusValue => (status ?? SlotStatus.booked).index;

//   static List<AvailableSlot> fromQuery(QuerySnapshot snapshot) =>
//       snapshot != null ? toList(snapshot, AvailableSlot) : [];

//   static AvailableSlot fromMap(data) {
//     return new AvailableSlot(
//       id: data["id"],
//       status: data["status"],
//       tutor: data["tutor"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'status': statusValue,
//         'tutor': tutor.toJson(),
//       };
// }

// enum SlotStatus { available, booked }
