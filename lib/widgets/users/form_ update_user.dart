import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/core/exception/auth_errors.dart';
import 'package:flutter_app_erp/core/exception/form_errors.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/core/http/users/update_role.dart';
import 'package:provider/provider.dart';

class FormUpdateUser extends StatefulWidget {
  final void Function()? onSave;
  final UserResponse user;

  const FormUpdateUser({super.key, required this.user, this.onSave});

  @override
  State<FormUpdateUser> createState() => _FormUpdateUser();
}

class _FormUpdateUser extends State<FormUpdateUser> {
  Future? future;
  String roleName = "";
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FormErrors errors = FormErrors(map: {});

  @override
  initState() {
    setState(() {
      roleName = widget.user.roleId;
    });
  }


  onRequest() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();
    try {
      await updateRole(
        token: token as String,
        roleName: roleName,
        id: widget.user.id,
      );

      widget.onSave!();
    } on AuthErrors {
      authProvider.signOut();
    } on FormErrors catch (e) {

      debugPrint("$e");

      setState(() {
        errors = e;
      });
    }
  }

  onSubmit() {
    if (!_formkey.currentState!.validate()) {
      return null;
    }

    setState(() {
      future = onRequest();
    });
  }

  onChangeRole(String newRole) {
    setState(() {
      roleName = newRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                FormControl(
                  child: DropdownButtonUserRole(onChange: onChangeRole),
                ),
                FormControl(
                    child: ElevatedButtonFuture(
                  future: future,
                  onPressed: () => onSubmit(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Cambiar permiso'),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<String> list = [
  RolesConstants.customer(),
  RolesConstants.invetoryPerson(),
  RolesConstants.manager(),
  RolesConstants.salePerson()
];

Map<String, String> labels =  roleSpanish;

class DropdownButtonUserRole extends StatefulWidget {
  final Function(String)? onChange;

  const DropdownButtonUserRole({
    super.key,
    this.onChange,
  });

  @override
  State<DropdownButtonUserRole> createState() => _DropdownButtonUserRoleState();
}

class _DropdownButtonUserRoleState extends State<DropdownButtonUserRole> {
  String dropdownValue = list.first;

  onChange(String? value) {
    
    setState(() {
      dropdownValue = value!;
    });

    widget.onChange!(value ?? "");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint( jsonEncode(labels) );

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onChange,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text( labels[value] ?? ""),
        );
      }).toList(),
    );
  }
}
