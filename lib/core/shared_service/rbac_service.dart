

import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:letutor/core/core.dart';

class RBACService{
  final authService = Modular.get<AuthService>();
  
   void getRoleBasedAccess() {
    User user = authService.currentUser.user;

    if (user.role == 'admin') {
      print("admin logged in");
      Modular.to.pushReplacementNamed(Routes.adminHome);
    } else if (user.role == 'tutor') {
      print("tutor logged in");
      Modular.to.pushReplacementNamed(Routes.tutorHome);
    } else {
      print("user logged in");
      Modular.to.pushReplacementNamed(Routes.userHome);
    }
  }
}