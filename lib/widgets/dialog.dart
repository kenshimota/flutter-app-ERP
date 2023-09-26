import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_signin.dart';
import 'package:flutter_app_erp/widgets/form_signup.dart';

class DialogApp extends StatelessWidget {
  const DialogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: DialogDesign(),
    );
  }
}

class DialogDesign extends StatelessWidget {
  final Widget? child;
  final bool fullscreenDialog;
  const DialogDesign({super.key, this.child, this.fullscreenDialog = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const FormSignup(),
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
            /* return Dialog(
                // Establecer en true para mostrar en pantalla completa
                child: Container(
                  child: Text('Hola jessica, lo lograste.'),
                ),
              );*/
          ),
          child: const Text('Show Fullscreen Dialog'),
        ),
      ],
    );
  }
}
