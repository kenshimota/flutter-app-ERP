import 'package:flutter/material.dart';

class ListViewScrollingInfinite extends StatefulWidget {
  final List<Widget>? children;
  final void Function()? onNext;

  const ListViewScrollingInfinite({
    super.key,
    this.onNext,
    this.children,
  });

  @override
  State<ListViewScrollingInfinite> createState() =>
      _ListViewScrollingInfinite();
}

class _ListViewScrollingInfinite extends State<ListViewScrollingInfinite> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    double offset = _scrollController.offset;
    final List<Widget> auxChildren = widget.children ?? [];
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    bool outOfRange = _scrollController.position.outOfRange;

    if (auxChildren.isEmpty || auxChildren.length % 20 != 0) {
      return;
    }

    if (offset >= maxScrollExtent && !outOfRange) {
      widget.onNext!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auxChildren = widget.children ?? [];

    return ListView.builder(
      controller: _scrollController,
      itemCount: auxChildren.length,
      itemBuilder: (BuildContext context, int index) {
        return auxChildren[index];
      },
    );
  }
}
