import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_products.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_warehouses.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/inventories/input_observations.dart';
import 'package:flutter_app_erp/widgets/inventories/input_stock.dart';
import 'package:provider/provider.dart';

class FormInventory extends StatefulWidget {
  final int? stockDefault;
  final FormErrors? errors;
  final bool isEdit;
  final String? observationsDefault;
  final void Function()? onClick;
  final Future<void> Function(Map<String, dynamic>)? onRequest;

  const FormInventory({
    super.key,
    this.onClick,
    this.onRequest,
    this.errors,
    this.stockDefault,
    this.isEdit = false,
    this.observationsDefault,
  });

  @override
  State<FormInventory> createState() => _FormInventoryState();
}

class _FormInventoryState extends State<FormInventory> {
  Future? future;
  int productId = 0;
  int warehouseId = 0;
  TextEditingController _stock = TextEditingController();
  TextEditingController _observations = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _stock.text = "${widget.stockDefault ?? ""}";
    _observations.text = "${widget.observationsDefault ?? ""}";
  }

  onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    Map<String, dynamic> params = {
      "stock": int.parse(_stock.text),
      "product_id": productId,
      "warehouse_id": warehouseId,
      "observations": _observations.text,
    };

    setState(() {
      future = widget.onRequest!(params);
    });
  }

  List<Widget> buildFields(BuildContext context) {
    final List<Widget> children = [];
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    if (widget.isEdit == false) {
      children.add(FormControl(
        child: AutocompleteProducts(
          token: token ?? "",
          onSelect: (product) => {
            setState(() {
              productId = product["id"];
            })
          },
        ),
      ));

      children.add(
        FormControl(
          child: AutocompleteWarehouses(
            token: token ?? "",
            onSelect: (warehouse) => {
              setState(() {
                warehouseId = warehouse["id"];
              })
            },
          ),
        ),
      );
    }

    return [
      ...children,
      FormControl(
        child: InputStock(
          controller: _stock,
          errorText: widget.errors?.getValue("stock"),
        ),
      ),
      FormControl(
        child: InputObservations(
          controller: _observations,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(children: buildFields(context)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormControl(
                        child: _ButtonCreateInventory(
                          future: future,
                          icon: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onClick: () => onSubmit(context),
                        ),
                      ),
                      FormControl(
                        child: ButtonCloseDialog(
                          future: future,
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class _ButtonCreateInventory extends StatelessWidget {
  final Icon icon;
  final Future? future;
  final void Function()? onClick;

  const _ButtonCreateInventory({
    this.future,
    this.onClick,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonFuture(
      future: future,
      onPressed: onClick,
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 5,
          ),
          const Text('Guardar'),
        ],
      ),
    );
  }
}

class ButtonCloseDialog extends StatelessWidget {
  final Icon icon;
  final Future? future;

  const ButtonCloseDialog({
    super.key,
    required this.icon,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonFuture(
      future: future,
      onPressed: () => {Navigator.pop(context)},
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 5,
          ),
          const Text('Cerrar')
        ],
      ),
    );
  }
}
