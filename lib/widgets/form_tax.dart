import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_tax.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/button_create_tax.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

class FormTax extends StatefulWidget {
  final String? nameDefault;
  final String? percentageDefault;
  final void Function()? onClick;
  final FormErrors? errors;
  final Future<void> Function(Map<String, dynamic>)? onRequest;

  const FormTax(
      {super.key,
      this.onClick,
      this.onRequest,
      this.nameDefault,
      this.percentageDefault,
      this.errors});

  @override
  State<FormTax> createState() => _FormTaxState();
}

class _FormTaxState extends State<FormTax> {
  Future? futureCreateTax;
  String message = 'No se pudo crear el impuesto';
  TextEditingController name = TextEditingController();
  TextEditingController percentage = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  initState() {
    name.text = widget.nameDefault ?? "";
    percentage.text = widget.percentageDefault ?? "";
    super.initState();
  }

  onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return null;
    }


    Map<String, dynamic> params = {
      "name": name.text,
      "percentage": double.parse(percentage.text)  / 100
    };

    setState(() {
      futureCreateTax = widget.onRequest!(params);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormControl(
            child: InputName(
              controller: name,
              future: futureCreateTax,
              isRequired: true,
              errorText: widget.errors?.getValue("name"),
            ),
          ),
          FormControl(
            child: InputPercentage(
              percentage: percentage,
              future: futureCreateTax,
              errorText: widget.errors?.getValue("percentage"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormControl(
                child: ButtonCreateTax(
                  future: futureCreateTax,
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
                  future: futureCreateTax,
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
