import 'package:flutter/material.dart';

class SliceColumn extends StatelessWidget {
  final List<Widget>? children;

  const SliceColumn({super.key, this.children});

  Widget buildItem(Widget child) => Flexible(flex: 1, child: child);

  Widget buildRow(List<Widget> children) {
    return Expanded(
      child: Row(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> last = [];
    List<Widget> nodes = [];
    List<Widget> children = this.children ?? [];

    for (int i = 0; i < children.length; i++) {
      final Widget child = children[i];
      last.add(buildItem(child));

      if (last.isNotEmpty && last.length % 2 == 0) {
        nodes.add(buildRow(last));
        last = [];
      }
    }

    if (last.isNotEmpty) {
      nodes.add(buildRow(last));
      last = [];
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            children: nodes,
          ),
        ),
      ],
    );
  }
}
