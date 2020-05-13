


import 'package:flutter/material.dart';
import 'package:letutor/core/utils/colors.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final IconData icon;

  final Widget value;

  const InfoSection({Key key, this.title, this.icon, this.value,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  title,
                  style: bodyText1,
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: value,
          ),
         
        ],
      ),
    );
  }
}
