import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel {
  final _authService = Modular.get<AuthService>();
  final _rbacService = Modular.get<RBACService>();

  Future handleStartUpLogic() async {
    setBusy(true);
    final bool loggedIn = await _authService.checkUserLoginStatus();
    setBusy(false);
    if (loggedIn) {
      _rbacService.getRoleBasedAccess();
    } else {
      Modular.to.pushNamed(Routes.login);
    }
  }

  void _getRoleBasedAccess() {
    User user = _authService.currentUser.user;

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
