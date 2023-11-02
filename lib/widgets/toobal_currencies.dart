import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/button_sort_currencies.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';

class ToobalCurrencies extends StatelessWidget {
  final Widget inputSearch;
  final Function(Map<String, String>)? onOrden;

  const ToobalCurrencies({
    super.key,
    required this.inputSearch,
    this.onOrden,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(height: 70, 
      child: LayourtTwiceBuilder(
        mobile: Row(
          children: [
            Expanded(child: inputSearch,), 
            ButtonSortCurrencies(onOrden: onOrden,),
          ],
        ),
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