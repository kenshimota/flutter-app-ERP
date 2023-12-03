import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ColumnCell extends StatelessWidget {
  final String subtitle;
  final String content;

  const ColumnCell({
    super.key,
    required this.subtitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: TypographyApp(
              text: subtitle,
              variant: "subtitle2",
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: OverflowBox(
              maxWidth: null,
              child: TypographyApp(
                text: content,
                variant: "body1",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
