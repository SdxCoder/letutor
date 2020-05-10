import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:letutor/core/utils/colors.dart';

class CategoryTile extends StatefulWidget {
  final String id;
  final String category;
  final bool isSelected;
  final Function(String category) onTap;
  CategoryTile(
      {@required this.category,
      @required this.id,
      @required this.isSelected,
      @required this.onTap});

  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.id),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setSp(40), vertical: 0),
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: widget.isSelected ? Color(0xffFFD0AA) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            width: 1.0,
            color: widget.isSelected
                ? Colors.orange.withOpacity(0.5)
                : lightBlackBorderColor,
          ),
        ),
        child: Text(
          widget.category,
          style: bodyText2.copyWith(
            color: widget.isSelected ? Color(0xffFC9535) : lightBlackColor
          ),
          // TextStyle(
          //     color: widget.isSelected ? Color(0xffFC9535) : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}
