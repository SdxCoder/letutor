import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../core.dart';

class PastBookingCard extends StatelessWidget {
  final Function onTap;

  const PastBookingCard({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => GestureDetector(
        onTap: onTap,
        child: Card(
          color: Colors.white,
  elevation: 1,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // shadowColor: Colors.grey.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            // side: BorderSide(
            //   color : lightBlackBorderColor

            // )
          ),
          child: Container(
            height: sizingInfo.screenSize.height * 0.2,
            padding: EdgeInsets.all(16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Date",
                          style: bodyText2.copyWith(color: lightBlackColor)),
                      Text("03 August 2020",
                          style: bodyText2.copyWith(
                            height: 1,
                          )),
                      Spacer(),
                      Text("Tutor",
                          style: bodyText2.copyWith(color: lightBlackColor)),
                      Text("Loius Patterson",
                          style: bodyText2.copyWith(
                            height: 1,
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Time",
                          style: bodyText2.copyWith(color: lightBlackColor)),
                      Text("02am - 04am",
                          style: bodyText2.copyWith(
                            height: 1,
                          )),
                      Spacer(),
                      Text("Course",
                          style: bodyText2.copyWith(color: lightBlackColor)),
                      Text("Boilogy",
                          style: bodyText2.copyWith(
                            height: 1,
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Pricing",
                          style: bodyText2.copyWith(color: lightBlackColor)),
                      Text("200NHL",
                          style: bodyText2.copyWith(
                            height: 1,
                          )),
                      Spacer(),
                      Text("Status",
                          style: bodyText2.copyWith(color: lightBlackColor)),
                      Text("Confirmed",
                          style: bodyText2.copyWith(
                              height: 1, color: Colors.blue)),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
