import 'package:flutter/material.dart';

final Map<String, TextStyle? Function(BuildContext)> _variants = {
  "h1": (BuildContext context) => Theme.of(context).textTheme.headlineLarge,
  "h2": (BuildContext context) => Theme.of(context).textTheme.headlineMedium,
  "h3": (BuildContext context) => Theme.of(context).textTheme.headlineSmall,
  "h4": (BuildContext context) => Theme.of(context).textTheme.titleLarge,
  "h5": (BuildContext context) => Theme.of(context).textTheme.titleMedium,
  "h6": (BuildContext context) => Theme.of(context).textTheme.titleSmall,
  "subtitle1": (BuildContext context) => Theme.of(context).textTheme.labelLarge,
  "subtitle2": (BuildContext context) =>
      Theme.of(context).textTheme.labelMedium,
  "subtitle3": (BuildContext context) => Theme.of(context).textTheme.labelSmall,
  "body": (BuildContext context) => Theme.of(context).textTheme.bodySmall,
};

final Map<String, TextStyle? Function(BuildContext)> _colors = {
  "inherit": (BuildContext context) => const TextStyle(color: Colors.black),
  "primary": (BuildContext context) => const TextStyle(color: Colors.pink),
  "secondary": (BuildContext context) => const TextStyle(color: Colors.pink),
  "white": (BuildContext context) => const TextStyle(color: Colors.white),
};

class TypographyApp extends StatelessWidget {
  final String? text;
  final String? color;
  final String? variant;

  const TypographyApp({
    super.key,
    required this.text,
    this.variant,
    this.color = "inherit",
  });

  @override
  Widget build(BuildContext context) {
    final getStyle = _variants[variant] ?? _variants["body"];
    final getColor = _colors[color] ?? _colors["inherit"];
    TextStyle? style = getStyle!(context);

    if (style != null) {
      style = style.merge(getColor!(context));
    } else {
      style = getColor!(context);
    }

    return Text(text ?? "", style: style);
  }
}
