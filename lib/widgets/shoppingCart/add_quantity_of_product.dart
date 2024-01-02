import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/input_quantity_of_product.dart';

class AddQuantityProducts extends StatefulWidget {
  const AddQuantityProducts({
    super.key,
  });

  @override
  State<AddQuantityProducts> createState() => _AddQuantityProducts();
}

class _AddQuantityProducts extends State<AddQuantityProducts> {
  TextEditingController quantity = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormControl(
              child: InputQuantityOfProduct(
            quantity: quantity,
            label: 'Cantidad',
          )),
          ElevatedButtonFuture(
            onPressed: () => (),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
