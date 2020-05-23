import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:letutor/core/core.dart';


class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _userService = Modular.get<UserService>();

  CurrentUser _currentUser;
  CurrentUser get currentUser => _currentUser;

  Future signUpWithEmailPassword({email, password, firstName, lastName, DateTime dob, phoneNo}) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
       // Create nd Populate current user
       User user =  User(
            uid: authResult.user.uid,
            email: authResult.user.email,
            phoneNo: phoneNo,
            name: firstName + " " + lastName,
            role: Role.user,
            photoUrl: imageUrl,
            dob: dob,
            firstName: firstName,
            lastName: lastName,
            photoPlaceholder: imageUrl, // from storage
          );
          await _userService.createUser(
         user);
      await _populateCurrentUser(authResult.user);
      print("User : " + _currentUser.user.email);
      return authResult.user;
    } catch (e) {
      print("Error : " + e.message);
      return e.message;
    }
  }

  Future sendPasswordResetEmail(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return e.message;
    }
  }

  Future signInWithEmailPassword(email, password) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Populate current user
      await _populateCurrentUser(authResult.user);
      print("User : " + _currentUser.user.email);

      return authResult.user;
    } catch (e) {
       print("Error : " + e.code);
       if(e.code == 'ERROR_USER_NOT_FOUND'){
         return 'There is no user record found corresponding to this email. Please enter the correct email.';
       }

       if(e.code == 'ERROR_WRONG_PASSWORD'){
         return 'The paswword you entered is invalid.';
       }
      return e.message;
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      // Create nd Populate current user
      await _userService.createUser(
        User(
        uid: authResult.user.uid,
        email: authResult.user.email,
        photoUrl: authResult.user.photoUrl ?? imageUrl,
        phoneNo: authResult.user.phoneNumber ?? "",
        name: authResult.user.displayName ?? "",
        role:  Role.user,
        dob: DateTime(2020).toUtc(),
        firstName: "",
        lastName: "",
        photoPlaceholder: imageUrl, // from storage
      ));
      await _populateCurrentUser(authResult.user);
      print("User : " + _currentUser.user.email);

      print("User : " + authResult.user.displayName);
      return authResult.user;
    } on PlatformException {
      return "Something went wrong. Try again";
    }
    catch (e) {
      print("Error : " + e.code);
      return e.message;
    }
  }

  Future signInWithFaceBook() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        try {
          final AuthCredential credentials = FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);
          final authResult = await _auth.signInWithCredential(credentials);

          // Create nd Populate current user
          await _userService.createUser(User(
            uid: authResult.user.uid,
            email: authResult.user.email,
            photoUrl: authResult.user.photoUrl ?? imageUrl,
            phoneNo: authResult.user.phoneNumber ?? "",
            name: authResult.user.displayName ?? "",
            role:  Role.user,
            dob: DateTime(2020).toUtc(),
            firstName: "",
            lastName: "",
            photoPlaceholder: imageUrl, // from storage
          ));

          await _populateCurrentUser(authResult.user);
          print("User : " + _currentUser.user.email);
          return authResult.user;
        } catch (e) {
          return e.message;
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        return "Authentication request cancelled";
        break;
      case FacebookLoginStatus.error:
        return result.errorMessage;
        break;
    }
  }

  Future checkUserLoginStatus() async {
    final firebaseUser = await _auth.currentUser();
    await _populateCurrentUser(firebaseUser);
    return firebaseUser != null;
  }

  Future signOut() async {
    await _auth.signOut();
  }

  Future _populateCurrentUser(FirebaseUser firebaseUser) async {
    if (firebaseUser != null) {
      User user = await _userService.getUser(firebaseUser.uid);
      _currentUser = CurrentUser.create(firebaseUser: firebaseUser, user: user);
    }
  }
}
