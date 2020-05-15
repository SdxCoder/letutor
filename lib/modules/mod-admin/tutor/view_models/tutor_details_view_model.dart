import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class TutorDetailsViewModel extends BaseViewModel {
  final _userService = Modular.get<UserService>();
  final _lessonService = Modular.get<LessonService>();

  User _edittingUser;

 

  Set<Lesson> _lessons = Set<Lesson>();
  Set<Lesson> get lessons  => _lessons;

  Future createlessons() async{
    if(lessons.isNotEmpty){
      for(Lesson lesson in lessons){
        var result = await _lessonService.createLesson(lesson);

        if(result is String){
           await showDialogBox(title: "Error", description: result);
           return;
        }
      }
       await showDialogBox(title: "Success", description: "All lessons added");
    }
  }

  void setEdittingUser(User user) {
    _edittingUser = user;
  }

  void addLesson(){
    _lessons.add(Lesson(
      level: _selectedlevel,
      courses: _selectedCourses.toList(),
      tutorId: _edittingUser.uid,
      documentId: _edittingUser.uid,
    ));
    notifyListeners();
  }

   void removeLesson(lesson){
    _lessons.remove(lesson);
    notifyListeners();
  }


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

  void reset() {
    _editUser = false;
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

  void selectLevel(String value) {
    _selectedlevel = value;
    notifyListeners();
  }

  String _selectedlevel;
  String _selectedUserRole;
  Course _selectedCourse;
  Course get selectedCourse => _selectedCourse;
  Set<Course> _selectedCourses = Set<Course>();
  bool _editUser = false;

  String get selectedlevel => _selectedlevel;
  
  String get selectedUserRole => _selectedUserRole;
  Set<Course> get selectedCourses => _selectedCourses;
  bool get editUser => _editUser;

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
