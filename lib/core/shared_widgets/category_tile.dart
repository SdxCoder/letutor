import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';

class CapsuleTile extends StatelessWidget {
  final String id;
  final String title;
  final bool isSelected;
  final Color titleColor;
  final Function(String category) onTap;
  final Function onTapCancelIcon;

  final Icon cancelIcon;
  CapsuleTile(
      {@required this.title,
       this.id,
       this.isSelected  = false,
       this.onTap, this.cancelIcon, this.onTapCancelIcon, this.titleColor = lightBlackColor});

  @override
  Widget build(BuildContext context) {
    return Row(

      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: (onTap != null) ? () => onTap(id) : null,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(40), vertical: 0),
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xffFFD0AA) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                width: 1.0,
                color: isSelected
                    ? Colors.orange.withOpacity(0.5)
                    : lightBlackBorderColor,
              ),
            ),
            child: Text(
              title,
              style: bodyText2.copyWith(
                color: isSelected ? Color(0xffFC9535) : titleColor
              ),
              // TextStyle(
              //     color: widget.isSelected ? Color(0xffFC9535) : Color(0xffA1A1A1)),
            ),
          ),
        ),
        SizedBox(width: 4),
        (cancelIcon != null) ? GestureDetector(
          onTap: onTapCancelIcon,
          child: cancelIcon) : Offstage()
      ],
    );
  }
}
