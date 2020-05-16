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

 
}
