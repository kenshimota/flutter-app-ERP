import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/create_tax.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';
import 'package:flutter_app_erp/widgets/button_create_tax.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_tax.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
// import elevateFuture
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class FormTax extends StatefulWidget {
  final void Function()? onClick;

  final void Function()? onAfterSave;
  const FormTax(
      {super.key, this.onClick, this.onAfterSave});

  @override
  State<FormTax> createState() => _FormTaxState();
}

class _FormTaxState extends State<FormTax> {
  Future? futureCreateTax;
  TextEditingController name = TextEditingController();
  TextEditingController percentage = TextEditingController();

  String message = 'No se pudo crear el impuesto';

  Future<void> onCreateRequeste(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();
    
    debugPrint("before request");

    double amount = double.parse(percentage.text);

     await createTax(
      token: token,
      name: name.text,
      percentage: amount / 100,
    );

    if (!context.mounted) {
      return;
    }
    
    widget.onAfterSave!();    
  }

  onSubmit(BuildContext context) {
    setState(() {
      futureCreateTax = onCreateRequeste(context);
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

  const ButtonCloseDialog({super.key, required this.icon, this.future,});


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
