import 'package:flutter/material.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/autocomplete/autocomplete_taxes.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:provider/provider.dart';

class FormProduct extends StatefulWidget {
  final String? nameDefault;
  final String? codeDefault;
  final FormErrors? errors;
  final String? barCodeDefault;
  final void Function()? onClick;
  final Future<void> Function(Map<String, dynamic>)? onRequest;

  const FormProduct({
    super.key,
    this.onClick,
    this.onRequest,
    this.errors,
    this.nameDefault,
    this.codeDefault,
    this.barCodeDefault,
  });

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  Future? future;
  int taxId = 0;
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController barCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    name.text = widget.nameDefault ?? "";
    code.text = widget.codeDefault ?? "";
    barCode.text = widget.barCodeDefault ?? "";
  }

  onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    Map<String, dynamic> params = {
      "name": name.text,
      "code": code.text,
      "bar_code": barCode.text,
      "tax_id": taxId,
    };

    setState(() {
      future = widget.onRequest!(params);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

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
                          child: Column(
                            children: [
                              FormControl(
                                child: AutocompleteTaxes(
                                  token: token ?? "",
                                  onSelect: (tax) => {
                                    setState(() {
                                      taxId = tax["id"];
                                    })
                                  },
                                ),
                              ),
                              FormControl(
                                child: InputName(
                                  controller: code,
                                  label: "Codigo",
                                  isRequired: true,
                                  errorText: widget.errors?.getValue("code"),
                                ),
                              ),
                              FormControl(
                                child: InputName(
                                  controller: name,
                                  isRequired: true,
                                  errorText: widget.errors?.getValue("name"),
                                ),
                              ),
                              FormControl(
                                child: InputName(
                                  label: "Codigo de Barra",
                                  controller: barCode,
                                  errorText:
                                      widget.errors?.getValue("bar_code"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormControl(
                        child: _ButtonCreateProduct(
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

class _ButtonCreateProduct extends StatelessWidget {
  final Icon icon;
  final Future? future;
  final void Function()? onClick;

  const _ButtonCreateProduct({
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
