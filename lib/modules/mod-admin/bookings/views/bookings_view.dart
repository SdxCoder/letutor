import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/shared_widgets/app_bar.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

class BookingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title:
              Text("Bookings", style: subtitle1.copyWith(color: Colors.black)),
          profileImageUrl:
              Modular.get<AuthService>().currentUser.user.photoUrl ??
                  Modular.get<AuthService>().currentUser.user.photoPlaceholder),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBookings(context),
      ),
    );
  }

  Widget _buildBookings(context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, int index) {
        return PastBookingCard(
          actions: [
            Container(
              height: ScreenUtil().setHeight(60),
              width: ScreenUtil().setWidth(170),
              child: RaisedButton(
                padding: EdgeInsets.zero,
                elevation: 0,
               color: Colors.blue,
                onPressed: (){}, child: Text("Confirm", style:bodyText2.copyWith(
                  color:Colors.white
                ))),
            )
          ],
          onTap: () {},
        );
      },
    );
  }
}
