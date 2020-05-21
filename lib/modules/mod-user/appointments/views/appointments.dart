import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:letutor/modules/mod-user/appointments/view_model/appointments_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/core.dart';
import 'booking_detail.dart';

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
        model.listenToBookings(flag: true);
      },
      builder: (context, model, child,){
        return UpcomingBooking(model:model);
      }, 
    );
  }

  Widget _past() {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BookingsViewModel(),
      onModelReady: (model){
        model.listenToBookings(flag : false);
      },
      builder: (context, model, child,){
        return PastBooking(model:model);
      }, 
    );
  }

  Widget _pastBookings(context, AppointmentsViewModel model) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height * 3));
      },
      blendMode: BlendMode.dstIn,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return PastBookingCard(
            actions: [
              Text("Status", style: bodyText2.copyWith(color: lightBlackColor)),
              Text("Confirmed",
                  style: bodyText2.copyWith(height: 1, color: Colors.blue)),
            ],
            onTap: () {
              String id = "1"; // This id is of unconfirmed booking
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookingDetailView(
                          heroTag: index.toString(),
                        ),
                    settings: RouteSettings(
                        name: Routes.bookingDetail.replaceAll(":id", id))),
              );
            },
          );
        },
      ),
    );
  }

  Widget _upcomingBookings(context, AppointmentsViewModel model) {
    model.listenToBookings(flag: false);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(bottom: ScreenUtil().setSp(20)),
          //   child: Text(
          //     "Welcome Back!",
          //     style: headline6.copyWith(
          //       color : lightColor
          //     )
          //   ),
          // ),
          // Text(
          //   Modular.get<AuthService>().currentUser.user.name,
          //   style: headline5.copyWith(
          //     fontWeight: FontWeight.bold
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setSp(40)),
            child: BookingCard(
              actions: <Widget>[
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Pending",
                      style: bodyText1.copyWith(color: Colors.blue),
                    ))
              ],
              heroTag: appointmentsHeroTag,
              imageUrl: Modular.get<AuthService>().currentUser.user.photoUrl ??
                  imageUrl,
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
            child: Text("Next lessons",
                style: subtitle1.copyWith(
                  color: Color(0xFF7283B5),
                )),
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
                  itemCount: model.bookings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final booking = model.bookings[index];
                    return UpcomingBookingCard(
                      avatarImage: imageUrl,
                      title: booking.user.name,
                      subtitle: "09 Aug 2020, 08am - 10am",
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
    );
  }
}
