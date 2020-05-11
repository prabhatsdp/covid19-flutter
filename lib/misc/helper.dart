import 'package:intl/intl.dart';

class Helper {
  static String formatNumber(int number) {
    final NumberFormat numberFormatter = new NumberFormat("##,##,##,##,##,###");
    return numberFormatter.format(number);
  }

  /**
   * This function takes 
   * 
   *      String dateString // in [dd MMMM] format
   * 
   * as argument and returns 
   * 
   *      String formatedDate // in [dd-MMM] format
   * 
   * after parsing and formating the date.
   */
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

  /**
   * This Function takes 
   * 
   *      String dateString // in {dd/MM/yyyy HH:mm:ss} format 
   * 
   * as argument and then parse and formate it and returns 
   * 
   *      String formatedDate // in {MMMM dd, yyyy @ hh:mm a} format.
   */
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

  static DateTime parseDateTimeDDMMMYY(String dateString) {
    return DateFormat("DD-MMM-yy").parse(dateString);
  }

  /**
   * This function takes DateTime as argument and returns formated string in [dd-MMM] format.
   *    
   *    Argument Type:
   * 
   *      DateTime dateTime 
   * 
   *    Return Type:
   * 
   *      String formatedDate / in [dd-MMM] format
   */
  static String formateDateDDMMMYY(DateTime dateTime) {
    if (dateTime == null) {
      print("Date is empty or null");
      return "";
    } else {
      DateFormat dateFormatter = DateFormat('dd-MMM');
      return dateFormatter.format(dateTime);
    }
  }

  static String formatNumberAsThousands(int number) {
    String formatedNumberString = "";
    if (number >= 1000) {
      formatedNumberString = ((number / 1000).toStringAsFixed(1)) + "K";
    } else {
      formatedNumberString = number.toString();
    }
    return formatedNumberString;
  }
}
