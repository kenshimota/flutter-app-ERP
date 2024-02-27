import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/users/form_ update_user.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class AlertDialogUpdateUser extends StatefulWidget{
  final UserResponse user;

  final void Function()? onSave;

  const AlertDialogUpdateUser({
    super.key,
    this.onSave,
    required this.user
  });

  @override
  _AlertDialogUpdateUser createState() => _AlertDialogUpdateUser();
}

class  _AlertDialogUpdateUser extends State<AlertDialogUpdateUser> {
  void onAfterSave(context) {
    if (context.mounted == false) {
      return;
    }

    Navigator.pop(context);
    widget.onSave!();
  }

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: const TypographyApp(
          text: 'Cambiar el tipo de usuario',
          variant: "h3",
        ),
        actions: [
          FormUpdateUser( user: widget.user, onSave: () => onAfterSave(context)),
        ],
    );
  }
}