import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class BookCourseViewModel extends BaseViewModel {

  final _currentUser = Modular.get<AuthService>().currentUser;

  Booking _booking;

  Lesson _selectedLesson;
  Course _selectedCourse;
  List<String> _topics = [];

  Lesson get selectedLesson => _selectedLesson;
  Course get selectedCourse => _selectedCourse;
  List<String> get topics => _topics;

  void createBooking(Tutor tutor){
    _booking = Booking(
      level: Level(
        id: this._selectedLesson.levelId,
        name: this._selectedLesson.level,
      ),
      course: this._selectedCourse,
      topics: this._topics,
      status: BookingStatus.pending,
      user: _currentUser.user,
      tutor: tutor
    );

    Modular.to.pushNamed(Routes.tutorAvailability, arguments: _booking);
  }

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
