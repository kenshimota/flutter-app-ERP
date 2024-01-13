import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/add_product_to_orden_button.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class ShowCardItem extends StatelessWidget {
  final void Function()? onAdded;
  final ProductsPricesResponse productPrice;

  const ShowCardItem({
    super.key,
    required this.productPrice,
    this.onAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: SizedBox(
            height: 370,
            width: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: <Widget>[
                  const Image(
                    image: NetworkImage(
                        'https://img.freepik.com/foto-gratis/manos-solamente-mecanico-sosteniendo-neumatico-taller-reparacion-reemplazo-neumaticos-invierno-verano_146671-16784.jpg?size=626&ext=jpg&ga=GA1.1.1687694167.1703548800&semt=sph'),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TypographyApp(
                                  text: productPrice.product!.name,
                                  variant: "h5",
                                  color: "black",
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FormControl(
                                child: TypographyApp(
                                  text:
                                      "${NumberFormatterApp.format(productPrice.price)}${productPrice.currency!.symbol} (${productPrice.currency!.code})",
                                  variant: "subtitle1",
                                  color: "black",
                                ),
                              ),
                            ],
                          ),
                          FormControl(
                            child: AddProductToOrdenButton(
                              onAdded: onAdded,
                              productId: productPrice.productId,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
