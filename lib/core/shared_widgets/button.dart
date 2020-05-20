import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';




Widget raisedButton({
  String btnText,
  Function onPressed,
}) {
  return  RaisedButton(
    disabledColor: buttonColor.withOpacity(0.5),
    
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)),
    color: buttonColor,
    child:
        Text(btnText, style: TextStyle(color: Colors.white)),
  );
  
  // InkWell(
  //   child: Container(
  //       width: 110,
  //       height: 40,
  //       decoration: BoxDecoration(
  //           gradient:
  //               LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
  //           borderRadius: BorderRadius.circular(6.0),
  //           boxShadow: [
  //             BoxShadow(
  //                 color: Color(0xFF6078ea).withOpacity(.3),
  //                 offset: Offset(0.0, 8.0),
  //                 blurRadius: 8.0)
  //           ]),
  //       child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         onTap: onPressed,
  //         child: Center(
  //           child: Text(btnText,
  //               style: bodyText1.copyWith(
  //                 color:Colors.white
  //               )),
  //         ),
  //       ),
  //     ),),
  // );
}
