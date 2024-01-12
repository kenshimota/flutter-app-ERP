import 'package:intl/intl.dart';

class DateFormatterApp {
  static String dateFormatter(DateTime now){
      DateTime localTime = now.toLocal();
    return DateFormat('dd/MM/yyyy').format(localTime);
  }


 static String dateTimeFormatter(DateTime date){
  String dateFormated = DateFormatterApp.dateFormatter(date);
  String formattedTime = DateFormat.Hm().format(date.toLocal());
  return "$dateFormated $formattedTime";
 }

}
