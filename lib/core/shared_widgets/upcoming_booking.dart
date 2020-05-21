

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:letutor/modules/mod-user/appointments/views/booking_detail.dart';

import '../core.dart';

class UpcomingBooking extends StatelessWidget {
  final model;

  const UpcomingBooking({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (model.isBusy) ? 
    Center(child: CircularProgressIndicator())
    :
    _upcomingBookings(context, model);
  }


  Widget _upcomingBookings(context, BookingsViewModel model) {

    final firstBooking = model.bookings.first;
  
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 24.0,
      ),
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setSp(40)),
            child: BookingCard(
              booking: firstBooking,
              actions: <Widget>[
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      firstBooking.status,
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
          (model.bookings.length <= 1) ? Offstage():
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
                    if(booking == firstBooking){
                      return Offstage();
                    }
                    return UpcomingBookingCard(
                      avatarImage: imageUrl,
                      title: booking.user.name,
                      subtitle: "${booking.slot.timeSlot}",
                    
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