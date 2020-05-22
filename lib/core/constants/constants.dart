
const imageUrl = 'https://png.pngtree.com/element_our/png/20181206/users-vector-icon-png_260862.jpg';



const appointmentsHeroTag = "appointmentsHeroTag";
const userProfileHeroTag = "userProfileHeroTag";


class Role{
  static String admin = "admin";
  static String user = "User";
  static String tutor = "Tutor";
}

class DatePickerType{
   static String date = "By Date";
   static String range = "By Range";
   static String week = "By Week";
}

class BookingStatus{
  static String pending = "Pending";
  static String confirmed = "Confirmed";
  static String none = "none";
}

class SlotStatus{
   static String available = "Available";
    static String booked = "Booked";
}

List<String> modalities = [
  "Elementary",
  "High School",
  "University",
];

List<String> courses = [
  "Mathematics",
  "Biology",
  "Physics",
  "Statistics",
];
