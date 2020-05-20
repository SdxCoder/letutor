import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class BookCourseViewModel extends BaseViewModel {
  Lesson _selectedLesson;
  Course _selectedCourse;
  List<String> _topics = [];

  Lesson get selectedLesson => _selectedLesson;
  Course get selectedCourse => _selectedCourse;
  List<String> get topics => _topics;

  void selectCourse(Course value) {
    _selectedCourse = value;
    notifyListeners();
  }

  void selectLesson(value) {
    _selectedLesson = value;
    notifyListeners();
  }

  void addTopics(String topic) {
    if (topic.isNotEmpty) {
      _topics.add(topic);
      _topics = _topics.toSet().toList();
      notifyListeners();
    }
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
