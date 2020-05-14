import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class TutorDetailsViewModel extends BaseViewModel {
  final _userService = Modular.get<UserService>();

  String _selectedlevel;
  String _selectedCourse;
  Set<String> _selectedCourses = Set<String>();

  String get selectedlevel => _selectedlevel;
  String get selectedCourse => _selectedCourse;
  Set<String> get selectedCourses => _selectedCourses;

  String role = "tutor";
  bool _editUser = false;
  bool get editUser => _editUser;

  Future confirmBooking(User user) async {
    setBusy(true);
    user.bookingStatus = "Confirmed";
    user.role = "Tutor";
    var result = await _userService.updateUser(user);
    setBusy(false);

    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      await showDialogBox(title: "Success", description: "Booking confirmed");
    }
  }

  void switchEditing() {
    _editUser = !_editUser;
    notifyListeners();
  }

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
