

import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class SearchTutorViewModel extends BaseViewModel{
  

  String _selectedLevel;
  String _selectedCourse;
  List<Tutor> _tutorsList = [
    // Tutor(uid: "1", name : "John", lastName: "Wick"),
    // Tutor(uid: "2", name : "John", lastName: "Wick"),
    // Tutor(uid: "3", name : "John", lastName: "Wick"),
    // Tutor(uid: "4", name : "John", lastName: "Wick"),
    // Tutor(uid: "5", name : "John", lastName: "Wick"),
  ];

  Stream<List<Tutor>> _tutors;
  List<Course> _courses = [
    Course(id: "1", name: "Physics"),
    Course(id: "2", name: "Mathematics"),
    Course(id: "3", name: "Biology"),
    Course(id: "4", name: "Chemistry"),
    Course(id: "5", name: "English"),
  ];
  List<Level> _academicLevels = [
    Level(id: "1", name: "Elementary"),
    Level(id: "2", name: "High School"),
    Level(id: "3", name: "University"),
  ];

  
  String get selectedCourse => _selectedCourse;
  String get selectedLevel => _selectedLevel;

  List<Course> get courses => _courses;
  List<Level> get levels => _academicLevels;
  List<Tutor> get tutorsList => _tutorsList;

  void setSelectedLevel(String level) {
    _selectedLevel = level;
    fetchTutors(_selectedLevel, _selectedCourse);
    notifyListeners();
  }

  void setSelectedCourse(String course) {
    _selectedCourse = course;
    fetchTutors(_selectedLevel, _selectedCourse);
    notifyListeners();
  }

  Stream<List<Tutor>> fetchTutors(String level, String course) {
   
  }

  Stream<List<Course>> fetchCourses() {
   
  }

  Stream<List<Level>> fetchLevels() {
   
   
  }
}