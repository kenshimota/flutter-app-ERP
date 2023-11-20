import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/button_sort_taxes_mobile.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/products/button_sort_products.dart';

class ToobalProducts extends StatelessWidget {
  final Widget inputSearch;
  final Function(Map<String, String>)? onOrden;

  const ToobalProducts({super.key, required this.inputSearch, this.onOrden});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: LayourtTwiceBuilder(
        mobile: Row(children: [
          Expanded(
            child: inputSearch,
          ),
          ButtonSortProducts(
            onOrden: onOrden,
          )
        ]),
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
