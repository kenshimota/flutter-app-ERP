import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_categories_builder.dart';

class LayourtTwiceBuilder extends StatelessWidget {
  final Widget? mobile;
  final Widget? desktop;

  const LayourtTwiceBuilder({super.key, required this.mobile, this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayourtCategoriesBuilder(xs: mobile, sm: mobile, lg: desktop);
  }
}
