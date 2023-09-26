import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_signup_request.dart';

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
                    const FormSignupRequest(),
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
          ),
          child: const Text('Show Fullscreen Dialog'),
        ),
      ],
    );
  }
}
