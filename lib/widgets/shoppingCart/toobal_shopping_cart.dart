import 'package:flutter/material.dart';

class ToobalShoppingCart extends StatelessWidget {
  final Widget inputSearch;
   
  const ToobalShoppingCart({
    super.key,
    required this.inputSearch,
  });

  

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 70, 
      child: Row(
        children: [
          Expanded(
            child: inputSearch,
          ),
        ],
      ),
    );
  }
}