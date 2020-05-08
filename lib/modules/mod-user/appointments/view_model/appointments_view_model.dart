

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class AppointmentsViewModel extends BaseViewModel{
   final _authService = Modular.get<AuthService>();

  CurrentUser _currentUser = Modular.get<AuthService>().currentUser;
  CurrentUser get currentUser  => _currentUser;

}