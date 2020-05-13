import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String name;
  final String pricing;

  Course({this.id, this.name, this.pricing});

  Course.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    pricing = json['pricing'];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pricing'] = this.pricing;
    return data;
  }
}