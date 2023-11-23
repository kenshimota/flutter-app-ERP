import 'package:flutter/material.dart';

class PaddingTileApp extends StatelessWidget {
  final Widget child;

  const PaddingTileApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}

class ListTileApp extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? content;

  const ListTileApp({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.content,
  });

  buildTitle(BuildContext context) {
    final List<Widget> children = [title];

    if (subtitle != null) {
      children.add(subtitle as Widget);
    }

    return Row(children: [
      Expanded(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: children),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (leading != null) {
      children.add(PaddingTileApp(child: leading as Widget));
    }

    children.add(Expanded(
      child: PaddingTileApp(child: buildTitle(context)),
    ));

    if (trailing != null) {
      children.add(PaddingTileApp(child: trailing as Widget));
    }

    return Row(
      children: children,
    );
  }
}
