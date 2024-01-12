import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputBaseApp extends StatelessWidget {
  final bool enabled;
  final String? label;
  final Future? future;
  final String? placeholder;
  final String? errorText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const InputBaseApp({
    super.key,
    this.label,
    this.controller,
    this.errorText,
    this.enabled = true,
    this.obscureText = false,
    this.future,
    this.placeholder,
    this.validator,
    this.inputFormatters,
    this.suffixIcon,
    this.prefixIcon,
  });

  void dispose() {
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return TextFormField(
        enabled: enabled,
        obscureText: obscureText,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          hintText: placeholder,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
      );
    }

    return FutureBuilder(
      future: future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return TextFormField(
          enabled: enabled && !loading,
          controller: controller,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            labelText: label,
            errorText: errorText,
            hintText: placeholder,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          validator: validator,
        );
      },
    );
  }
}
