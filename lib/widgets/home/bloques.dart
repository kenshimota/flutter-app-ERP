import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/dashboard/dashboard_response.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class Bloques extends StatelessWidget {
  final int amount;
  final String title;
  final Icon icon;
  final double width;
  final double height;

  const Bloques({
    super.key,
    required this.width,
    required this.height,
    required this.amount,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius:
            BorderRadius.circular(10), // Radio de los bordes redondeados
      ),
      padding: const EdgeInsets.all(15),
      
      child: Column(
        children: [
          FormControl(child: icon),
          TypographyApp(
            text: title,
            variant: "subtitle1",
            color: "white",
          ),
          TypographyApp(
            text: NumberFormatterApp.amount(amount),
            variant: "subtitle1",
            color: "white",
          ),
        ],
      ),
    );
  }
}