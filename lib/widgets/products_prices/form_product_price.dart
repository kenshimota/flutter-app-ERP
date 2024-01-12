import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/http/products_prices/create_products_prices.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_currencies.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_products.dart';
import 'package:flutter_app_erp/widgets/input_exchange_rate.dart';
import 'package:provider/provider.dart';

class FormProductPrice extends StatefulWidget {
   final int? currencyIdDefault;
  final int? productDefault;
  final double? priceDefault;
  final String token;
  final FormErrors? errors;
  final Future<void> Function(Map<String, dynamic>)? onRequest;
  const FormProductPrice({
    super.key,
    this.currencyIdDefault,
    this.productDefault,
    this.priceDefault,
    this.onRequest,
    this.errors,
    required this.token,
  });

  @override
  State<FormProductPrice> createState() => _FormProductPrice();
}

class _FormProductPrice extends State<FormProductPrice> {
  int? currencyId;
  int? productId;
    TextEditingController currency = TextEditingController();
  TextEditingController product = TextEditingController();
  TextEditingController price = TextEditingController();
  Future? future;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  


  onSubmit() {
    if (!_formkey.currentState!.validate()) {
      return null;
    }

     Map<String, dynamic> params = {
      "currency_id": currencyId,
      "product_id": productId,
      "price": double.parse(price.text),
    };

    setState(() {
      future = widget.onRequest!(params);
    });
  }

  onSelect(Map<String, dynamic>? currency) {
    setState(() {
      int? value = currency == null ? null : currency["id"];
      currencyId = value;
    });
  }

  onSelectProduct(Map<String, dynamic>? product) {
    setState(() {
      int? value = product == null ? null : product["id"];
      productId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
                FormControl(
                  child: AutocompleteCurrencies(
                    token: widget.token,
                    onSelect: onSelect,
                  ),
                ),
                FormControl(
                    child: AutocompleteProducts(
                      token: widget.token,
                      onSelect: onSelectProduct,
                    ),
                ),
                FormControl(
                  child: InputExchangeRate(
                    label: 'Precio',
                    isRequired: true,
                    future: future,
                    exchangeRate: price,
                  )
                ),
                FormControl(
                  child: ElevatedButtonFuture(
                    onPressed: () => onSubmit(),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Crear Producto'),
                  ),
                ),
            ],
          )),
        ],
      ),
    );
  }
}
