import 'package:firebase_auth/firebase_auth.dart';
import 'package:letutor/core/models/user.dart';

class CurrentUser {
  final FirebaseUser firebaseUser;
  final User user;

  const CurrentUser._(this.firebaseUser, this.user );
  factory CurrentUser.create({FirebaseUser firebaseUser, User user}) => CurrentUser._(firebaseUser,  user);

}

