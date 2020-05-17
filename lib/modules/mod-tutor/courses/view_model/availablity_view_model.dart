import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:letutor/core/constants/constants.dart';
import 'package:stacked/stacked.dart';

class AvailablityViewModel extends BaseViewModel {
 

  DateTime _selectedDate;
  String _selectedDatePickerType = DatePickerType.date;

  Map<DateTime, List<dynamic>> _events = {
    DateTime.now().add(Duration(days: 4)): ["Tutor available"],
  };

  List selectedEvents = [];

  DateTime get selectedDate => _selectedDate;
  Map<DateTime, List<dynamic>> get events => _events;
  String get selectedDatePickerType => _selectedDatePickerType;

  void selectDate(dateTime, List<dynamic> events) {
    selectedEvents = events;
    _selectedDate = dateTime;
    notifyListeners();
  }

  void changePickerType(value){
    _selectedDatePickerType = value;
    notifyListeners();
  }

  List<String> datePickerTypes = [
    DatePickerType.date,
    DatePickerType.range,
    DatePickerType.week
  ];

  List<String> timeSlots = [
    "08am - 09am",
    "09am - 10am",
    "10am - 11am",
    "11am - 12am",
    "12am - 01pm",
    "01pm - 02pm",
    "02pm - 03pm",
    "04pm - 05pm",
    "05pm - 06pm",
    "06pm - 07pm",
    "07pm - 08pm",
  ];
}
