import 'package:flutter/material.dart';

final Map<String, TextStyle? Function(BuildContext)> _variants = {
  "h1": (BuildContext context) => Theme.of(context).textTheme.headlineLarge,
  "h2": (BuildContext context) => Theme.of(context).textTheme.headlineMedium,
  "h3": (BuildContext context) => Theme.of(context).textTheme.headlineSmall,
  "h4": (BuildContext context) => Theme.of(context).textTheme.titleLarge,
  "h5": (BuildContext context) => Theme.of(context).textTheme.titleMedium,
  "h6": (BuildContext context) => Theme.of(context).textTheme.titleSmall,
  "body": (BuildContext context) => Theme.of(context).textTheme.bodySmall,
};

class TypographyApp extends StatelessWidget {
  final String? text;
  final String? variant;

  const TypographyApp({super.key, required this.text, this.variant});

  @override
  Widget build(BuildContext context) {
    final getStyle = _variants[variant] ?? _variants["body"];
    final TextStyle? style = getStyle!(context);

    return Text(text ?? "", style: style);
  }
}
