

extension DateParsing on DateTime{
  String get dob{
    return this.year.toString() + "-" + this.month.toString() + "-" + this.day.toString();
  }
}