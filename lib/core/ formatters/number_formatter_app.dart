import 'package:intl/intl.dart';


class NumberFormatterApp {

  static format(double amount){
    final f = NumberFormat("###.00#", "en_US");

    return f.format(amount);
  }

  static String percentageFormat(double percentage) { 

    if(percentage == 0){
      return '0.00%';
    }

    percentage = percentage;
     final f = NumberFormat("###.00#%", "en_US");

    return f.format(percentage);
  }
}


