import 'package:flutter/material.dart';
import 'package:letutor/core/utils/colors.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TopicCard extends StatelessWidget {
  TopicCard({this.collection, this.index, });

  final List<String> collection;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: sizingInfo.screenSize.width * 0.7,
                  child: Text(
                    collection[index],
                    style: bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
