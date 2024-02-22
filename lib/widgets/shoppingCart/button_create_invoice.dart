import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/constants/roles_constants.dart';
import 'package:flutter_app_erp/core/http/invoices/create_invoice.dart';
import 'package:flutter_app_erp/providers/auth_provider.dart';
import 'package:flutter_app_erp/widgets/protected_child.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:flutter_app_erp/widgets/elevated_button_future.dart';
import 'package:provider/provider.dart';

class ButtonCreateInvoice extends StatefulWidget {
  final int orderId;
  final bool disabled;
  final Function()? onSave;

  const ButtonCreateInvoice({
    super.key,
    required this.orderId,
    this.disabled = false,
    this.onSave,
  });

  @override
  State<ButtonCreateInvoice> createState() => _ButtonCreateInvoice();
}

class _ButtonCreateInvoice extends State<ButtonCreateInvoice> {
  Future? future;

  Future<void> onRequestApi({required String token}) async {
    try {
      await createInvoice(token: token, orderId: widget.orderId);

      if (widget.onSave != null) {
        widget.onSave!();
      }
    } catch (e) {
      debugPrint("${e}");
    }
  }

  onInvoice(String token) {
    setState(() {
      future = onRequestApi(token: token);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final String token = authProvider.getToken() as String;

    return ProtectedChild(
      roles: [RolesConstants.salePerson(), RolesConstants.manager()],
      child: ElevatedButtonFuture(
        future: future,
        onPressed: widget.disabled ? null : () => onInvoice(token),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.print),
            const SizedBox(width: 5),
            TypographyApp(
              text: 'Facturar',
              color: widget.disabled ? "inherit" : "white",
            ),
          ],
        ),
      ),
    );
  }
}
