import  'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/products_prices/products_prices_response.dart';
import 'package:flutter_app_erp/widgets/products_prices/button_edit_product_price.dart';
import 'package:flutter_app_erp/widgets/products_prices/button_delete_product_price.dart';
import 'package:flutter_app_erp/widgets/products_prices/dialog_edit_product_price.dart';

enum SampleItem {
  itemOne, 
  itemTwo
}

class PopupMenuProductsPrices extends StatelessWidget {
  final void Function()? onAfterChange;
  final ProductsPricesResponse productPrice;

  const PopupMenuProductsPrices({
    super.key,
    this.onAfterChange,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context){
    return PopupProductPrice(onAfterChange: onAfterChange, productPrice: productPrice);
  }
}

class PopupProductPrice extends StatefulWidget {
  final void Function()? onAfterChange;
  final ProductsPricesResponse productPrice;

  const PopupProductPrice({
    super.key,
    this.onAfterChange,
    required this.productPrice,
  });

  @override
  State<PopupProductPrice> createState() => _PopupProductPrice();
}

class _PopupProductPrice extends State<PopupProductPrice>{
  SampleItem? selectedMenu;
  Color? color;

 

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
          builder = (context) => AlertDialogEditProductPrice(
                productPrice: widget.productPrice,
                onSave: widget.onAfterChange,
              );
        } else if (item == SampleItem.itemTwo) {
          builder = (context) => AlertDialogDelete(
                productPriceId: widget.productPrice.id,
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
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text(
            'Eliminar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}