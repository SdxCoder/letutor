import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';import 'package:stacked/stacked.dart';

import '../../../../core/core.dart';


class AppointmentsView extends StatelessWidget {
  const AppointmentsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: buildAppBar(
            title: Text("My Bookings",
                style: subtitle1.copyWith(color: Colors.black)),
            context: context,
            bottom: TabBar(
                labelColor: lightColor,
                labelStyle: subtitle1.copyWith(fontWeight: FontWeight.w700),
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                tabs: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Tab(
                        text: "Upcoming",
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Tab(
                        text: "Past",
                      ))
                ]),
            profileImageUrl: Modular.get<AuthService>()
                    .currentUser
                    .user
                    .photoUrl ??
                Modular.get<AuthService>().currentUser.user.photoPlaceholder),
        body: TabBarView(children: [_upcoming(), _past()]),
      ),
    );
  }

  Widget _upcoming() {
    return ViewModelBuilder<BookingsViewModel>.reactive(
      viewModelBuilder: () => BookingsViewModel(),
      onModelReady: (model){
        model.listenToBookingsByUser(flag: true);
      },
      builder: (context, model, child,){
        return model.bookings.isEmpty ? 
       empltyList():
        UpcomingBooking(model:model);
      }, 
    );
  }

  Widget _past() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BookingsViewModel(),
      onModelReady: (model){
        model.listenToBookingsByUser(flag : false);
      },
      builder: (context, model, child,){
        return model.bookings.isEmpty ? 
       empltyList(): PastBooking(model:model);
      }, 
    );
  }

}
