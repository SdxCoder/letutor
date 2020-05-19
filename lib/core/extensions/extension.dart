

import 'package:intl/intl.dart';

extension DateParsing on DateTime{
  String get dob{
    String month = this.month.toString().padLeft(2, '0');
    String day = this.day.toString().padLeft(2, '0');   
    String year = this.year.toString();

    return year + "-" + month + "-" + day;
  }

  String get abbrDate{
    return DateFormat.yMMMd().format(this);
  }
}