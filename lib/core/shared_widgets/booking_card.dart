import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';


import '../core.dart';

class BookingCard extends StatelessWidget {
  final heroTag;
  final String imageUrl;
  final Function onTap;
  
  const BookingCard({
    Key key, this.heroTag, this.onTap, this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    ScreenUtil.init(context, allowFontScaling: true);
    
 
    return Container(
      //  height: MediaQuery.of(context).size.height*0.35,
         height: ScreenUtil().setHeight(550),
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0, 1),
              ),
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: Offset(0, 1),
                  blurRadius: 10.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            cardHeader(),
            cardContent(context),
          ],
        ));
  }

  Widget cardContent(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(ScreenUtil().setSp(40),),
        //height: ScreenUtil().setHeight(200),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: heroTag,
                  child: Material(
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: ScreenUtil().setSp(120),
                            height: ScreenUtil().setSp(120),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setSp(40),),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text(
                              "Louis",
                              style: TextStyle(fontSize: ScreenUtil().setSp(40),),
                            ),
                          ]),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Patterson",
                              style: TextStyle(fontSize: ScreenUtil().setSp(40),),
                            ),
                          ),
                        ],
                      )),
                ),
                IconButton(
                  iconSize: ScreenUtil().setSp(60),
                  icon :Icon(
                  
                  Icons.info
                ), onPressed: onTap,)
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.all(ScreenUtil().setSp(10),),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: <Widget>[
                  
            //       Container(
            //         padding: EdgeInsets.symmetric(
            //          horizontal: ScreenUtil().setSp(20),
            //           vertical: ScreenUtil().setSp(20),
            //         ),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10.0),
            //           color: Colors.blue[300],
            //         ),
            //         child:
            //             Text("Confirm", style: TextStyle(color: Colors.white)),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget cardHeader() {
    return Container(
      padding: EdgeInsets.all(ScreenUtil().setSp(40)),
      // height: ScreenUtil().setHeight(200),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Appointment Request",
              style: TextStyle(
                color: Color(0xFF98C4FF),
                fontSize: ScreenUtil().setSp(30),
                fontWeight: FontWeight.w600,
              ),
            ),
            // Icon(
            //   Icons.more_vert,
            //   color: Colors.white,
            //   size: ,
            // )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.0),
          child: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.timer,
                color: Colors.white,
                size:   ScreenUtil().setSp(40),
              ),
            ),
            Text(
              "12 Jan 2020, 8am - 10am",
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(40),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
