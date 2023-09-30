import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/taxes/get_list_taxes.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/table_taxes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/core/response/taxes/taxes_response.dart';

class ShowInfoTaxes extends StatefulWidget {
  const ShowInfoTaxes({super.key});
  @override
  State<ShowInfoTaxes> createState() => _ShowInfotaxesState();
}

class _ShowInfotaxesState extends State<ShowInfoTaxes> {
  List<TaxesResponse> result = <TaxesResponse>[];

  Future<void> onRequest(String token) async {
    List<TaxesResponse> taxes = await getListTaxes(token: token);

    setState(() {
      result = taxes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String? token = authProvider.getToken();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            child: DataTableTaxes(list: result),
          ),
        ),
        const Row(
          children: [Text('Hola 1'), Text('Hola 2'), Text('Hola 3')],
        ),
        ElevatedButton(
          onPressed: () => token == null ? null : onRequest(token),
          child: const Text('hacer Click'),
        ),
      ],
    );
  }
}
