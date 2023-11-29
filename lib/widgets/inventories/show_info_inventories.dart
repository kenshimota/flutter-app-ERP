import 'package:flutter/material.dart';
import 'package:flutter_app_erp/core/http/inventories/get_list_inventories.dart';
import 'package:flutter_app_erp/core/response/inventories/inventories_response.dart';
import 'package:flutter_app_erp/widgets/container_white.dart';

import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/inventories/button_new_inventory.dart';
import 'package:flutter_app_erp/widgets/inventories/listitem_inventories.dart';
import 'package:flutter_app_erp/widgets/inventories/table_inventories.dart';
import 'package:flutter_app_erp/widgets/inventories/toolbar_inventories.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/widgets/products/toolbar_products.dart';

class ShowInfoInventories extends StatefulWidget {
  final String token;

  const ShowInfoInventories({
    super.key,
    required this.token,
  });

  @override
  State<ShowInfoInventories> createState() => _ShowInfoInventoriesState();
}

class _ShowInfoInventoriesState extends State<ShowInfoInventories> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order;
  List<InventoryResponse> result = <InventoryResponse>[];

  @override
  initState() {
    super.initState();
    setState(() {
      futureList = onRequestApi();
    });
  }

  Future<void> onRequestApi() async {
    List<InventoryResponse> inventories = await getListInventories(
      order: order,
      search: search,
      page: numberPage,
      token: widget.token,
    );

    setState(() {
      result = inventories;
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
          ToobalInventories(
            onOrden: onSortOrder,
            inputSearch: InputSearch(
              onSearch: onSearch,
            ),
          ),
          Expanded(
            child: ContainerWhite(
              child: LayourtTwiceBuilder(
                mobile: ListTileInventories(
                  future: futureList,
                  inventories: result,
                  page: numberPage,
                  onAfterChange: onRequestApi,
                  onForward: onForwad,
                ),
                desktop: DataTableInventories(
                  future: futureList,
                  list: result,
                  onOrden: onSortOrder,
                  onBack: onBack,
                  onForwad: onForwad,
                  numberPage: numberPage,
                  onAfterDelete: onRequest,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonNewInventory(
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
