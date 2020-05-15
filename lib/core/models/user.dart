

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String name;
  final String phoneNo;
  final String photoUrl;
  final String photoPlaceholder;
  final DateTime dob;
  final String role;
  final String email;


  User(
      {this.uid,
      this.firstName,
      this.lastName,
      this.name,
      this.phoneNo,
      this.photoUrl,
      this.photoPlaceholder,
      this.dob,
      this.role,

      this.email});

  // String get uid => _uid;
  // set uid(String uid) => _uid = uid;
  // String get firstName => _firstName;
  // set firstName(String firstName) => _firstName = firstName;
  // String get lastName => _lastName;
  // set lastName(String lastName) => _lastName = lastName;
  // String get name => _name;
  // set name(String name) => _name = name;
  // String get phoneNo => _phoneNo;
  // set phoneNo(String phoneNo) => _phoneNo = phoneNo;
  // String get photoUrl => _photoUrl;
  // set photoUrl(String photoUrl) => _photoUrl = photoUrl;
  // String get photoPlaceholder => _photoPlaceholder;
  // set photoPlaceholder(String photoPlaceholder) =>
  //     _photoPlaceholder = photoPlaceholder;
  // DateTime get dob => _dob;
  // set dob(DateTime dob) => _dob = dob;
  // String get role => _role;
  // set role(String role) => _role = role;
  // String get email => _email;
  // set email(String email) => _email = email;
  // String get bookingStatus => _bookingStatus;
  // set bookingStatus(String bookingStatus) => _bookingStatus = bookingStatus;

  User.fromJson(Map<String, dynamic> json) :
   
    uid = json['uid'],
    firstName = json['firstName'],
    lastName = json['lastName'],
    name = json['name'],
    phoneNo = json['phoneNo'],
    photoUrl = json['photoUrl'],
    photoPlaceholder = json['photoPlaceholder'],
    dob = json['dob'].toDate(),
    role = json['role'],
    email = json['email'];

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['uid'] = this.uid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['name'] = this.name;
    data['phoneNo'] = this.phoneNo;
    data['photoUrl'] = this.photoUrl;
    data['photoPlaceholder'] = this.photoPlaceholder;
    data['dob'] = this.dob.toUtc();
    data['role'] = this.role;
    data['email'] = this.email;
    return data;
  }
}
