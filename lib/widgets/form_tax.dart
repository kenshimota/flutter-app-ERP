import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_tax.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/button_create_tax.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';

class FormTax extends StatefulWidget {
  final String? nameDefault;
  final String? percentageDefault;
  final void Function()? onClick;
  final Future<void> Function(Map<String, dynamic>)? onRequest;

  const FormTax(
      {super.key,
      this.onClick,
      this.onRequest,
      this.nameDefault,
      this.percentageDefault});

  @override
  State<FormTax> createState() => _FormTaxState();
}

class _FormTaxState extends State<FormTax> {
  Future? futureCreateTax;
  String message = 'No se pudo crear el impuesto';

  TextEditingController name = TextEditingController();
  TextEditingController percentage = TextEditingController();

  @override
  void initState() {
    name.text = widget.nameDefault ?? "";
    percentage.text = widget.percentageDefault ?? "";
  }

  onSubmit(BuildContext context) {
    Map<String, dynamic> params = {
      "name": name.text,
      "percentage": double.parse(percentage.text) / 100
    };

    setState(() {
      futureCreateTax = widget.onRequest!(params);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          FormControl(
            child: InputName(controller: name),
          ),
          FormControl(
            child: InputPercentage(percentage: percentage),
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
