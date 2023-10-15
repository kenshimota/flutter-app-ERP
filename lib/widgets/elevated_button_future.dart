import 'package:flutter/material.dart';

class ElevatedButtonFuture extends StatelessWidget {
  final Widget? child;
  final Future? future;
  final ButtonStyle? style;
  final void Function()? onPressed;

  const ElevatedButtonFuture({
    super.key,
    this.style,
    this.child,
    this.future,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return _ElevatedButtonFuture(
        onPressed: onPressed,
        style: style,
        child: child,
      );
    }

    return FutureBuilder(
        future: future,
        builder: (ctx, snapshot) {
          final bool loading =
              snapshot.connectionState == ConnectionState.waiting;

          return _ElevatedButtonFuture(
            onPressed: loading ? null : onPressed,
            style: style,
            child: child,
          );
        });
  }
}

class _ElevatedButtonFuture extends StatelessWidget {
  final Widget? child;
  final ButtonStyle? style;
  final void Function()? onPressed;

  const _ElevatedButtonFuture({
    super.key,
    this.child,
    this.style,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double fontSize = maxWidth > 100 ? 14 : 10;
    final double padding = maxWidth > 100 ? 8 : 4;

    final decorator = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(vertical: padding, horizontal: padding * 2)),
      iconSize: MaterialStateProperty.all<double>(fontSize),
      textStyle:
          MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: fontSize)),
    ).merge(style);

    return ElevatedButton(
      onPressed: onPressed,
      style: decorator,
      child: child,
    );
  }
}
