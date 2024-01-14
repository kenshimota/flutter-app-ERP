import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/elevate_button_shadow.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/input_identity.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';
import 'package:flutter_app_erp/widgets/input_user_name.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class FormSignup extends StatefulWidget {
  final Future? future;
  final FormErrors? errors;
  final void Function(Map<String, dynamic>) onSubmit;

  const FormSignup({
    super.key,
    this.future,
    required this.onSubmit,
    this.errors,
  });

  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _identityDocument = TextEditingController();

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return null;
    }

    widget.onSubmit({
      "username": _username.text,
      "password": _password.text,
      "last_name": _lastName.text,
      "first_name": _firstName.text,
      "email": _email.text,
      "identity_document": _identityDocument.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormPadding(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const FormControl(
              child: _Title(),
            ),
            const FormControl(child: _TextAboutToGoToSignin()),
            _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: InputName(
                      isRequired: true,
                      label: "Nombre",
                      future: widget.future,
                      controller: _firstName,
                      errorText: widget.errors?.getValue("first_name"),
                    ),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: InputName(
                      isRequired: true,
                      label: "Apellido",
                      future: widget.future,
                      controller: _lastName,
                      errorText: widget.errors?.getValue("last_name"),
                    ),
                  ),
                ),
              ],
            ),
            _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: InputEmail(
                      isRequired: true,
                      controller: _email,
                      future: widget.future,
                      errorText: widget.errors?.getValue("email"),
                    ),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: InputIdentityDocument(
                      future: widget.future,
                      controller: _identityDocument,
                      errorText: widget.errors?.getValue("identity_document"),
                    ),
                  ),
                ),
              ],
            ),
            _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: InputUserName(
                      future: widget.future,
                      controller: _username,
                      errorText: widget.errors?.getValue("username"),
                    ),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: InputPassword(
                      future: widget.future,
                      controller: _password,
                      errorText: widget.errors?.getValue("password"),
                    ),
                  ),
                ),
              ],
            ),
            FormControl(
              child: ElevatedButtonShadow(
                child: ElevatedButtonFuture(
                  future: widget.future,
                  onPressed: onSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // NEW
                  ),
                  child: const Text('Registrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridItemRowToColumn extends StatelessWidget {
  final List<Widget> children;

  const _GridItemRowToColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return LayourtTwiceBuilder(
      mobile: Row(
        children: [
          Expanded(
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
      desktop: Row(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: children.map((child) {
                  return Expanded(child: child);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final Color? color;
  const _Title({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(children: [
        Icon(
          Icons.note_add,
          size: 50.0,
        ),
        TypographyApp(
          text: 'Registrarse',
          variant: "h1",
        ),
      ]),
    );
  }
}

class _TextAboutToGoToSignin extends StatelessWidget {
  const _TextAboutToGoToSignin({super.key});

  onPressed(BuildContext context) {
    context.go("/signin");
  }

  @override
  Widget build(BuildContext context) {
    Color? color = Theme.of(context).colorScheme.surface;
    final Brightness currentBrightness = Theme.of(context).brightness;

    return RichText(
      text: TextSpan(
        text: '¿Ya tienes una cuenta? ',
        style: TextStyle(
            color: currentBrightness == Brightness.dark
                ? const Color(0xf9f9f9f9)
                : Colors.black,
            fontSize: 18),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => onPressed(context),
            text: 'Inicia Sesión',
            style: TextStyle(
              color: color,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class FormPadding extends StatelessWidget {
  final Widget? child;
  const FormPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}

class _GridColumn extends StatelessWidget {
  final Widget child;

  const _GridColumn({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayourtTwiceBuilder(
      mobile: Column(children: [child]),
      desktop: child,
    );
  }
}
