import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_base_app.dart';

class InputObservations extends StatelessWidget {
  final bool enabled;
  final String? label;

  final String? placeholder;
  final String? errorText;
  final Future? future;
  final TextEditingController? controller;

  const InputObservations({
    super.key,
    this.controller,
    this.placeholder,
    this.label = 'Observaciones',
    this.enabled = true,
    this.errorText,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    return InputBaseApp(
      enabled: enabled,
      label: label,
      future: future,
      errorText: errorText,
      placeholder: placeholder,
      controller: controller,
    );
  }
}
