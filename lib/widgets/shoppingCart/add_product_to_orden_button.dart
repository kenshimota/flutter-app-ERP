import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/add_quantity_of_product.dart';

class AddProductToOrdenButton extends StatefulWidget {
  final int productId;

  const AddProductToOrdenButton({
    super.key,
    required this.productId,
  });

  @override
  State<AddProductToOrdenButton> createState() => _AddProductToOrdenButton();
}

class _AddProductToOrdenButton extends State<AddProductToOrdenButton> {
  bool showButton = true;

  onClose() {
    setState(() {
      showButton = true;
    });
  }

  onAdd() {
    setState(() {
      showButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showButton == false) {
      return AddQuantityProducts(
        onClose: onClose,
        productId: widget.productId,
      );
    }

    return ElevatedButtonFuture(
      onPressed: () => onAdd(),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
      ),
      child: const Text(
        'Añadir al carrito',
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
