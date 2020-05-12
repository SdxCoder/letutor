import 'package:flutter_modular/flutter_modular.dart';

import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

import 'package:stacked/stacked.dart';

class AuthViewModel extends BaseViewModel {
  final _authService = Modular.get<AuthService>();
  final validationService = Modular.get<FormValidationService>();
  final _rbacService = Modular.get<RBACService>();

  
  Future signUpWithEmailAndPassword(
    {String email,
    String password,
    String firstName,
    String lastName,
    String phoneNo,
    DateTime dob,}
  ) async {
    setBusy(true);
    var result = await _authService.signUpWithEmailPassword(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNo: phoneNo,
        dob: dob);
    setBusy(false);
    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      Modular.to.pushNamed(Routes.userHome);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    setBusy(true);
    await Future.delayed(Duration(seconds: 4));
    var result = await _authService.signInWithEmailPassword(email, password);
    setBusy(false);
    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      _rbacService.getRoleBasedAccess();
    }
  }

  Future signInWithGoogle() async {
    setBusy(true);
    var result = await _authService.signInWithGoogle();
    setBusy(false);
    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      _rbacService.getRoleBasedAccess();
    }
  }

  Future signInWithFacebook() async {
    setBusy(true);
    var result = await _authService.signInWithFaceBook();
    setBusy(false);
    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      _rbacService.getRoleBasedAccess();
    }
  }

  Future sendPasswordResetEmail(String email) async {
   // setBusy(true);
    var result = await _authService.sendPasswordResetEmail(email);
   // setBusy(false);
    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      await showDialogBox(
          title: "Success",
          description: "Password reset link sent to \nEmail: $email");
    }
  }
}
