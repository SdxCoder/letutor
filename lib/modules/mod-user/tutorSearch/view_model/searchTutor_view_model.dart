import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class SearchTutorViewModel extends BaseViewModel {
  final _tutorService = Modular.get<TutorService>();
  final _dbService = Modular.get<DbService>();

  List<Tutor> _tutorsList = [];

  Set<Tutor> _tempList = Set<Tutor>();

  Set<Tutor> get tempList => _tempList;

  StreamSubscription _subscription;
  void listenToTutors() {
    setBusy(true);
    _subscription = _tutorService.listenToTutorsRealTime().listen((tutorData) {
      _tempList = Set<Tutor>();
      List<Tutor> tutors = tutorData;
      if (tutors != null && tutors.length > 0) {
        _tutorsList = tutors;
        notifyListeners();
      }

      _tempList.addAll(tutors);
      print("tutors" + tempList.length.toString());
      setBusy(false);
    });
  }

  void searchResults() {
    _tempList = Set<Tutor>();

    _tempList = _tutorsList.map((e) => e).where((element) {
      if (_selectedCourse != null && _selectedLevel != null) {
        for (var lesson in element.lessons) {
          for (var course in lesson.courses) {
            if (_selectedCourse == course.id &&
                _selectedLevel == lesson.levelId) {
              print("both matched : true");
              return true;
            }
          }
        }
      } else {
        if (_selectedLevel != null) {
          for (var lesson in element.lessons) {
            if (_selectedLevel == lesson.levelId) {
              print("level matched : true");
              return true;
            }
          }
        }

        if (_selectedCourse != null) {
          for (var lesson in element.lessons) {
            for (var course in lesson.courses) {
              if (_selectedCourse == course.id) {
                print("course matched : true");
                return true;
              }
            }
          }
        }
      }

      return false;
    }).toSet();
    notifyListeners();
    // for(Tutor tutor in _tutorsList){

    //   if(tutor.uid.toLowerCase().contains(query.toLowerCase())){
    //     _tempList.add(tutor);
    //     notifyListeners();
    //   }
    // }
  }

  Future fetchCourses() async {
    var result = await _dbService.getAllCourses();

    if (result is String) {
      await showSnackBar(desc: result);
    } else {
      _courses = result;
    }
  }

  Future fetchLevels() async {
    var result = await _dbService.getAllLevels();
    if (result is String) {
      await showSnackBar(desc: result);
    } else {
      _academicLevels = result;
    }
  }

  String _selectedLevel;
  String _selectedCourse;

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
    notifyListeners();
  }

  void setSelectedCourse(String course) {
    _selectedCourse = course;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
