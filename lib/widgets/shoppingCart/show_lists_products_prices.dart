import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/modelo_card_product_price.dart';

class ShowListProductsPricesCards extends StatefulWidget{
  final List<ProductsPricesResponse> list;


  const ShowListProductsPricesCards({
    super.key,
    required this.list,
  });

  @override
  State<ShowListProductsPricesCards> createState() => _ShowListProductsPricesCards();
}

class _ShowListProductsPricesCards extends State<ShowListProductsPricesCards>{

  @override
  Widget build(BuildContext context){
    final List<ShowCardItem> cards = widget.list.
      map(
        (productPrice) => ShowCardItem(
          productPrice: productPrice,
        ),
      ).toList();

      return Row(
        children: cards,
      );
  }
}