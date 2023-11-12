import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/warehouse/get_list_warehouse.dart';
import 'package:flutter_app_erp/core/response/warehouse/warehouse_response.dart';
import 'package:flutter_app_erp/widgets/button_new_warehouse.dart';
import 'package:flutter_app_erp/widgets/list_warehouse_mobile.dart';
import 'package:flutter_app_erp/widgets/table_warehouse.dart';
import 'package:flutter_app_erp/widgets/toobal_warehouse.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';

class ShowTableWarehouse extends StatefulWidget {
  final String token;
  const ShowTableWarehouse({super.key, required this.token});

  @override
  State<ShowTableWarehouse> createState() => _ShowTableWarehouse();
}

class _ShowTableWarehouse extends State<ShowTableWarehouse> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order;
  List<WarehouseResponse> result = <WarehouseResponse>[];

  @override
  void initState() {
    setState(() {
      futureList = onRequestApi();
    });

    super.initState();
  }

  Future<void> onRequestApi() async {
    final List<WarehouseResponse> warehouses = await getListWarehouse(
      token: widget.token,
      order: order,
      search: search,
      page: numberPage,
    );

    debugPrint('$warehouses');

    setState(() {
      result = warehouses;
    });
  }

  Future<void> onRequest() async {
    setState(() {
      futureList = onRequestApi();
    });
  }

  onSortOrder(Map<String, String> o) {
    setState(() {
      order = o;
      numberPage = 1;
    });

    onRequest();
  }

  onSearch(String s) {
    setState(() {
      search = s;
      numberPage = 1;
    });

    onRequest();
  }

  onBack() {
    setState(() {
      numberPage -= 1;
    });

    onRequest();
  }

  void onForwad() {
    setState(() {
      numberPage += 1;
    });

    onRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToobalWarehouses(
              onOrden: onSortOrder,
              inputSearch: InputSearch(
                onSearch: onSearch,
              ),
          ),
          Expanded(
            child: Container(
                color: Colors.white,
                child: LayourtTwiceBuilder(
                  mobile: ListTileWarehouse(
                    listWare: result,
                    onAfterChange: onRequest,
                  ),
                  desktop: DataTableWarehouse(
                    list: result,
                    future: futureList,
                    onOrden: onSortOrder,
                    onBack: onBack,
                    onForwad: onForwad,
                    numberPage: numberPage,
                    onAfterDelete: onRequest,
                  ),
                ) /*  */
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonNewWarehouse(
                  onSave: () => onRequest(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
