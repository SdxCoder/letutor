

import 'package:stacked/stacked.dart';

class TutorAvailabilityViewModel extends BaseViewModel{
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {
    DateTime.now().add(Duration(days: 4)) : ["Tutor available"],
  };
  List selectedEvents = [];

  DateTime get selectedDate => _selectedDate;
  Map<DateTime, List<dynamic>> get events => _events;

  void selectDate(dateTime, List<dynamic> events){
    selectedEvents = events;
    _selectedDate = dateTime;
    notifyListeners();
  }

}