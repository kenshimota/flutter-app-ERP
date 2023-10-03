import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CircularButton
  ({required Icon icon, required void Function()? onPressed,}) {
  return InkWell(
    onTap: () {
      // handle button press
    },
    child: Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple,
      ),
      child: icon,
    ),
  );
}
