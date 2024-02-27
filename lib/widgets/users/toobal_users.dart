import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';

class ToobalUsers extends StatelessWidget {
  final Widget inputSeach;
  
  const ToobalUsers({
    super.key,
    required this.inputSeach,
  });

  @override 
  Widget build(BuildContext context){
    return SizedBox(
      height: 70,
      child: LayourtTwiceBuilder(
        mobile: Row(children: [Expanded(child: inputSeach,)]),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 400,
              child: inputSeach,
            ),
          ]),
      )
    );
  }
}