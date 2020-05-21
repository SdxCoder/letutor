import 'package:flutter_modular/flutter_modular.dart';
import 'package:letutor/core/core.dart';
import 'package:letutor/modules/mod-tutor/home/tutor_home_view.dart';


class TutorModule extends ChildModule{
  @override
  List<Bind> get binds => [
     Bind((i) => TutorService()),
     Bind((i) => LessonService()),
  ];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => TutorHome()),
    // Router('/bookCourse', child: (_, args) => BookCourseView()),
    // Router('/bookingDetail/:id', child: (_, args) => BookingDetailView()),
    // Router('/tutorProfile', child: (_, args) => TutorProfileView()),
    // Router('/userProfile', child: (_, args) => UserProfileView()),
  ];

  static Inject get to => Inject<TutorModule>.of();

}