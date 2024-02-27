import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/users/dialog_edit_users.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';

class ButtonEditUserRole extends StatelessWidget{
  final void Function()? onSave; 
  final UserResponse user; 
  const ButtonEditUserRole({
    super.key,
    this.onSave,
    required this.user,
  });

  onEditUserRole(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogUpdateUser (
        user: user,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return IconButton(
      onPressed: () => onEditUserRole(context), 
      icon: const Icon(Icons.edit),
    );
  }
}

class TextButtonEditUserRole extends StatelessWidget {
  final void Function()? onSave;
  final UserResponse user;
  final Color? color;

  const TextButtonEditUserRole({
    super.key,
    this.onSave,
    this.color,
    required this.user,
  });

  onEditUserRole(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogUpdateUser (
        user: user,
        onSave: onSave,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style =
        color == null ? null : TextButton.styleFrom(foregroundColor: color);

    return TextButton(
      style: style,
      onPressed: () => onEditUserRole(context),
      child: const Text('Cambiar permiso'),
    );
  }
}