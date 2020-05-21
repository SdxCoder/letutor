

import 'package:flutter/material.dart';
import 'package:letutor/core/utils/colors.dart';

Widget empltyList({String text, String asset}){
  return  Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset(asset ?? 'assets/tutor.png', fit: BoxFit.contain,)),
                Text(text ?? "No Bookings", style: bodyText1.copyWith(
                  fontWeight: FontWeight.bold
                ),)
              ],
            ),
          ),
        ); 
}