import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import '../core.dart';

class UpcomingBookingCard extends StatelessWidget {
  final String heroTag;
  final Function onTap;
   final String title;
  final String subtitle;
  final Widget trailing;
  final String avatarImage;
  
  const UpcomingBookingCard({
    Key key,
    this.onTap,
    this.heroTag,@required this.title, @required this.subtitle, this.trailing, @required this.avatarImage,
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
                  backgroundImage: NetworkImage(avatarImage),
                ),
              ),
          title: Text(title),
          subtitle: Text(subtitle, style: bodyText1,),
          trailing: this.trailing,
          // trailing: Icon(Icons.more_vert),
          onTap: onTap,
        ),
      ),
    );
  }
}
