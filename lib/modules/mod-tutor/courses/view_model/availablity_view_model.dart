import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:letutor/core/constants/constants.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-account/login/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class AvailablityViewModel extends BaseViewModel {
  final _tutorService = Modular.get<TutorService>();
  final _lessonService = Modular.get<LessonService>();
  final _currentUser = Modular.get<AuthService>().currentUser;

  DatePeriod _selectedPeriod;
  String _selectedDatePickerType = DatePickerType.date;

  Map<String, List<dynamic>> _events = Map<String, List>();

  List<Slot> _selectedSlots = [];

  DatePeriod get selectedPeriod => _selectedPeriod;
  List<Slot> get selectedSlots => _selectedSlots;
  String get selectedDatePickerType => _selectedDatePickerType;
  Map<String, List<dynamic>> get events => _events;

  List<DateTime> alreadySelectedDates = [];
  List<Lesson> _lessons = [];

  Future fetchLessons() async {
    setBusy(true);
    var result = await _lessonService.fetchLessons(_currentUser.user.uid);
    setBusy(false);
     if(result is String){
        await showSnackBar( desc: result);
      }else{
        _lessons = result;
      }
  }

  Future addAvailablity() async {
    print("add availblity from view Model");
    var confirm = await showActionDialogBox(title: "Reminder", description: "Do You want to add your time slots?");
   print(confirm);
   if(confirm != "true") return;
      setBusy(true);
      var result = await _tutorService.createTutor(Tutor(
        availableSlots: _events,
        lessons: _lessons,
        uid: _currentUser.user.uid,
            email: _currentUser.user.email,
            photoUrl: _currentUser.user.photoUrl,
            phoneNo: _currentUser.user.phoneNo,
            name: _currentUser.user.name,
            role:  _currentUser.user.role,
            dob: _currentUser.user.dob,
            firstName: _currentUser.user.firstName,
            lastName: _currentUser.user.lastName,
            photoPlaceholder: _currentUser.user.photoPlaceholder
      ));
      setBusy(false);
      if(result is String){
        await showDialogBox(title: "Error", description: result);
      }else{
        await showDialogBox(title: "Success", description: "Availability updated");
        _events.clear();
        notifyListeners();
      }
  }

  void recordSelectedDatesAndEvents() {
    final difference =
        _selectedPeriod.end.difference(_selectedPeriod.start).inDays;
    var slots = List<Slot>();
    slots.addAll(_selectedSlots);
    print(difference);
    DateTime start = _selectedPeriod.start;
    for (int days = 0; days <= difference; days++) {
      alreadySelectedDates.add(start);
      _events.addAll({start.toString() : slots});
      start = start.add(Duration(days: 1));
      print(start);
    }
    notifyListeners();
  }

  void removeParticularEvents(String key) {
    _events.remove(key);
    alreadySelectedDates.remove(DateTime.parse(key));
    notifyListeners();
  }

  void removeEvents() {
    _events.clear();
    alreadySelectedDates.clear();
    notifyListeners();
  }

  void selectDate(period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  void changePickerType(value) {
    _selectedDatePickerType = value;
    notifyListeners();
  }

  void selectSlot(Slot slot) {
    _selectedSlots.add(slot);
    notifyListeners();
  }

  void unselectSlot(Slot slot) {
    _selectedSlots.remove(slot);
    notifyListeners();
  }

  List<String> datePickerTypes = [
    DatePickerType.date,
    DatePickerType.range,
    DatePickerType.week
  ];

  // List<String> timeSlots = [
  //   "08am - 09am",
  //   "09am - 10am",
  //   "10am - 11am",
  //   "11am - 12am",
  //   "12am - 01pm",
  //   "01pm - 02pm",
  //   "02pm - 03pm",
  //   "04pm - 05pm",
  //   "05pm - 06pm",
  //   "06pm - 07pm",
  //   "07pm - 08pm",
  // ];
  List<Slot> timeSlots = [
    Slot(
      timeSlot: "08am - 09am",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "09am - 10am",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "10am - 11am",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "11am - 12am",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "12am - 01pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "01pm - 02pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "02pm - 03pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "03pm - 04pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "04pm - 05pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "05pm - 06pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "06pm - 07pm",
      availablityStatus: SlotStatus.available
    ),
     Slot(
      timeSlot: "07pm - 08pm",
      availablityStatus: SlotStatus.available
    ),
    
  ];
}
