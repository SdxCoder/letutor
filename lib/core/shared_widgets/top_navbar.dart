import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:letutor/modules/mod-user/userprofile/views/user_profile_view.dart';
import '../utils/colors.dart';

Widget findTutorNav({
  BuildContext context,
  Function onTapSearch,
  List<Widget> actions = const [],
}) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Find',
            style: headline5.copyWith(),
          ),
          Text('Tutor',
              style:
                  headline4.copyWith(height: 1, fontWeight: FontWeight.bold)),
        ],
      ),
      Spacer(),
      ...actions,
      // Padding(
      //   padding: EdgeInsets.all(8),
      //   child: IconButton(
      //       iconSize: ScreenUtil().setSp(60),
      //       icon: Icon(Icons.search),
      //       onPressed: onTapSearch),
      // ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserProfileView()));
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            Modular.get<AuthService>().currentUser.user.photoUrl ??
                Modular.get<AuthService>().currentUser.user.photoPlaceholder,
          ),
        ),
      ),
    ],
  );
}
