import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/response/customers/customers_response.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter_app_erp/core/pdf/print_document.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';
import 'package:pdf/widgets.dart' as pw;

Widget summaryOrderDataItem({
  required String label,
  required double amount,
  required CurrenciesResponse currency,
}) {
  final String symbol = currency.symbol;

  return Row(
    children: [
      Expanded(child: SizedBox()),
      Text(label),
      SizedBox(width: 10),
      Text("${NumberFormatterApp.format(amount)} $symbol".trim())
    ],
  );
}

Widget summaryItemHeader() => Row(
      children: [
        Expanded(
            child: Text(
          "Descripción",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        SizedBox(width: 5),
        SizedBox(
            width: 60, child: fieldAmount(amountStr: "Cantidad", bold: true)),
        SizedBox(width: 5),
        SizedBox(width: 60, child: fieldAmount(amountStr: "C/U", bold: true)),
        SizedBox(width: 5),
        SizedBox(
            width: 60, child: fieldAmount(amountStr: "Subtotal", bold: true)),
        SizedBox(width: 5),
        SizedBox(
            width: 60, child: fieldAmount(amountStr: "Impuesto", bold: true)),
        SizedBox(width: 5),
        SizedBox(width: 60, child: fieldAmount(amountStr: "Total", bold: true)),
      ],
    );

Widget fieldAmount(
    {String symbol = "", required String amountStr, bool bold = false}) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    Expanded(child: SizedBox()),
    Text(
      "$amountStr $symbol".trim(),
      style: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    ),
  ]);
}

Widget summaryItem({
  required OrdersItemsResponse item,
  required CurrenciesResponse currency,
}) {
  final ProductsResponse product = item.product as ProductsResponse;
  final String symbol = currency.symbol;

  return Row(
    children: [
      Expanded(child: Text("(${product.code}) ${product.name}")),
      SizedBox(width: 5),
      SizedBox(
        width: 60,
        child: fieldAmount(
          amountStr: NumberFormatterApp.amount(item.quantity),
        ),
      ),
      SizedBox(width: 5),
      SizedBox(
        width: 60,
        child: fieldAmount(
          symbol: symbol,
          amountStr: NumberFormatterApp.format(item.priceWithoutTax),
        ),
      ),
      SizedBox(width: 5),
      SizedBox(
        width: 60,
        child: fieldAmount(
          symbol: symbol,
          amountStr: NumberFormatterApp.format(
            item.subtotal,
          ),
        ),
      ),
      SizedBox(width: 5),
      SizedBox(
        width: 60,
        child: fieldAmount(
          symbol: symbol,
          amountStr: NumberFormatterApp.format(item.taxAmount),
        ),
      ),
      SizedBox(width: 5),
      SizedBox(
        width: 60,
        child: fieldAmount(
          symbol: symbol,
          amountStr: NumberFormatterApp.format(
            item.total,
          ),
        ),
      ),
    ],
  );
}

Widget buildFooter(OrdersResponse order) {
  final double subtotal = order.subtotal;
  final double taxAmount = order.taxAmount;
  final double total = order.total;
  final CurrenciesResponse currency = order.currency as CurrenciesResponse;

  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              summaryOrderDataItem(
                amount: subtotal,
                label: "Subtotal",
                currency: currency,
              ),
              summaryOrderDataItem(
                amount: taxAmount,
                label: "Impuesto",
                currency: currency,
              ),
              summaryOrderDataItem(
                amount: total,
                label: "Total",
                currency: currency,
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget buildContent(
    List<OrdersItemsResponse> articles, CurrenciesResponse currency) {
  return Row(
    children: [
      Expanded(
        child: Column(
          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ARTICULOS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                summaryItemHeader(),
                SizedBox(height: 10)
              ] +
              articles
                  .map(
                    (item) => Row(children: [
                      Expanded(
                        child: Column(
                          children: [
                            summaryItem(item: item, currency: currency),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                    ]),
                  )
                  .toList(),
        ),
      )
    ],
  );
}

Widget buildHeaderItem({required String label, required String content}) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text("$label:", style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(width: 5),
    Expanded(child: Text(content))
  ]);
}

Widget buildHeader({
  required OrdersResponse order,
  required CustomersResponse customer,
  required UserResponse user,
}) {
  var image;
  return Row(children: [
    Expanded(
        child: Column(children: [
        pw.Center(child: ),
      buildHeaderItem(
        label: "N°",
        content: NumberFormatterApp.filled(order.number),
      ),
      buildHeaderItem(
        label: "Cliente", content: "${customer.name} ${customer.lastName}"),
      buildHeaderItem(
        label: "Empleado", content: "${user.firstName} ${user.lastName}"),
      buildHeaderItem(
        label: "Fecha",
        content: DateFormatterApp.dateTimeFormatter(order.updatedAt),
      ),
      buildHeaderItem(
        label: "Telefono",
        content: "02832355870",
      ),
      buildHeaderItem(
        label: "R.I.F",
        content: "J-29888209-3",
      ),
      buildHeaderItem(
        label: "Direccion",
        content: "Carretera salida a pariaguan locales 1 y 2 sector la Charneca la botella.",
      ),
    ]))
  ]);
}

Future<void> printInvoiceFromOrder({
  required OrdersResponse order,
  required List<OrdersItemsResponse> articles,
}) {
  return printDocument(
    build: (Context context) {
      final UserResponse user = order.user as UserResponse;
      final CustomersResponse customer = order.customer as CustomersResponse;
      final CurrenciesResponse currency = order.currency as CurrenciesResponse;

      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: buildHeader(
                    order: order,
                    customer: customer,
                    user: user,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: buildContent(articles, currency),
                  ),
                ),
                Container(
                  height: 80,
                  child: buildFooter(order),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
