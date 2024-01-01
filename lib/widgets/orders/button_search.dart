import 'package:flutter/material.dart';

class ButtonSearch extends StatelessWidget {
  const ButtonSearch({ super.key});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      onPressed: () {}, 
      child: Icon(Icons.search),
      );
  }
}