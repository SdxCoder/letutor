import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:letutor/core/utils/colors.dart';

import '../core.dart';

class TimeSlotTile extends StatefulWidget {
  final slot;
  final Color color;
  final Color titleColor;
  final Function(dynamic) onSelection;
  final Function(dynamic) onCancelSelection;

  final Widget content;

  TimeSlotTile({
    Key key,
    this.slot,
    this.titleColor,
    this.onSelection,
    this.onCancelSelection,
    this.content,
    this.color,
  }) : super(key: key);

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
            if (widget.color != null) {
              widget.onSelection(widget.slot);
            } else {
               if (_isSelected == true) {
                widget.onSelection(widget.slot);
              }

              if (_isSelected == false) {
                widget.onCancelSelection(widget.slot);
              }

            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.26,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(10),
                vertical: ScreenUtil().setSp(40)),
            decoration: BoxDecoration(
              color: widget.color ??
                  (_isSelected ? Colors.blue : Colors.transparent),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.0,
                color: (widget.color != null)
                    ? lightBlackBorderColor
                    : (_isSelected ? Colors.blue : lightBlackBorderColor),
              ),
            ),
            child: widget.content ??
                Text(
                  widget.slot.timeSlot,
                  style: bodyText2.copyWith(
                      fontSize: ScreenUtil().setSp(30),
                      color: (widget.color != null)
                          ? widget.titleColor
                          : (_isSelected ? Colors.white : widget.titleColor)),
                ),
          ),
        ),
      ],
    );
  }
}

class BookedTimeSlot extends StatelessWidget {
  final String slot;

  const BookedTimeSlot({Key key, this.slot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width * 0.26,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setSp(10),
                vertical: ScreenUtil().setSp(40)),
           // margin: EdgeInsets.only(left: 8, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1.0,
                color:  Colors.red.withOpacity(0.5),
              ),
            ),
            child: 
                Text(
                  slot,
                  style: bodyText2.copyWith(
                      fontSize: ScreenUtil().setSp(30),
                      color:  Colors.red.withOpacity(0.5)),
                ),
          );
  }
}

