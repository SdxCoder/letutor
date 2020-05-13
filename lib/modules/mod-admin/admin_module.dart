

import 'package:flutter_modular/flutter_modular.dart';

import 'home/admin_home_view.dart';
import 'tutor/views/tutor_details_view.dart';

class AdminModule extends ChildModule{
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
     Router('/', child: (_, args) => AdminHome()),
     Router('/tutorDetails/:id', child: (_, args) => TutorDetailsView(id: args.params["id"],)),
    // Router('/bookCourse', child: (_, args) => BookCourseView()),
    // Router('/bookingDetail/:id', child: (_, args) => BookingDetailView()),
    // Router('/tutorProfile', child: (_, args) => TutorProfileView()),
    // Router('/userProfile', child: (_, args) => UserProfileView()),
  ];

  static Inject get to => Inject<AdminModule>.of();

}