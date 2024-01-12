import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';




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
        mobile: const Row(
          children: [
            Text('este en construccion')
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