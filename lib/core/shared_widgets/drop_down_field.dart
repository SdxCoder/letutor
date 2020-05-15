import 'package:flutter/material.dart';

import '../core.dart';

Widget dropdownField(
    {String title,  value, List collection, Function onChanged}) {
  return Container(
    height: 35,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50)

    ),
    child: DropdownButtonFormField(
      value: value,
      style: bodyText2.copyWith(
        color: Colors.black,
      ),
      decoration: InputDecoration(
          labelText: title,
          labelStyle: bodyText2,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none
          )),
      items: collection.map<DropdownMenuItem>((value) {
        return DropdownMenuItem(value: value, child: Text(value.name));
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
