import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/providers/cartProvider.dart';
import 'package:flutter_app_erp/widgets/protected_child.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/button_create_invoice.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/list_order_items.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/print_invoice_from_order.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:provider/provider.dart';

class SummaryOrderData extends StatelessWidget {
  final String label;
  final double amount;
  final CurrenciesResponse? currency;

  const SummaryOrderData({
    super.key,
    required this.amount,
    required this.label,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final String symbol = currency != null ? currency!.symbol : "";

    return Row(
      children: [
        const Expanded(child: SizedBox()),
        TypographyApp(text: label, variant: "h5", color: "ihnerit"),
        const SizedBox(width: 10),
        TypographyApp(
          variant: "h5",
          color: "ihnerit",
          text: "${NumberFormatterApp.format(amount)} ${symbol}".trim(),
        )
      ],
    );
  }
}

class ContainerOrderData extends StatelessWidget {
  final Function()? onAfterSave;
  final Function()? onAfterInvoice;

  const ContainerOrderData({super.key, this.onAfterInvoice, this.onAfterSave});

  Future<void> onSaveInvoice(CartProvider cart) async {
    await printInvoiceFromOrder(
        order: cart.order as OrdersResponse, articles: cart.articles);
    onAfterInvoice!();
  }

  Widget buildTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TypographyApp(
            variant: "h4",
            color: "ihnerit",
            text: "Facturado",
          ),
        ),
      ],
    );
  }

  Widget buildFooter(OrdersResponse? order) {
    final double subtotal = order == null ? 0.0 : order.subtotal;
    final double taxAmount = order == null ? 0.0 : order.taxAmount;
    final double total = order == null ? 0.0 : order.total;
    final CurrenciesResponse? currency = order?.currency;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SummaryOrderData(
                  amount: subtotal,
                  label: "Subtotal",
                  currency: currency,
                ),
                SummaryOrderData(
                  amount: taxAmount,
                  label: "Impuesto",
                  currency: currency,
                ),
                SummaryOrderData(
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

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final OrdersResponse? order = cartProvider.order;
    final Brightness currentBrightness = Theme.of(context).brightness;
    final Color background =
        currentBrightness == Brightness.dark ? Color(0x10101010) : Colors.white;

    return Row(
      children: [
        Expanded(
          child: Column(children: [
            buildTitle(),
            Expanded(
              child: Container(
                color: background,
                child: ListOrderItems(
                  onAfterSave: onAfterSave,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              color: background,
              child: buildFooter(order),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonCreateInvoice(
                onSave: () => onSaveInvoice(cartProvider),
                orderId: cartProvider.orderId,
                disabled: cartProvider.articles.isEmpty,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProtectedChild(
                roles: [RolesConstants.customer()],
                child: ElevatedButton(
                  onPressed: () => onAfterInvoice!(),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      SizedBox(width: 5),
                      TypographyApp(text: 'Guardar'),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
