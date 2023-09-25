import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
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
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class FormSignup extends StatefulWidget {
  final FormErrors? errors;
  final Future<UserResponse?>? future;
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

  Widget buildInputName() {
    if (widget.future == null) {
      return InputName(
        label: "Nombre",
        controller: _firstName,
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return InputName(
          label: "Nombre",
          enabled: !loading,
          errorText: widget.errors?.getValue("first_name"),
          controller: _firstName,
        );
      },
    );
  }

  Widget buildInputLastName() {
    if (widget.future == null) {
      return InputName(
        label: "Apellido",
        controller: _lastName,
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return InputName(
          label: "Apellido",
          enabled: !loading,
          errorText: widget.errors?.getValue("last_name"),
          controller: _lastName,
        );
      },
    );
  }

  Widget buildInputEmail() {
    if (widget.future == null) {
      return InputEmail(
        controller: _email,
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return InputEmail(
          enabled: !loading,
          controller: _email,
          errorText: widget.errors?.getValue("email"),
        );
      },
    );
  }

  Widget buildInputPassword() {
    if (widget.future == null) {
      return InputPassword(
        controller: _password,
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return InputPassword(
          enabled: !loading,
          controller: _password,
          errorText: widget.errors?.getValue("password"),
        );
      },
    );
  }

  Widget buildInputUsername() {
    if (widget.future == null) {
      return InputUserName(
        controller: _identityDocument,
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return InputUserName(
          enabled: !loading,
          controller: _username,
          errorText: widget.errors?.getValue("username"),
        );
      },
    );
  }

  Widget buildInputDocument() {
    if (widget.future == null) {
      return InputIdentityDocumenten(
        controller: _identityDocument,
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return InputIdentityDocumenten(
          enabled: !loading,
          controller: _identityDocument,
          errorText: widget.errors?.getValue("identity_document"),
        );
      },
    );
  }

  Widget buildButton() {
    if (widget.future == null) {
      return ElevatedButtonShadow(
        child: ElevatedButton(
          onPressed: onSubmit,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          child: const Text('Registrar'),
        ),
      );
    }

    return FutureBuilder<UserResponse?>(
      future: widget.future,
      builder: (ctx, snapshot) {
        final bool loading =
            snapshot.connectionState == ConnectionState.waiting;

        return ElevatedButtonShadow(
          child: ElevatedButton(
            onPressed: !loading ? onSubmit : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50), // NEW
            ),
            child: const Text('Registrar'),
          ),
        );
      },
    );
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
                    child: buildInputName(),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: buildInputLastName(),
                  ),
                ),
              ],
            ),
            _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: buildInputEmail(),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: buildInputDocument(),
                  ),
                ),
              ],
            ),
            _GridItemRowToColumn(
              children: [
                _GridColumn(
                  child: FormControl(
                    child: buildInputUsername(),
                  ),
                ),
                _GridColumn(
                  child: FormControl(
                    child: buildInputPassword(),
                  ),
                ),
              ],
            ),
            FormControl(
              child: buildButton(),
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
