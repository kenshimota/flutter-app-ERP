import 'package:flutter/material.dart';

class AlertDialogApp extends StatelessWidget {
  final Widget title;
  final double maxWidth;
  final double maxHeight;
  final List<Widget>? content;

  const AlertDialogApp({
    super.key,
    required this.title,
    this.content,
    this.maxWidth = 300,
    this.maxHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    final children = content ?? <Widget>[];

    return AlertDialog(
      content: SizedBox(
        width: maxWidth,
        height: maxHeight,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: title,
                  ),
                  Expanded(
                    child: Row(children: [
                      Expanded(
                        child: Column(children: children),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
