
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String _uid;
  String _firstName;
  String _lastName;
  String _name;
  String _phoneNo;
  String _photoUrl;
  String _photoPlaceholder;
  DateTime _dob;
  String _role;
  String _email;
  String _bookingStatus ;

  User(
      {String uid,
      String firstName,
      String lastName,
      String name,
      String phoneNo,
      String photoUrl,
      String photoPlaceholder,
      DateTime dob,
      String role,
      String bookingStatus,
      String email}) {
    this._uid = uid;
    this._firstName = firstName;
    this._lastName = lastName;
    this._name = name;
    this._phoneNo = phoneNo;
    this._photoUrl = photoUrl;
    this._photoPlaceholder = photoPlaceholder;
    this._dob = dob;
    this._role = role;
    this._email = email;
    this._bookingStatus = bookingStatus;
  }

  String get uid => _uid;
  set uid(String uid) => _uid = uid;
  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get name => _name;
  set name(String name) => _name = name;
  String get phoneNo => _phoneNo;
  set phoneNo(String phoneNo) => _phoneNo = phoneNo;
  String get photoUrl => _photoUrl;
  set photoUrl(String photoUrl) => _photoUrl = photoUrl;
  String get photoPlaceholder => _photoPlaceholder;
  set photoPlaceholder(String photoPlaceholder) =>
      _photoPlaceholder = photoPlaceholder;
  DateTime get dob => _dob;
  set dob(DateTime dob) => _dob = dob;
  String get role => _role;
  set role(String role) => _role = role;
  String get email => _email;
  set email(String email) => _email = email;
  String get bookingStatus => _bookingStatus;
  set bookingStatus(String bookingStatus) => _bookingStatus = bookingStatus;

  User.fromJson(Map<String, dynamic> json) {
   
    _uid = json['uid'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _name = json['name'];
    _phoneNo = json['phoneNo'];
    _photoUrl = json['photoUrl'];
    _photoPlaceholder = json['photoPlaceholder'];
    _dob = json['dob'].toDate();
    _role = json['role'];
    _email = json['email'];
    _bookingStatus = json['bookingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['uid'] = this._uid;
    data['firstName'] = this._firstName;
    data['lastName'] = this._lastName;
    data['name'] = this._name;
    data['phoneNo'] = this._phoneNo;
    data['photoUrl'] = this._photoUrl;
    data['photoPlaceholder'] = this._photoPlaceholder;
    data['dob'] = this._dob.toUtc();
    data['role'] = this._role;
    data['email'] = this._email;
    data['bookingStatus'] = this._bookingStatus;
    return data;
  }
}
