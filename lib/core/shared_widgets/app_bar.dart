import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:letutor/modules/mod-user/userprofile/views/user_profile_view.dart';

Widget buildAppBar(
    {BuildContext context,
    Widget title,
    List<Widget> actions = const [],
    bool centerTitle= true,
    Widget leading,
    Color backgroundColor = Colors.white,
    bool automaticallyImplyLeading = false,
    String profileImageUrl,
    PreferredSizeWidget bottom
   }) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: backgroundColor,
    title: title,
    centerTitle: centerTitle,
    leading: leading,
    iconTheme: IconThemeData(
      color: Colors.black,
      size: ScreenUtil().setSp(45)
    ),
    actionsIconTheme: IconThemeData(
      color:Colors.black,
      size: ScreenUtil().setSp(45)
    ),
    automaticallyImplyLeading: automaticallyImplyLeading,
    bottom: bottom,
    actions: <Widget>[
      ...actions,
      (profileImageUrl != null) ? Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserProfileView()));
          },
          child:  CircleAvatar(
            backgroundImage: NetworkImage(
              profileImageUrl,
            ) ,
          ) ,
        ),
      ) : Offstage()
    ],
  );
}
