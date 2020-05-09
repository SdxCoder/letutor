import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/constants/constants.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:letutor/modules/mod-user/userprofile/views/user_profile_view.dart';

Widget buildAppBar(
    {BuildContext context,
    Widget title,
    List<Widget> actions = const [],
    String profileImageUrl,
    PreferredSizeWidget bottom
   }) {
  return AppBar(

    elevation: 0.0,
    backgroundColor: Colors.white,
    title: title,
    centerTitle: true,
    bottom: bottom,
    actions: <Widget>[
      ...actions,
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfileView()));
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              profileImageUrl,
            ),
          ),
        ),
      )
    ],
  );
}
