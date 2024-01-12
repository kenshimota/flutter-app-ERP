import 'package:intl/intl.dart';

class NumberFormatterApp {

  static String filled(int number, [int fill = 8]) {
    List<int> digits = [];

    while(number > 0 && digits.length < fill) {
      final int digit = number % 10;
      digits.add(digit);
      number -= digit;
      number = number ~/ 10;
    }

    while(digits.length < fill) {
      digits.add(0);
    }


    return digits.reversed.toList().join("");
  }

  static amount(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');
  }

  static format(double amount) {
    final f = NumberFormat("#,##0.00", "en_US");

    return f.format(amount);
  }

  static String percentageFormat(double percentage) {
    if (percentage == 0) {
      return '0.00%';
    }

    percentage = percentage;
    final f = NumberFormat("###0.00#%", "en_US");

    return f.format(percentage);
  }
}
