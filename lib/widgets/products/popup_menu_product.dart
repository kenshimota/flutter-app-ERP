import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products/products_response.dart';
import 'package:flutter_app_erp/widgets/products/button_delete_product.dart';
import 'package:flutter_app_erp/widgets/products/dialog_edit_product.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class PopupMenuProduct extends StatelessWidget {
  final ProductsResponse product;
  final void Function()? onAfterChange;

  const PopupMenuProduct({
    super.key,
    this.onAfterChange,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return PopupProduct(
      onAfterChange: onAfterChange,
      product: product,
    );
  }
}

class PopupProduct extends StatefulWidget {
  final void Function()? onAfterChange;
  final ProductsResponse product;

  const PopupProduct({
    super.key,
    this.onAfterChange,
    required this.product,
  });

  @override
  State<PopupProduct> createState() => _PopupProductState();
}

class _PopupProductState extends State<PopupProduct> {
  Color? color;
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,
      onSelected: (SampleItem item) {
        Widget Function(BuildContext)? builder;
        setState(() {
          selectedMenu = item;
        });

        if (item == SampleItem.itemOne) {
          builder = (context) => AlertDialogEditProduct(
                product: widget.product,
                onSave: widget.onAfterChange,
              );
        } else if (item == SampleItem.itemTwo) {
          builder = (context) => AlertDialogDeleteProduct(
                productId: widget.product.id,
                onAfterDelete: widget.onAfterChange,
              );
        }

        if (builder != null) {
          showDialog(context: context, builder: builder);
        }
      },
      itemBuilder: (
        BuildContext context,
      ) =>
          <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: TypographyApp(
            text: 'Editar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: TypographyApp(
            text: 'Eliminar',
            variant: "subtitle2",
            color: "white",
          ),
        ),
      ],
    );
  }
}
