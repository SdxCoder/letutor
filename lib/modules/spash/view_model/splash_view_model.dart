

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class SplashViewModel extends BaseViewModel{
  final _auth = FirebaseAuth.instance;
  final authService = Modular.get<AuthService>();

  Future handleStartUpLogic() async {
    setBusy(true);
    final bool loggedIn = await authService.checkUserLoginStatus();
    setBusy(false);
    if(loggedIn){
      Modular.to.pushReplacementNamed(Routes.home);
    }
    else{
      Modular.to.pushNamed(Routes.login);
    }
  }
}