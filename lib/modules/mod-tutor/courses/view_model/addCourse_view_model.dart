import 'package:stacked/stacked.dart';

class AddCourseViewModel extends BaseViewModel {
  String _selectedlevel;
  Set<String> _selectedCourses = Set<String>();

  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {
    DateTime.now().add(Duration(days: 4)): ["Tutor available"],
  };

  List selectedEvents = [];

  DateTime get selectedDate => _selectedDate;
  Map<DateTime, List<dynamic>> get events => _events;

  void selectDate(dateTime, List<dynamic> events) {
    selectedEvents = events;
    _selectedDate = dateTime;
    notifyListeners();
  }

  String get selectedlevel => _selectedlevel;
  Set<String> get selectedCourses => _selectedCourses;

  void addCourse(String value) {
    if (value.isNotEmpty) {
      _selectedCourses.add(value.toUpperCase());
      notifyListeners();
    }
  }

  void removeCourse(String value) {
    _selectedCourses.remove(value.toUpperCase());
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
