import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/widgets/users/dialog_edit_users.dart';

enum SampleItem { itemOne }

class PopupMenuApp extends StatelessWidget {
  final void Function()? onAfterChange;
  final UserResponse user;
  const PopupMenuApp({super.key, this.onAfterChange, required this.user});

  @override
  Widget build(BuildContext context) {
    return PopupMenuUser(onAfterChange: onAfterChange, user: user);
  }
}

class PopupMenuUser extends StatefulWidget {
  final void Function()? onAfterChange;
  final UserResponse user;

  const PopupMenuUser({super.key, this.onAfterChange, required this.user});

  @override
  // ignore: no_logic_in_create_state
  State<PopupMenuUser> createState() => _PopupMenuUserState();
}

class _PopupMenuUserState extends State<PopupMenuUser> {
  SampleItem? selectedMenu;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      initialValue: selectedMenu,

      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        Widget Function(BuildContext)? builder;

        setState(() {
          selectedMenu = item;
        });

        if (item == SampleItem.itemOne) {
          builder = (context) => AlertDialogUpdateUser(
                user: widget.user,
                onSave: widget.onAfterChange,
              );
        }

        if (builder != null) {
          showDialog(context: context, builder: builder);
        }
      },

      itemBuilder: (
        BuildContext context,
      ) =>
          <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text(
            'Editar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
