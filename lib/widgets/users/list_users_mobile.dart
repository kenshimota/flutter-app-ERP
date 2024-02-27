import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/widgets/column_cell.dart';
import 'package:flutter_app_erp/widgets/list_tile_app.dart';
import 'package:flutter_app_erp/widgets/list_view_app.dart';
import 'package:flutter_app_erp/widgets/popup_menu_warehouse.dart';
import 'package:flutter_app_erp/widgets/slice_column.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/users/popup_menu_button_user.dart';

class ListTileUsersContent extends StatelessWidget {
  final UserResponse user; 

  const ListTileUsersContent({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 50,
      child: SliceColumn(
        children: [
          ColumnCell(subtitle: "Usuario", content: user.username),
          ColumnCell(subtitle: "Nombre", content: "${user.firstName}, ${user.lastName}"),
          ColumnCell(subtitle: "Cedula", content: "${user.identityDocument}"),
          ColumnCell(subtitle: "Tipo de usuario", content: user.roleId),
          ColumnCell(subtitle: "Fecha de creado", content: DateFormatterApp.dateTimeFormatter(user.createdAt)),
          ColumnCell(subtitle: "Fecha de actualizado", content: DateFormatterApp.dateTimeFormatter(user.updatedAt)),
        ],
      ),
    );
  }
}

class ListTileUser extends StatelessWidget {
  final UserResponse user;
  final void Function()? onAfterChange;

  const ListTileUser({
    super.key,
    required this.user,
    this.onAfterChange
  });

  @override
  Widget build(BuildContext context){
    final String name = user.username;

    return ListTileApp(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: TypographyApp(text: name, variant: "subtitle2",),
      subtitle: TypographyApp(text: "${user.firstName}, ${user.lastName}", variant: "body1",),
      trailing: PopupMenuApp(
        user: user,
        onAfterChange: onAfterChange,
      ),
      heightContent: 70,
      content: ListTileUsersContent(user: user,),
    );
  }
}

class ListTileUsers extends StatelessWidget {
  final int page;
  final Future? future; 
  final void Function()? onForward;
  final List<UserResponse> list;
  final void Function()? onAfterChange;

  const ListTileUsers({
    super.key,
    required this.list,
    this.onAfterChange,
    this.onForward,
    this.page = 1,
    this.future,
  });

  Widget buildItem(BuildContext context, UserResponse user){
    return Column(
      children: [
        ListTileUser(user: user, onAfterChange: onAfterChange,),
        const Divider(height: 1,)
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return ListViewApp(
      page: page,
      future: future,
      onNext: onForward,
      listItems: list,
      buildItems: (context, user) => buildItem(context, user),
    );
  }
}