import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CircularButton({
  required Icon icon,
  required BuildContext context,
  required void Function()? onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: icon,
    ),
  );
}
