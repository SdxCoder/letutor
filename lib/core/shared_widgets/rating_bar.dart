import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';

Widget ratingBar({double initialRating, Function onRatingUpdate}){
  return RatingBar(
   initialRating: initialRating,
   minRating: 1,
   direction: Axis.horizontal,
   itemSize: ScreenUtil().setSp(45),
   allowHalfRating: true,
   itemCount: 5,
   itemPadding: EdgeInsets.only(right : 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: onRatingUpdate,
);
}