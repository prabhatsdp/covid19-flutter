import 'package:intl/intl.dart';

class Helper {
  static String formatNumber(int number) {
    final NumberFormat numberFormatter = new NumberFormat("##,##,##,##,###");
    return numberFormatter.format(number);
  }

  static String parseAndFormatDateDDMMM(String dateStringDDMMM) {
    if (dateStringDDMMM == null || dateStringDDMMM.isEmpty) {
      print("Date is empty or null");
      return "";
    } else {
      // print("Date is not empty or null");
      // print(dateStringDDMMM);
      DateTime dateTime = DateFormat('dd MMMM').parse(dateStringDDMMM);
      DateFormat dateFormatter = DateFormat('dd-MMM');
      return dateFormatter.format(dateTime);
    }
  }

  static String parseAndFormatDateFull(String dateString) {
    if (dateString == null || dateString.isEmpty) {
      print("Date is empty or null.");
      return "";
    } else {
      DateTime dateTime = DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateString);
      DateFormat dateFormatter = DateFormat('MMMM dd, yyyy @ hh:mm a');
      return dateFormatter.format(dateTime) + " IST";
    }
  }

  static String formatNumberAsThousands(int number) {
     String formatedNumberString = "";
    if(number >= 1000) {
     formatedNumberString = ((number / 1000).toStringAsFixed(1)) + "K";
    } else {
      formatedNumberString = number.toString();
    }
    return formatedNumberString;
  }
}
