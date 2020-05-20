import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class TutorAvailabilityViewModel extends BaseViewModel {
  Tutor _selectedTutor;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<dynamic>> _events = Map<DateTime, List<dynamic>>();
  List selectedEvents = [];

  DateTime get selectedDate => _selectedDate;
  Map<DateTime, List<dynamic>> get events => _events;

  void mapEvents() {
    var availbleSlots = _selectedTutor.availableSlots;
    availbleSlots.forEach((key, value) {
      Map<DateTime, List<dynamic>> map = <DateTime, List<dynamic>>{
        DateTime.parse(key) : value
      };
      _events.addAll(map);
      
    });
    notifyListeners();
  }

  void selectDate(dateTime, List<dynamic> events) {
    selectedEvents = events;
    _selectedDate = dateTime;
    notifyListeners();
  }

  void setTutor(Tutor tutor) {
    _selectedTutor = tutor;
    notifyListeners();
  }
}
