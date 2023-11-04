import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/currencies/update_currencie.dart';
import 'package:flutter_app_erp/core/response/currencies/currencies_response.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_erp/widgets/form_currencies.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';

class FormCurrencieUpdate extends StatelessWidget {
  final CurrenciesResponse currencie;
  final void Function()? onAfterSave;

  const FormCurrencieUpdate({ 
    super.key, 
    this.onAfterSave, 
    required this.currencie 
  });
  
  void onSubmitRequest({
    required BuildContext context,
    required Map<String, dynamic> params,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? token = authProvider.getToken();


  


      await updateCurrencie(
      token: token,
      currencieId: currencie.id,
      name: params["name"],
      symbol: params["symbol"],
      code: params["code"],
      exchangeRate: params["exchangeRate"],
    );

    if (!context.mounted) {
      return;
    }

    onAfterSave!();
  }

   @override
  Widget build(BuildContext context) {
    return FormCurrencie(
      nameDefault: currencie.name,
      symbolDefault: currencie.symbol,
      codeDefault: currencie.code,
      exchangeRateDefault: currencie.exchangeRate,
      onRequest: (Map<String, dynamic> params) async => onSubmitRequest(
        context: context,
        params: params,
      ),
    );
  }
}