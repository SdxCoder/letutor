import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';

class TutorBookingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: Text("Bookings", style: subtitle1.copyWith(color:Colors.black)),
        profileImageUrl: Modular.get<AuthService>().currentUser.user.photoUrl ??
            Modular.get<AuthService>().currentUser.user.photoPlaceholder,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, int index) {
              return PastBookingCard(
                actions: <Widget>[
                  Text("Status",
                      style: bodyText2.copyWith(color: lightBlackColor)),
                  Text("Confirmed",
                      style: bodyText2.copyWith(
                        height: 1,
                      )),
                ],
                onTap: () {},
              );
            }),
      ),
    );
  }
}
