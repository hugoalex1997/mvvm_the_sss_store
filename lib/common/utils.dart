class Utils {
  static String dateToString(DateTime? date) {
    if (date == null) {
      return "";
    } else {
      return "${date.day}" "-" "${date.month}" "-" "${date.year}";
    }
  }
}
