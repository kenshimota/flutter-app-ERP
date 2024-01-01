import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/modelo_card_product_price.dart';


class ShowCardItem extends StatelessWidget {
  final ProductsPricesResponse productPrice;

  const ShowCardItem({
    super.key,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        margin: const EdgeInsets.all(15),
        elevation: 10,
        child: SizedBox(
            height: 400,
            width: 280,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Column(
                children: <Widget>[
                  const Image(
                    image: NetworkImage(
                        'https://img.freepik.com/foto-gratis/manos-solamente-mecanico-sosteniendo-neumatico-taller-reparacion-reemplazo-neumaticos-invierno-verano_146671-16784.jpg?size=626&ext=jpg&ga=GA1.1.1687694167.1703548800&semt=sph'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                       
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                         TypographyApp(
                            text: productPrice.product!.name,
                            variant: "h4",
                            color: "black",
                          ),
                        FormControl(
                          child: TypographyApp(
                            text:
                                "${productPrice.currency!.code} ${productPrice.currency!.symbol} ${productPrice.price}",
                            variant: "h4",
                            color: "black",
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                       
                        FormControl(
                          child: ElevatedButtonFuture(
                              onPressed: () => (),
                              style:ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: const Text('Añadir al carrito',
                                style: TextStyle(
                                  color:Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
