import 'package:intl/intl.dart';

class Helper {
  static String formatNumber(int number) {
    final NumberFormat numberFormatter = new NumberFormat("##,##,##,##,###");
    return numberFormatter.format(number);
  }
}
