import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core.dart';

class UpcomingBookingCard extends StatelessWidget {
  final String heroTag;
  final Function onTap;

  const UpcomingBookingCard({
    Key key,
    this.onTap,
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
          child: Card(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: ListTile(
        // contentPadding: EdgeInsets.all(ScreenUtil().setSp(20)),
          leading:  Hero(
                tag: heroTag,
                child: CircleAvatar(
                 radius: ScreenUtil().setSp(60),
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
          title: Text('Diego Gallegos'),
          subtitle: Text('09 Jan 2020, 8am - 10am', style: bodyText1,),
          // trailing: Icon(Icons.more_vert),
          onTap: onTap,
        ),
      ),
    );
  }
}
