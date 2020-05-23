import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/shared_service/booking_service.dart';
import 'package:stacked/stacked.dart';

class BookingSummaryViewModel extends BaseViewModel {
  final _service = Modular.get<BookingService>();
  final _tutorService = Modular.get<TutorService>();

  Future createBooking(Booking booking) async {
    var confirm = await showActionDialogBox(
        title: "Reminder", description: "Do You want to make this booking?");
    print(confirm);
    if (confirm != "true") return;
    setBusy(true);
    var result = await _service.createBooking(booking);
     await updateBookingStatus(booking.slot, booking.tutor);
    setBusy(false);

    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    }
    
    else {
      await showDialogBox(
          title: "Success", description: "Your Booking has been made");
      Modular.to.pushNamedAndRemoveUntil(Routes.userHome, ModalRoute.withName(Routes.userHome));
    }
  }

  Future updateBookingStatus(Slot slot, Tutor tutor) async {
    tutor.availableSlots.forEach((key, value) {
      String k = DateTime.parse(key).abbrDate;
      if (k == slot.date.abbrDate) {
        print(k);
        tutor.availableSlots.update(key, (list) {
          var newList = list;
         // var newMap = Map();
          int index = 0;
          for (var map in list) {
            Slot slotFromMap = Slot.fromJson(map);
            if (slot == slotFromMap) {
              print(slot.timeSlot + " Date: " + slot.date.abbrDate);
              newList.replaceRange(index, index+1, [Slot(availablityStatus: SlotStatus.booked, timeSlot: slotFromMap.timeSlot).toJson()]);
            }
            index++;
          }
          print(newList.toString());
          return newList;
        });
      }
    });

    var result = await _tutorService.updateTutor(Tutor(
      availableSlots: tutor.availableSlots,
      uid: tutor.uid,
      dob: tutor.dob,
      email: tutor.email,
      firstName: tutor.firstName,
      lastName: tutor.lastName,
      lessons: tutor.lessons,
      name: tutor.name,
      phoneNo: tutor.phoneNo,
      photoPlaceholder: tutor.photoPlaceholder,
      photoUrl: tutor.photoUrl,
      role: tutor.role
    ));

    return result;
  }
}
