import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/app_module.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:letutor/service/locator.dart';


void main() {
  setupLocator();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context){
        return ModularApp(module: AppModule(),);
      },
    ));

}

class App extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
  //   ScreenUtil.init(context, allowFontScaling : true);
    return MaterialApp(
       builder: DevicePreview.appBuilder,
          theme: ThemeData(
            fontFamily: "Poppins-Medium",
            primarySwatch: Colors.blue,
           scaffoldBackgroundColor: Color(0xFFF3F6FE),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: Color(0xFF838383),
                fontWeight: FontWeight.w600,
              ),
              contentPadding: EdgeInsets.all(0.0),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Modular.initialRoute,
          navigatorKey: Modular.navigatorKey,
          onGenerateRoute: Modular.generateRoute,
       
      
    );
  }
}
