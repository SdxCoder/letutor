

import 'package:flutter/material.dart';
import 'package:letutor/modules/spash/view_model/splash_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (model)  =>  model.handleStartUpLogic(),
      viewModelBuilder: () => SplashViewModel(),
      builder: (context,SplashViewModel model,child ) =>
        Scaffold(
        body: (model.isBusy) ? Center(child:Text("Loading...")) : Offstage(),
      ),
    );
  }
}