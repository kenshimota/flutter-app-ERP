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
  "inherit": (BuildContext context) {
    final Brightness currentBrightness = Theme.of(context).brightness;

    if (currentBrightness == Brightness.dark) {
      return const TextStyle(color: Color(0xf9f9f9f9));
    }

    return const TextStyle(color: Colors.black);
  },
  "primary": (BuildContext context) => TextStyle(color:  Theme.of(context).colorScheme.primary ),
  "secondary": (BuildContext context) => TextStyle(color: Theme.of(context).colorScheme.primary ),
  "white": (BuildContext context) => const TextStyle(color: Colors.white),
  "error": (BuildContext context) =>
      TextStyle(color: Theme.of(context).colorScheme.error),
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

    return Text(
      text ?? "",
      style: style,
      overflow: TextOverflow.ellipsis,
    );
  }
}
