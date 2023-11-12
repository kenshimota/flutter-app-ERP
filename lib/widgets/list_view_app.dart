import 'package:flutter/material.dart';

import 'package:flutter_app_erp/core/response/response_base.dart';
import 'package:flutter_app_erp/widgets/list_view_scrolling_infinite.dart';

class ListViewApp extends StatefulWidget {
  final int page;
  final Future? future;
  final void Function()? onNext;
  final List<ResponseBase> listItems;
  final Widget Function(BuildContext, dynamic) buildItems;

  const ListViewApp({
    super.key,
    this.page = 1,
    this.future,
    this.onNext,
    required this.buildItems,
    required this.listItems,
  });

  @override
  State<ListViewApp> createState() => _ListViewApp();
}

class _ListViewApp extends State<ListViewApp> {
  List<ResponseBase> resources = [];

  @override
  void didUpdateWidget(ListViewApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    List<ResponseBase> aux = resources;

    int maxElement = (widget.page - 1) * 20;

    while (aux.isNotEmpty && aux.length > maxElement) {
      aux.removeLast();
    }

    if (widget.listItems != oldWidget.listItems) {
      List<ResponseBase> temp = widget.listItems;

      for (ResponseBase tax in temp) {
        aux.add(tax);
      }

      setState(() {
        resources = aux;
      });
    }
  }

  Widget circuleProgress(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(color: color),
          ),
        )
      ],
    );
  }

  Widget buildLayout({required BuildContext context, loading = false}) {
    List<Widget> children =
        resources.map((e) => widget.buildItems(context, e)).toList();

    if (loading) {
      children.add(circuleProgress(context));
    }

    return ListViewScrollingInfinite(
      onNext: widget.onNext,
      children: children,
    );
  }

  Widget futureBuild(BuildContext context, AsyncSnapshot snapshot) {
    final bool loading = snapshot.connectionState == ConnectionState.waiting;
    return buildLayout(context: context, loading: loading);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.future == null) {
      return buildLayout(context: context);
    }

    return FutureBuilder(future: widget.future, builder: futureBuild);
  }
}
