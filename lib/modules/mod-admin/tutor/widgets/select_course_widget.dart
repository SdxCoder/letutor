

// import 'package:flutter/material.dart';
// import 'package:letutor/core/core.dart';
// import 'package:stacked/stacked.dart';

// import 'select_course_view_model.dart';

// class SelectCourseWidget extends StatelessWidget {
//   final Function onChanged;
//   final String value;

//   const SelectCourseWidget({Key key, this.onChanged, this.value}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<SelectCourseViewModel>.reactive(
//       viewModelBuilder: () => SelectCourseViewModel(),
//       onModelReady: (model) => model.getAllCourses() ,
//       builder: (context, model , child)=>
//          dropdownField(
//                 value: value,
//                 collection: model.courses,
//                 onChanged: onChanged,
//                 title: "Add Courses"),
//     );
//   }
// }