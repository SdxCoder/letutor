import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:letutor/core/constants/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:built_collection/built_collection.dart';

class AvailablityViewModel extends BaseViewModel {
 

  DatePeriod _selectedPeriod;
  String _selectedDatePickerType = DatePickerType.date;

  Map<DateTime, List> _events = Map<DateTime, List>();

  List<String> _selectedSlots = [];

  DatePeriod get selectedPeriod => _selectedPeriod;
  List<String> get selectedSlots => _selectedSlots;
  String get selectedDatePickerType => _selectedDatePickerType;
  Map<DateTime, List> get events => _events;

  List<DateTime> alreadySelectedDates = [];

  void recordSelectedDatesAndEvents(){
    final difference = _selectedPeriod.end.difference(_selectedPeriod.start).inDays;
    var slots = List<String>();
    slots.addAll(_selectedSlots);
    print(difference);
    DateTime start = _selectedPeriod.start;
    for(int days = 0; days <= difference; days++ ){
      alreadySelectedDates.add(start);
      _events.addAll({
        start : _selectedSlots
      });
      start = start.add(Duration(days: 1));
      print(start);
    }
    notifyListeners();
  }

   void removeParticularEvents(DateTime key){
    _events.remove(key);
    alreadySelectedDates.remove(key);
    notifyListeners();
  }

  void removeEvents(){
    _events.clear();
    alreadySelectedDates.clear();
    notifyListeners();
  }


  void selectDate(period) {
    _selectedPeriod = period;
    notifyListeners();
  }

  void changePickerType(value){
    _selectedDatePickerType = value;
    notifyListeners();
  }

  void selectSlot(String slot){
    _selectedSlots.add(slot);
    notifyListeners();
  }

  void unselectSlot(String slot){
    _selectedSlots.remove(slot);
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
