import 'package:stacked/stacked.dart';

class BookCourseViewModel extends BaseViewModel {
  String _selectedlevel;
  String _selectedCourse;
  List<String> _topics = [];



  String get selectedlevel => _selectedlevel;
  String get selectedCourse => _selectedCourse;
  List<String> get topics => _topics;

  void selectCourse(String value) {
    _selectedCourse = value;
    notifyListeners();
  }

  void selectLevel(String value) {
    _selectedlevel = value;
    notifyListeners();
  }

  void addTopics(String topic) {
    _topics.add(topic);
    notifyListeners();
  }

  void removeTopics(index) {
    _topics.removeAt(index);
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
