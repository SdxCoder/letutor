

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class SelectCourseViewModel extends BaseViewModel{
  
  final _dbService = Modular.get<DbService>();


  List<Course> _courses = [];
  List<Course> get courses => _courses;

  void getAllCourses(){
    _dbService.getAllCourses().listen((courses) {
        _courses = courses;
        notifyListeners();
     });
  }

}