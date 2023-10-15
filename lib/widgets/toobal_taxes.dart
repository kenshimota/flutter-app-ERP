import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/button_sort_taxes_mobile.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';

class ToobalTaxes extends StatelessWidget {
  final Widget inputSearch;

  const ToobalTaxes({super.key, required this.inputSearch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: LayourtTwiceBuilder(
        mobile: Row(children: [Expanded(child: inputSearch,), const ButtonSortTaxes()]),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 400,
              child: inputSearch,
            )
          ],
        ),
      ),
    );
  }
}
