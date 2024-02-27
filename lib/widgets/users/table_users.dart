import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/core/formatters/date_formatter_app.dart';
import 'package:flutter_app_erp/widgets/data_table_paginated.dart';
import 'package:flutter_app_erp/core/response/users/user_response.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/users/button_edit_users.dart';

class TableUsers extends StatefulWidget {
  final int numberPage;
  final Future? future;
  final void Function()? onBack;
  final List<UserResponse> list;
  final void Function()? onForwad;
  final void Function()? onAfterDelete;

  const TableUsers({
    super.key,
    required this.list,
    this.onAfterDelete,
    this.onBack,
    this.onForwad,
    this.future,
    this.numberPage = 1,
  });

  @override
  State<TableUsers> createState() => _TableUsers();
}

class _TableUsers extends State<TableUsers> {
  @override
  Widget build(BuildContext context) {
    final List<DataRow> rows = widget.list
        .map((user) => DataRow(cells: <DataCell>[
              DataCell(
                TypographyApp(
                  text: user.username,
                  variant: "body1",
                ),
              ),
              DataCell(
                TypographyApp(
                  text: user.firstName,
                  variant: "body1",
                ),
              ),
              DataCell(
                TypographyApp(
                  text: user.lastName,
                  variant: "body1",
                ),
              ),
              DataCell(
                TypographyApp(
                  text: user.identityDocument.toString(),
                  variant: "body1",
                ),
              ),
              DataCell(
                TypographyApp(
                  text: roleSpanish[user.roleId],
                  variant: "body1",
                ),
              ),
              DataCell(TypographyApp(
                text: DateFormatterApp.dateTimeFormatter(user.createdAt),
                variant: "body1",
              )),
              DataCell(TypographyApp(
                text: DateFormatterApp.dateTimeFormatter(user.updatedAt),
                variant: "body1",
              )),
              DataCell(
                Row(
                  children: [
                    ButtonEditUserRole(
                      user: user,
                      onSave: widget.onAfterDelete,
                    ),
                ],
              )
              ),
            ]))
        .toList();

    return DataTablePaginated(
        future: widget.future,
        onBack: widget.onBack,
        onForwad: widget.onForwad,
        numberPage: widget.numberPage,
        columnSpacing: 16, // Espacio entre columnas
        horizontalMargin: 16,
        columns: [
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Nombre de Usuario',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Nombre',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Apellido',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Cedula',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Tipo de usuario',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Fecha de creado',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Fecha de actualizado',
                variant: "subtitle2",
              ),
            ),
          ),
          DataColumn(
            label: const Expanded(
              child: TypographyApp(
                text: 'Acciones',
                variant: "subtitle2",
              ),
            ),
          ),
        ],
        rows: rows);
  }
}
