import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TopicCard extends StatelessWidget {
  TopicCard({this.collection, this.index, this.onPressed});

  final List<String> collection;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo)=>
          Container(
        margin: EdgeInsets.only(
          top: 3.0,
          bottom: 3.0,
          left: 20.0,
          right: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xFF21BFBD),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 8.0,
            bottom: 8.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: sizingInfo.screenSize.width*0.7,
                child: Text(
                  collection[index],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: onPressed,
              )
            ],
          ),
        ),
      ),
    );
  }
}
