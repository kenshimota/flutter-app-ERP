import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_categories_builder.dart';

class LayourtTwiceBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? desktop;
  final String? log;

  const LayourtTwiceBuilder(
      {super.key, required this.mobile, this.desktop, this.log});

  @override
  Widget build(BuildContext context) {
    return LayourtCategoriesBuilder(
      xs: mobile,
      sm: mobile,
      md: desktop,
      log: log ?? "None",
    );
  }
}
