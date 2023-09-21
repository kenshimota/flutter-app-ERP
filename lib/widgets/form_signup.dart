import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_last_name.dart';
import 'package:flutter_app_erp/widgets/input_user_name.dart';

class FormSignup extends StatefulWidget {
  const FormSignup({super.key});

  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: const Column(
        children: [
          Row(
            children: [
              _GridColumn(
                child: FormControl(
                  child: InputEmail(),
                ),
              ),
              _GridColumn(
                child: FormControl(
                  child: InputName(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GridColumn extends StatelessWidget {
  final Widget child;

  const _GridColumn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [child]),
    );
  }
}
