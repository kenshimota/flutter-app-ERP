import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_symbol.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/input_exchange_rate.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/button_create_curren.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';

class FormCurrencie extends StatefulWidget {
  final String? nameDefault;
  final String? symbolDefault;
  final String? codeDefault;
  final double? exchangeRateDefault;
  final void Function()? onClick;
  final FormErrors? errors;
  final Future<void> Function(Map<String, dynamic>)? onRequest;

  const FormCurrencie(
      {super.key,
      this.nameDefault,
      this.symbolDefault,
      this.codeDefault,
      this.exchangeRateDefault,
      this.onClick,
      this.onRequest,
      this.errors});

  @override
  State<FormCurrencie> createState() => _FormCurrencieState();
}

class _FormCurrencieState extends State<FormCurrencie> {
  Future? futureCreateCurrencie;
  String message = 'No se pudo crear la moneda';

  TextEditingController name = TextEditingController();
  TextEditingController symbol = TextEditingController();
   TextEditingController code = TextEditingController();
  TextEditingController exchangeRate = TextEditingController();

  @override
  initState() {
    name.text = widget.nameDefault ?? "";
    symbol.text = widget.symbolDefault ?? "";
    symbol.text = widget.codeDefault ?? "";
    exchangeRate.text = (widget.exchangeRateDefault ?? "").toString();
    super.initState();
  }

  onSubmit(BuildContext context) {
    Map<String, dynamic> params = {
      "name": name.text,
      "symbol": symbol.text,
      "code": code.text,
      "exchangeRate": double.parse(exchangeRate.text),
    };

    setState(() {
      futureCreateCurrencie = widget.onRequest!(params);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          FormControl(
            child: InputName(
              controller: name,
              errorText: widget.errors?.getValue("name"),
            ),
          ),
          FormControl(
            child: InputSymbol(
              controller: symbol,
              errorText: widget.errors?.getValue("symbol"),
            ),
          ),
           FormControl(
            child: InputName(
              controller: code,
              label: 'code',
              errorText: widget.errors?.getValue("code"),
            ),
          ),
          FormControl(
            child: InputExchangeRate(
              exchangeRate: exchangeRate,
              errorText: widget.errors?.getValue("exachangeRate"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormControl(
                child: ButtonCreateCurrencie(
                  future: futureCreateCurrencie,
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
                  future: futureCreateCurrencie,
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
