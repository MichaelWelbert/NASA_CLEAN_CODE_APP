class DateToStringConverter {
  static String convert(DateTime date) {
    var dateSplitted = date.toString().split(' ');
    String dateOnly = dateSplitted.first;
    return dateOnly;
  }
}
