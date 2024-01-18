import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/products_prices/button_sort_products_prices.dart';





class ToobalProductPrice extends StatelessWidget {
  final Widget inputSearch;
  final Function(Map<String, String>)? onOrden;

  const ToobalProductPrice({
    super.key,
    required this.inputSearch,
    this.onOrden,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 70,
      child: LayourtTwiceBuilder(
        mobile:  Row(
          children: [
            Expanded(child: inputSearch,),
            ButtonSortProductsPrices(onOrden: onOrden,)
          ],
        ),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 400,
              child: inputSearch,
            )
          ]
        ),
      ),
    );
  }
}