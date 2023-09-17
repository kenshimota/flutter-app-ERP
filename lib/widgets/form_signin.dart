import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';
//import 'package:google_fonts/google_fonts.dart';

class FormSignin extends StatefulWidget {
  const FormSignin({super.key});

  @override
  State<FormSignin> createState() => _FormSigninState();
}

class _FormSigninState extends State<FormSignin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Iniciar sesion');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Icon(
              Icons.person,
              color: Colors.purple,
              size: 80.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text('Iniciar Sesion: '),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: InputEmail(
              isRequired: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: InputPassword(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              child: const Text('Iniciar sesion'),
            ),
          ),
        ],
      ),
    );
  }
}
