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
      return ElevatedButton(
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

          return ElevatedButton(
            onPressed: loading ? null : onPressed,
            style: style,
            child: child,
          );
        });
  }
}
