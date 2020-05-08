import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

import '../../../../core/core.dart';
import 'booking_detail.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
              child: Text(
                "Welcome Back!",
                style: headline6.copyWith(
                  color : lightColor
                )
              ),
            ),
            Text(
              Modular.get<AuthService>().currentUser.user.name,
              style: headline5.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setSp(40)),
              child: BookingCard(
                heroTag: appointmentsHeroTag,
                imageUrl: Modular.get<AuthService>().currentUser.user.photoUrl ?? imageUrl,
                onTap: () {
                  String id = "1"; // This id is of unconfirmed booking
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingDetailView(
                              heroTag: appointmentsHeroTag,
                            ),
                        settings: RouteSettings(
                            name: Routes.bookingDetail.replaceAll(":id", id))),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setSp(20)),
              child: Text(
                "Next lessons",
                style: subtitle1.copyWith(
                  color: Color(0xFF7283B5),
                )
              ),
            ),
            Expanded(
              child: Container(
              //  height: 300.0,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height * 3));
                  },
                  blendMode: BlendMode.dstIn,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return UpcomingBookingCard(
                        heroTag: index.toString(),
                        onTap: () {

                          String id = "1"; // This id is of unconfirmed booking
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingDetailView(
                                      heroTag: index.toString(),
                                    ),
                                settings: RouteSettings(
                                    name: Routes.bookingDetail
                                        .replaceAll(":id", id))),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
