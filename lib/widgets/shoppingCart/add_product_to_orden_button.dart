import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/shoppingCart/add_quantity_of_product.dart';

class AddProductToOrdenButton extends StatefulWidget {
  final int productId;
  final Function()? onAdded;

  const AddProductToOrdenButton({
    super.key,
    required this.productId,
    this.onAdded,
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

  onAdded() {
    onClose();
    widget.onAdded!();
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
        onAdded: onAdded,
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
