
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class PastBookingCard extends StatelessWidget {
  final Function onTap;

  const PastBookingCard({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: ScreenUtil().setHeight(200),

      ),
    );
  }
}