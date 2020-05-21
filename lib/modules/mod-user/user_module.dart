

import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-user/home/view/home_view.dart';

import 'book_appointment/views/book_course_view.dart';
import 'book_appointment/views/booking_summary.dart';
import 'book_appointment/views/tutor_availability_view.dart';
import 'tutorSearch/views/tutor_details.dart';
import 'userprofile/views/user_profile_view.dart';

class UserModule extends ChildModule{
  @override
  List<Bind> get binds => [
     Bind((i) => TutorService()),
       Bind((i) => BookingService()),
  ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => UserHome()),
    Router('/bookCourse', child: (_, args) => BookCourseView()),
    Router('/bookingDetail/:id', child: (_, args) => BookingDetailView()),
    Router('/tutorProfile', child: (_, args) => TutorProfileView()),
    Router('/userProfile', child: (_, args) => UserProfileView()),
    Router('/tutorAvailbility', child: (_, args) => TutorAvailabilityView(booking : args.data)),
    Router('/bookingSummary', child: (_, args) => BookingSummaryView(booking : args.data)),
  
  ];

  static Inject get to => Inject<UserModule>.of();

}