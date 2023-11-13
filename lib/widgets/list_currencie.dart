import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/ formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/widgets/popup_menu_currencie.dart';

class ArticleCurrencie extends StatelessWidget {
  final CurrenciesResponse currencie;
  final void Function()? onAfterChange;

  const ArticleCurrencie({
    super.key,
    this.onAfterChange,
    required this.currencie,
  });

  @override
  Widget build(BuildContext context) {
    final String name = currencie.name;
    final String symbol = currencie.symbol;
    final double exchangeRate = currencie.exchangeRate;
    final String firstLetter = name[0].toUpperCase();
    var sizedBox = SizedBox(
      child: CircleAvatar(child: Text(firstLetter)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: sizedBox,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                    Text(
                      symbol,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      NumberFormatterApp.format(exchangeRate),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: PopupMenuCurrencie(
                currencie: currencie,
                onAfterChange: onAfterChange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ListTileApp extends StatelessWidget {
  final List<CurrenciesResponse> listcurrencie;

  final void Function()? onAfterChange;
  final Widget? leading;

  const ListTileApp({
    super.key,
    required this.listcurrencie,
    this.leading,
    this.onAfterChange,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> currencies = listcurrencie
        .map((currencie) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArticleCurrencie(
                  currencie: currencie,
                  onAfterChange: onAfterChange,
                ),
                const Divider(
                  height: 1,
                ),
              ],
            ))
        .toList();

    return ListView(
      children: currencies,
    );
  }
}
