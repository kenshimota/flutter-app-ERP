import 'package:intl/intl.dart';

class NumberFormatterApp {
  static amount(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match match) => '${match[1]},');
  }

  static format(double amount) {
    final f = NumberFormat("#,##0.##", "en_US");

    return f.format(amount);
  }

  static String percentageFormat(double percentage) {
    if (percentage == 0) {
      return '0.00%';
    }

    percentage = percentage;
    final f = NumberFormat("###.00#%", "en_US");

    return f.format(percentage);
  }
}
