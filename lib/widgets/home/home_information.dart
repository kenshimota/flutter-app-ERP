import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/formatters/number_formatter_app.dart';
import 'package:flutter_app_erp/core/http/dashboard/get_list_dashboard.dart';
import 'package:flutter_app_erp/core/response/dashboard/dashboard_response.dart';
import 'package:flutter_app_erp/widgets/container_white.dart';
import 'package:flutter_app_erp/widgets/form_control.dart';
import 'package:flutter_app_erp/widgets/home/bloques.dart';
import 'package:flutter_app_erp/widgets/home/desktop_home.dart';
import 'package:flutter_app_erp/widgets/home/mobile_home.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/typography.dart';
import 'package:intl/intl.dart';

class ShowHomeInformation extends StatefulWidget {
  final String token;
  const ShowHomeInformation({
    super.key,
    required this.token,
  });

  @override
  State<ShowHomeInformation> createState() => _ShowHomeInformation();
}

class _ShowHomeInformation extends State<ShowHomeInformation> {
  DashboardResponse? dashboard;
  Future? futureObjet;

  @override
  initState() {
    super.initState();
    setState(() {
      futureObjet = onRequestApi();
    });
  }

  Future<void> onRequestApi() async {
    final DashboardResponse dashboardSummary = await getDashboardSummary(
      token: widget.token,
    );

    setState(() {
      dashboard = dashboardSummary;
    });
  }

  List<Widget> buildList() {
    if (dashboard == null) {
      return [];
    }

    return [
      Column(
        children: [
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.supervised_user_circle_sharp,
                size: 40,
                color: Colors.white,
              ),
              title: "Total de usuarios",
              amount: dashboard!.totalUsers,
            ),
          ),
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.warning,
                size: 40,
                color: Colors.white,
              ),
              title: "Productos Sin\n Existencia",
              amount: dashboard!.totalProductsWithoutStock,
            ),
          ),
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
              title: "Productos en\n Existencia",
              amount: dashboard!.totalProductsWithStock,
            ),
          ),
        ],
      ),
      Column(
        children: [
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.monetization_on,
                size: 40,
                color: Colors.white,
              ),
              title: "Total de factura\n de hoy",
              amount: dashboard!.totalInvoicesToday,
            ),
          ),
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.monetization_on,
                size: 40,
                color: Colors.white,
              ),
              title: "Total de factura \n del mes",
              amount: dashboard!.totalInvoicesMonth,
            ),
          ),
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.shopping_cart,
                size: 40,
                color: Colors.white,
              ),
              title: "Total de pedidos hoy",
              amount: dashboard!.totalOrdersToday,
            ),
          ),
        ],
      ),
      Column(
        children: [
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.white,
              ),
              title: "Productos comprados\nhoy",
              amount: dashboard!.totalProductsBoughtToday,
            ),
          ),
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.white,
              ),
              title: "Productos comprados\nen el mes",
              amount: dashboard!.totalProductsBoughtMonth,
            ),
          ),
          FormControl(
            child: Bloques(
              width: 180,
              height: 150,
              icon: const Icon(
                Icons.shopping_cart,
                size: 40,
                color: Colors.white,
              ),
              title: "Total de pedidos \nen el mes",
              amount: dashboard!.totalOrdersMonth,
            ),
          ),
        ],
      )

      /*FormControl(
                      child: Bloques(),
                    ),
                    FormControl(
                      child: Bloques(),
                    ),
                    FormControl(
                      child: Bloques(),
                    ),*/
    ];
  }

  List<Widget> buildListMobile() {
    if (dashboard == null) {
      return [];
    }

    return [
      Column(
        children: [
          Row(
            children: [
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.supervised_user_circle_sharp,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de usuarios",
                  amount: dashboard!.totalUsers,
                ),
              ),
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.warning,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Productos Sin\n Existencia",
                  amount: dashboard!.totalProductsWithoutStock,
                ),
              ),
            ],
          ),
          Row(
            children: [
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Productos en\n Existencia",
                  amount: dashboard!.totalProductsWithStock,
                ),
              ),
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.monetization_on,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de factura\n de hoy",
                  amount: dashboard!.totalInvoicesToday,
                ),
              ),
            ],
          ),
          Row(
            children: [
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.monetization_on,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de factura \n del mes",
                  amount: dashboard!.totalInvoicesMonth,
                ),
              ),
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de \npedidos hoy",
                  amount: dashboard!.totalOrdersToday,
                ),
              ),
            ],
          ),
          Row(
            children: [
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.shopping_bag,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de productos \n comprados hoy",
                  amount: dashboard!.totalProductsBoughtToday,
                ),
              ),
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.shopping_bag,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de productos \n comprados en el mes",
                  amount: dashboard!.totalProductsBoughtMonth,
                ),
              ),
            ],
          ),
          Row(
            children: [
              FormControl(
                child: Bloques(
                  width: 130,
                  height: 150,
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: "Total de pedidos \nen el mes",
                  amount: dashboard!.totalOrdersMonth,
                ),
              ),
            ],
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: LayourtTwiceBuilder(
            mobile: MobileHome(
              inventarios: buildListMobile(),
            ),
            desktop: DesktopHome(
              inventarios: buildList(),
            ),
          ),
        ),
      ]),
    );
  }
}
