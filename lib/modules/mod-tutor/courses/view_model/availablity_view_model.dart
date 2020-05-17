import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:intl/intl.dart';
import 'package:letutor/core/constants/constants.dart';
import 'package:stacked/stacked.dart';

class AvailablityViewModel extends BaseViewModel {
 

  DatePeriod _selectedPeriod;
  String _selectedDatePickerType = DatePickerType.date;

 Map<DateTime, List<dynamic>> _events;

  List<String> _selectedSlots = [];

  DatePeriod get selectedPeriod => _selectedPeriod;
  List<String> get selectedSlots => _selectedSlots;
  String get selectedDatePickerType => _selectedDatePickerType;


  void addEvents(){
    final difference = _selectedPeriod.start.difference(_selectedPeriod.end).inDays;
    for(int days = 0; days <= difference; days++ ){
      _events.addAll({
        _selectedPeriod.start : _selectedSlots
      });

      if(_selectedPeriod.start.compareTo(_selectedPeriod.end) == 0){
        break;
      }
       _selectedPeriod.start.add(Duration(days: 1));
    }

   

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
