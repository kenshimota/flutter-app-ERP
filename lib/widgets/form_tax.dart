import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/button_create_tax.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_tax.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
// import elevateFuture
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';

class FormTax extends StatefulWidget {
  const FormTax({super.key});
  @override
  State<FormTax> createState() => _FormTaxState();
}

class _FormTaxState extends State<FormTax> {
  @override
  Widget build(BuildContext context) {
    return const Form(
      child: Column(
        children: [
          FormControl(
            child: InputName(),
          ),
          FormControl(
            child: InputPercentage(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormControl(
                child: ButtonCreateTax(
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                ),
              ),
              // SizedBox(width: 10,),
              FormControl(
                child: ButtonCloseDialog(
                  icon: Icon(Icons.close),
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
  const ButtonCloseDialog({super.key, required this.icon});
  @override
  Widget build(BuildContext context) {
    return ElevatedButtonFuture(
      onPressed: () => {},
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
