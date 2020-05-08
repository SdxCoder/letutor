import 'package:flutter/material.dart';

// placeholder, use state instead
const selectedCategory = "Chemistry";

class OptionsHorizontalScroll extends StatelessWidget {
  const OptionsHorizontalScroll(
      {Key key, @required this.title, @required this.options})
      : super(key: key);

  final String title;
  final ListView options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              color: Colors.black87.withOpacity(0.8),
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: options),
        ),
      ],
    );
  }
}
