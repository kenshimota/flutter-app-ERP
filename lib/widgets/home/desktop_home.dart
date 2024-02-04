import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_limit.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/typography.dart';

class DesktopHome extends StatelessWidget {
  final List<Widget> inventarios;
  const DesktopHome({
    super.key,
    required this.inventarios,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerLimit(
      maxWidth: 1200,
      minHeight: 700,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 0.7,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/img/prueba2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
               
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
                    
                    children: inventarios,
                  ),
                ],
              ),
            ],
          )),
    );
    /* Container(
          height: 100,
          width: 100,
          child: const Text("Aqui va la imagen"),
        ),*/
  }
}
