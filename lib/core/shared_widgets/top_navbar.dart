import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:letutor/modules/mod-user/userprofile/views/user_profile_view.dart';
import '../utils/colors.dart';

class TopNavBar extends StatelessWidget {
  final List<Widget> actions;
  final List<Widget> title;

  const TopNavBar({
    Key key,
    this.title = const [],
    this.actions = const [],
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: title ?? [
              Text(
                'Find',
                style: headline6.copyWith(),
              ),
              Text('Tutor',
                  style: headline5.copyWith(
                      height: 1, fontWeight: FontWeight.bold)),
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
                    Modular.get<AuthService>()
                        .currentUser
                        .user
                        .photoPlaceholder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
