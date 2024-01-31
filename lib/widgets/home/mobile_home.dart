import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class MobileHome extends StatelessWidget{
  final List<Widget> inventarios;
  const MobileHome({
    super.key,
    required this.inventarios,
  });

  @override
  Widget build(BuildContext buildContext){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FormControl(
          child: TypographyApp(
            text: "Detalles",
            variant: "h1",
            color: "primary",
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: inventarios,
        ),
      ],
    );
  }
}