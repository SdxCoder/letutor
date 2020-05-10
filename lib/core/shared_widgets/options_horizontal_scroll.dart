import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';

// placeholder, use state instead
const selectedCategory = "Chemistry";

class OptionsHorizontalScroll extends StatelessWidget {
  const OptionsHorizontalScroll(
      {Key key, @required this.title, @required this.options})
      : super(key: key);

  final String title;
  final ListView options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: subtitle1.copyWith(
            color: lightColor
          ),
        ),
        SizedBox(height: 8,),
        Container(
            height: ScreenUtil().setSp(100),
            width: MediaQuery.of(context).size.width,
            child: options),
      ],
    );
  }
}
