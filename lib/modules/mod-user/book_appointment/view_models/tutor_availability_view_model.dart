import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:stacked/stacked.dart';

class TutorAvailabilityViewModel extends BaseViewModel {
  Booking _booking;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<dynamic>> _events = Map<DateTime, List<dynamic>>();
  List _selectedEvents = [];
  Slot _selectedSlot;

  List get selectedEvents =>_selectedEvents;

  DateTime get selectedDate => _selectedDate;
  Map<DateTime, List<dynamic>> get events => _events;
  Slot get selectedSlot => _selectedSlot;

  void updateBooking(){
    _booking = Booking(
      level: _booking.level,
      course: _booking.course,
      tutor: _booking.tutor,
      user: _booking.user,
      topics: _booking.topics,
      status: _booking.status,
      slot: _selectedSlot,
     // id: _booking.hashCode.toString()
    );

    Modular.to.pushNamed(Routes.bookingSummary, arguments: _booking);
  }

  void mapEvents() {
    var availbleSlots = _booking.tutor.availableSlots;
    availbleSlots.forEach((key, value) {
      print(value.toString());
      Map<DateTime, List<dynamic>> map = <DateTime, List<dynamic>>{
        DateTime.parse(key) : value
      };
      _events.addAll(map);
      
    });
    notifyListeners();
  }
  void selectSlot(slot){
    //var s = Slot.fromJson(slot);
    _selectedSlot = Slot(
      timeSlot: slot.timeSlot,
      availablityStatus: slot.availablityStatus,
      date: _selectedDate
    );
    notifyListeners();
  }

  void selectDate(dateTime, List<dynamic> events) {
    _selectedEvents = events;
    _selectedDate = dateTime;
    _selectedSlot = null;
    notifyListeners();
  }

  void setBooking(Booking booking) {
    _booking = booking;
    notifyListeners();
  }
}
