import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_address.dart';

import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/button_create_warehouse.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

class FormWarehouse extends StatefulWidget {
  final String? nameDefault;
    final String? addressDefault;
  final void Function()? onClick;
   final FormErrors? errors;
  final Future<void> Function(Map<String, dynamic>)? onRequest;

  const FormWarehouse({
    super.key,
    this.nameDefault,
    this.addressDefault,
    this.onClick,
    this.onRequest,
    this.errors
  });

  @override
  State<FormWarehouse> createState() => _FormWarehouseState();
}

class _FormWarehouseState extends State<FormWarehouse> {
  Future? futureCreateWarehouse;
  String message = 'No se pudo crear el deposito';

  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  initState() {
    name.text = widget.nameDefault ?? "";
     name.text = widget.nameDefault ?? "";
    super.initState();
  }

  onSubmit(BuildContext context) {
    Map<String, dynamic> params = {
      "name": name.text,
      "address": address.text,
    };

    setState(() {
      futureCreateWarehouse = widget.onRequest!(params);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          FormControl(
            child: InputName(controller: name, 
            errorText: widget.errors?.getValue("name"),
            ),
            
          ),
           FormControl(
            child: InputAddress(controller: address,
            errorText: widget.errors?.getValue("address"),
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormControl(
                child: ButtonCreateWarehouse(
                  future: futureCreateWarehouse,
                  icon: const Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  onClick: () => onSubmit(context),
                ),
              ),
              // SizedBox(width: 10,),
              FormControl(
                child: ButtonCloseDialog(
                  future: futureCreateWarehouse,
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// Button para cerrar el dialogo

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