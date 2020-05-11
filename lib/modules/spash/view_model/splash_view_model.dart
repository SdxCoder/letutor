import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  final authService = Modular.get<AuthService>();

  Future handleStartUpLogic() async {
    setBusy(true);
    final bool loggedIn = await authService.checkUserLoginStatus();
    setBusy(false);
    if (loggedIn) {
      _getRoleBasedAccess();
    } else {
      Modular.to.pushNamed(Routes.login);
    }
  }

  void _getRoleBasedAccess() {
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
