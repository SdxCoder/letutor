import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';

import 'package:stacked/stacked.dart';
import 'package:rxdart/rxdart.dart';

class TutorDetailsViewModel extends BaseViewModel {
  final _userService = Modular.get<UserService>();
  final _lessonService = Modular.get<LessonService>();
  final _dbService = Modular.get<DbService>();

  User _edittingUser;

  List<Lesson> _lessons = [];
  List<Lesson> get lessons => _lessons;

  Future confirmBooking() async {
    setBusy(true);
    var result = await _userService.updateUser(User(
      email: _edittingUser.email,
      dob: _edittingUser.dob,
      firstName: _edittingUser.firstName,
      lastName: _edittingUser.lastName,
      name: _edittingUser.name,
      phoneNo: _edittingUser.phoneNo,
      photoPlaceholder: _edittingUser.photoPlaceholder,
      photoUrl: _edittingUser.photoUrl,
      role: _selectedUserRole,
      uid: _edittingUser.uid,
    ));
    setBusy(false);

    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      await showDialogBox(title: "Success", description: "Booking confirmed");
    }

    Modular.to.pop();
  }

  Future createlessons() async {
    if (lessons.isNotEmpty) {
      for (Lesson lesson in lessons) {
        var result = await _lessonService.createLesson(lesson);
        
        if (result is String) {
          await showDialogBox(title: "Error", description: result);
          return;
        }
      }
      await showDialogBox(title: "Success", description: "All lessons added");
      _lessons = [];
        notifyListeners();
    }
  }

  Future getAllCourses() async {
    var result = await _dbService.getAllCourses();
    if (result is String) {
      await showSnackBar(desc: result);
    } else {
      courses = result;
    }
  }

  Future getAllLevels() async {
    var result = await _dbService.getAllLevels();
    if (result is String) {
      await showSnackBar(desc: result);
    } else {
      modalities = result;
    }
  }

  void setEdittingUser(User user) {
    _edittingUser = user;
  }

  void addLesson() {
    _lessons.add(Lesson(
      tutorId: _edittingUser.uid,
      tutorName: _edittingUser.name,
      level: _selectedlevel.name,
      levelId: _selectedlevel.id,
      courses: _selectedCourses,
      documentId: _edittingUser.uid,
    ));
    _lessons = _lessons.toSet().toList();
    notifyListeners();
  }

  void removeLesson(lesson) {
    _lessons.remove(lesson);
    notifyListeners();
  }

  void changeUserRole(String value) {
    _selectedUserRole = value;
    notifyListeners();
  }

  void switchEditing() {
    _editUser = !_editUser;
    notifyListeners();
  }

  void addCourse(Course value) {
    if (value != null) {
      _selectedCourses.add(value);
      _selectedCourses = _selectedCourses.toSet().toList();
      _selectedCourses.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  void removeCourse(Course value) {
    _selectedCourses.remove(value);
    notifyListeners();
  }

  void selectCourse(Course value) {
    _selectedCourse = value;
    addCourse(value);
    notifyListeners();
  }

  void selectLevel(Level value) {
    _selectedlevel = value;
    notifyListeners();
  }

  Level _selectedlevel;
  String _selectedUserRole;
  Course _selectedCourse;
  Course get selectedCourse => _selectedCourse;
  List<Course> _selectedCourses = List<Course>();
  bool _editUser = false;

  Level get selectedlevel => _selectedlevel;

  String get selectedUserRole => _selectedUserRole;
  List<Course> get selectedCourses => _selectedCourses;
  bool get editUser => _editUser;

  List<Level> modalities = [];

  List<Course> courses = [];
}
