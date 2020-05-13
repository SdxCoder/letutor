import 'package:stacked/stacked.dart';

class TutorDetailsViewModel extends BaseViewModel {
  String _selectedlevel;
  String _selectedCourse;
  Set<String> _selectedCourses = Set<String>();

  String get selectedlevel => _selectedlevel;
  String get selectedCourse => _selectedCourse;
  Set<String> get selectedCourses => _selectedCourses;

  String role = "tutor";

  void addCourse(String value) {
    if (value != null) {
      _selectedCourses.add(value.toUpperCase());
    }
  }

  void removeCourse(String value) {
    _selectedCourses.remove(value.toUpperCase());
    notifyListeners();
  }

  void selectCourse(String value) {
    _selectedCourse = value;
    addCourse(value);
    notifyListeners();
  }

  void selectLevel(String value) {
    _selectedlevel = value;
    notifyListeners();
  }

  List<String> modalities = [
    "Elementary",
    "High School",
    "University",
  ];

  List<String> courses = [
    "Mathematics",
    "Biology",
    "Physics",
    "Statistics",
  ];
}
