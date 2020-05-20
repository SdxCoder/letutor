import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/core/shared_service/booking_service.dart';
import 'package:stacked/stacked.dart';

class BookingSummaryViewModel extends BaseViewModel {
  final _service = Modular.get<BookingService>();

  Future createBooking(booking) async {
   var confirm = await showActionDialogBox(title: "Reminder", description: "Do You want to make this booking?");
   print(confirm);
   if(confirm != "true") return;
    setBusy(true);
    var result = await _service.createBooking(booking);
    setBusy(false);

    if (result is String) {
      await showDialogBox(title: "Error", description: result);
    } else {
      await showDialogBox(
          title: "Success", description: "Availability updated");
      Modular.to.pushNamedAndRemoveUntil(Routes.userHome, (d) => true);
    }
  }
}
