
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:letutor/modules/mod-account/login/views/login_view.dart';
import 'package:letutor/modules/mod-tutor/module_tutor.dart';
import 'package:letutor/modules/mod-user/user_module.dart';
import 'package:letutor/modules/spash/view/splash_screen.dart';

import 'core/core.dart';
import 'core/shared_service/db_service.dart';
import 'core/shared_service/form_validation_service.dart';
import 'main.dart';
import 'modules/mod-account/login/services/auth_service.dart';
import 'modules/mod-account/login/views/sign_up_view.dart';
import 'modules/mod-admin/admin_module.dart';


class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        // Bind services for DI
        Bind((i) => FormValidationService()),
        Bind((i) => AuthService()),
        Bind((i) => UserService()),
        Bind((i) => RBACService()),
        Bind((i) => DbService()),
        Bind((i) => BookingService()),
         
      ];

  @override
  Widget get bootstrap => App();

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => SplashScreen()),
        Router("/login", child: (_, args) => LoginView()),
        Router("/signup", child: (_, args) => SignUpView()),
        Router('/userHome', module: UserModule()),
        Router('/adminHome', module: AdminModule()),
        Router('/tutorHome', module: TutorModule()),
      ];
}
