import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/inventories/button_sort_inventories.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';

class ToobalInventories extends StatelessWidget {
  final Widget inputSearch;
  final Function(Map<String, String>)? onOrden;

  const ToobalInventories({super.key, required this.inputSearch, this.onOrden});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: LayourtTwiceBuilder(
        mobile: Row(children: [
          Expanded(
            child: inputSearch,
          ),
          ButtonSortInventories(
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
