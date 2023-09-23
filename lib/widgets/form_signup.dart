import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_erp/widgets/elevate_button_shadow.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app_erp/widgets/input_email.dart';
import 'package:flutter_app_erp/widgets/input_identity.dart';
import 'package:flutter_app_erp/widgets/input_name.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/input_last_name.dart';
import 'package:flutter_app_erp/widgets/input_password.dart';
import 'package:flutter_app_erp/widgets/input_user_name.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class FormSignup extends StatefulWidget {
  const FormSignup({super.key});

  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (_formKey.currentState!.validate()) {
      return null;
    }
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
            const _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: InputName(),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: InputLasName(),
                  ),
                ),
              ],
            ),
            const _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: InputEmail(),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: InputIdentityDocumenten(),
                  ),
                ),
              ],
            ),
            const _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: InputUserName(),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: InputPassword(),
                  ),
                ),
              ],
            ),
            FormControl(
              child: ElevatedButtonShadow(
                child: ElevatedButton(
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

    return RichText(
      text: TextSpan(
        text: '¿Ya tienes una cuenta? ',
        style: const TextStyle(color: Colors.black, fontSize: 18),
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
      log: "_G",
      mobile: Column(children: [child]),
      desktop: child,
    );
  }
}
