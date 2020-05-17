import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letutor/core/utils/colors.dart';

class TimeSlotTile extends StatefulWidget {

  final String title;
  final Color titleColor;
  final Function(String slot) onTap;
  final Function(bool) onSelection;
  final Function(bool) onCancelSelection;
  final Widget content;

  TimeSlotTile({Key key, this.title, this.titleColor, this.onTap, this.onSelection, this.onCancelSelection, this.content})
      : super(key: key);

  @override
  _TimeSlotTileState createState() => _TimeSlotTileState();
}

class _TimeSlotTileState extends State<TimeSlotTile> {
  bool _isSelected = false;
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isSelected = !_isSelected;
            });

            widget.onTap(this.widget.title);
            if(_isSelected == true){
              widget.onSelection(_isSelected);
            }

            if(_isSelected == false){
              widget.onCancelSelection(_isSelected);
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width*0.26,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(15), vertical: ScreenUtil().setSp(40)),
            margin: EdgeInsets.only(left: 8, bottom: 8),
            decoration: BoxDecoration(
              color: _isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.0,
                color: _isSelected ? Colors.blue : lightBlackBorderColor,
              ),
            ),
            child: widget.content ?? Text(
              widget.title,
              style: bodyText2.copyWith(
                fontSize: ScreenUtil().setSp(30),
                  color: _isSelected ? Colors.white : widget.titleColor),
            ),
          ),
        ),
      ],
    );
  }
}
