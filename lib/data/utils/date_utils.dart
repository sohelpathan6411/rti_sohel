import 'package:intl/intl.dart';

class DateUtilsFormat {
  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  static String formatLongDate(DateTime date) {
    return DateFormat.yMMMMd().format(date);
  }

  static String formatShortDate(DateTime? date) {
    return DateFormat.yMMMd().format(date!);
  }

  static String formatShortDay(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  static String formatTime(DateTime time) {
    return DateFormat.Hm().format(time);
  }
}
