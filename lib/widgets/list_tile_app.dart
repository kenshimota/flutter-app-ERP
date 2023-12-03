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

class ListTileApp extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? content;
  final double? heightContent;

  const ListTileApp({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.content,
    this.heightContent,
  });

  State<ListTileApp> createState() => _ListTileApp();
}

class _ListTileApp extends State<ListTileApp> {
  bool _isCollapsed = false;

  buildTitle(BuildContext context) {
    final List<Widget> children = [widget.title];

    if (widget.subtitle != null) {
      children.add(widget.subtitle as Widget);
    }

    final Widget baseWidget = Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      )
    ]);

    if (widget.content == null) {
      return baseWidget;
    }

    return GestureDetector(
      onTap: () => {
        setState(
          () {
            _isCollapsed = !_isCollapsed;
          },
        )
      },
      child: baseWidget,
    );
  }

  buildContent(BuildContext context) {
    return ClipRect(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height:
            _isCollapsed ? widget.heightContent : 0, // Set initial height to 0
        child: widget.content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (widget.leading != null) {
      children.add(PaddingTileApp(child: widget.leading as Widget));
    }

    children.add(Expanded(
      child: PaddingTileApp(child: buildTitle(context)),
    ));

    if (widget.trailing != null) {
      children.add(PaddingTileApp(child: widget.trailing as Widget));
    }

    final Widget baseWidget = Row(
      children: children,
    );

    if (widget.content == null) {
      return baseWidget;
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            children: [baseWidget, buildContent(context)],
          ),
        )
      ],
    );
  }
}
