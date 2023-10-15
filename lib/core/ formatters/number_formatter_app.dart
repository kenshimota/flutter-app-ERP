import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NumberFormatterApp {
  static String percentageFormat(double percentage) { 

    if(percentage == 0){
      return '0.00%';
    }

    percentage = percentage;
     final f = NumberFormat("###.00#%", "en_US");

    return f.format(percentage);
  }
}


