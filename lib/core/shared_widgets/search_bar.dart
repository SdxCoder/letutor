import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Function(String) onSubmit;
  final Function onEditingComplete; 

  const SearchBar({Key key, this.controller, this.onChanged, this.onSubmit, this.onEditingComplete}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => Container(
        height: 35,
        width: sizingInfo.screenSize.width * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextFormField(
          cursorWidth: 1,
          cursorColor: lightBlackColor,
          autofocus: false,
          controller: widget.controller,
          style: bodyText2.copyWith(
            color: lightBlackColor,
            decoration: TextDecoration.none
          ),
          onFieldSubmitted: widget.onSubmit,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
         
          decoration: InputDecoration(
            
              hintText: "Search",
              hintStyle: bodyText2.copyWith(fontWeight: FontWeight.w300),
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              prefixIcon: Icon(
                Icons.search,
                size: ScreenUtil().setSp(45),
                color: lightBlackColor,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
