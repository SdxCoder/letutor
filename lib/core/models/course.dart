import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Course extends Equatable{
  final String id;
  final String name;

  Course({this.id, this.name });

  Course.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'];
  
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    super.toString();
    return name;
  }

  @override
  List<Object> get props => [this.id, this.name];
}