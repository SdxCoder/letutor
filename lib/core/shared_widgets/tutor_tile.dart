import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/modules/mod-user/book_appointment/views/book_course_view.dart';
import 'package:letutor/modules/mod-user/tutorSearch/views/tutor_details.dart';
import 'package:responsive_builder/responsive_builder.dart';
// import 'package:letutor/screens/book_appointment/form_availability.dart';

import '../core.dart';
import '../models/tutor.dart';

class TutorTile extends StatelessWidget {
  final Tutor tutor;
  final Function onTap;
  final Function onTapBook;

  const TutorTile({Key key, this.tutor, this.onTap, this.onTapBook})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl = 'https://i.imgur.com/pEVEnCs.jpeg';
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => GestureDetector(
        onTap: onTap,
        child: Card(
          margin: EdgeInsets.only(right: 16),
          
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
             // side: BorderSide(color: lightBlackBorderColor, width: 1)
              ),
          elevation: 0,
          color: Colors.white,
          child: Container(
            width: sizingInfo.screenSize.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${tutor.name} ${tutor.lastName}',
                            style: bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Biology',
                            style: bodyText1.copyWith(
                              height: 1,
                              color: lightBlackColor,
                            ),
                          ),
                          ratingBar(
                              initialRating: 3.5, onRatingUpdate: (rating) {}),
                          SizedBox(
                            height: ScreenUtil().setHeight(32),
                          ),
                          Text(
                            'Pricing',
                            style: bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '200 NHL',
                            style: bodyText1.copyWith(
                              height: 1,
                              color: lightBlackColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                      )
                    ],
                  ),
                ),
                // Container(
                //   height: sizingInfo.localWidgetSize.height * 0.4,
                //   foregroundDecoration: BoxDecoration(
                //     color: Colors.white.withOpacity(0.4),
                //   ),
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: NetworkImage(imageUrl), fit: BoxFit.cover),
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //       topRight: Radius.circular(20),
                //     ),
                //   ),
                // ),

                Spacer(),
                GestureDetector(
                  onTap: onTapBook,
                  child: Container(
                    width: ScreenUtil().setWidth(300),
                    height: ScreenUtil().setHeight(150),
                    alignment: Alignment.centerLeft,
                    //  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Center(
                      child: Text(
                        "Book",
                        style: bodyText1.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                // ButtonBar(
                //   alignment: MainAxisAlignment.start,
                //   children: <Widget>[

                //     FlatButton(
                //       onPressed: onTapBook,
                //       child: Text(
                //         "Book",
                //         style: bodyText1.copyWith(color: Colors.blue),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(16),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
