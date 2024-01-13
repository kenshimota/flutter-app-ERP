import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/providers/cartProvider.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/input_quantity_of_product.dart';

class AddQuantityProducts extends StatefulWidget {
  final int productId;
  final Function()? onAdded;
  final Function()? onClose;

  const AddQuantityProducts({
    super.key,
    this.onClose,
    this.onAdded,
    required this.productId,
  });

  @override
  State<AddQuantityProducts> createState() => _AddQuantityProducts();
}

class _AddQuantityProducts extends State<AddQuantityProducts> {
  Future? future;
  FormErrors errors = FormErrors(map: {});
  TextEditingController quantity = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  onRequestApi({required BuildContext context}) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final String token = authProvider.getToken() as String;

    try {
      await cartProvider.addItem(
        token: token,
        productId: widget.productId,
        quantity: int.parse(quantity.text),
      );

      widget.onAdded!();
    } on FormErrors catch (e) {
      setState(() {
        errors = e;
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  onSubmit({required BuildContext context}) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    setState(() {
      future = onRequestApi(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormControl(
            child: InputQuantityOfProduct(
              quantity: quantity,
              future: future,
              label: 'Cantidad',
              onCancel: () => widget.onClose!(),
              onSubmit: () => onSubmit(context: context),
            ),
          ),
        ],
      ),
    );
  }
}
