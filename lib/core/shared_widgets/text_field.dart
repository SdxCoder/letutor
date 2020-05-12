import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';

Widget textField({
  String title,
  TextEditingController controller,
  String Function(String) validator,
  Function onFieldSubmit,
  String hintText,
  Function onTapIcon,
  IconData iconData,
}) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
    ),
    child: TextFormField(
      validator: validator,
      cursorWidth: 1,
      cursorColor: lightBlackColor,
      autofocus: false,
      controller: controller,
      style: bodyText2.copyWith(
          decoration: TextDecoration.none),
      onFieldSubmitted: onFieldSubmit,
      decoration: InputDecoration(
          labelText: title,
          labelStyle: bodyText2.copyWith(
            color:lightBlackColor
          ),
          hintText: hintText,
          hintStyle: bodyText2.copyWith(fontWeight: FontWeight.w300),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          
           suffixIcon: GestureDetector(
            onTap: onTapIcon,
            child: Icon(
              iconData,
              size: ScreenUtil().setSp(45),
              color: Colors.black,
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none)),
    ),
  );
}
