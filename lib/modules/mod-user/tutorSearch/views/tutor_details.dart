

import 'package:flutter/material.dart';
import 'package:letutor/core/core.dart';

class TutorProfileView extends StatelessWidget {
  final Tutor tutor;

  const TutorProfileView({Key key, this.tutor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          _buildSplash(context),
          Expanded(
            child: Text("About"),
          )
        ],
      )),
    );
  }

  Widget _buildSplash(BuildContext context) {
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
        ),
        color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${tutor.name} ${tutor.lastName}",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
