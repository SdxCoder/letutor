import 'package:flutter/material.dart';
import 'package:letutor/modules/mod-user/book_appointment/views/book_course_view.dart';
import 'package:letutor/modules/mod-user/tutorSearch/views/tutor_details.dart';
// import 'package:letutor/screens/book_appointment/form_availability.dart';



import '../core.dart';
import '../models/tutor.dart';

class TutorTile extends StatelessWidget {
  final Tutor tutor;
  final Function onTap;
  final Function onTapBook;

  const TutorTile({Key key, this.tutor, this.onTap, this.onTapBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl = 'https://i.imgur.com/pEVEnCs.jpeg';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xffFFEEE0), borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            SizedBox(
              width: 17,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${tutor.name} ${tutor.lastName}',
                  style: TextStyle(color: Color(0xffFC9535), fontSize: 19),
                ),
                SizedBox(
                  height: 2,
                ),
                // Text(
                //   "Diseño",
                //   style: TextStyle(fontSize: 15),
                // )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: onTapBook,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                decoration: BoxDecoration(
                    color: Color(0xffFBB97C),
                    borderRadius: BorderRadius.circular(13)),
                child: Text(
                  "Book",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
