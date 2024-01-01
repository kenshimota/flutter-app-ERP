import 'package:flutter/material.dart';
import 'package:flutter_app_erp/widgets/container_white.dart';
import 'package:flutter_app_erp/widgets/input_search.dart';
import 'package:flutter_app_erp/widgets/orders/button_new_order.dart';
import 'package:flutter_app_erp/widgets/orders/list_tile_orders_mobile.dart';
import 'package:flutter_app_erp/widgets/orders/table_orders.dart';
import 'package:flutter_app_erp/widgets/layourt_twice_builder.dart';
import 'package:flutter_app_erp/core/http/orders/get_list_orders.dart';
import 'package:flutter_app_erp/core/response/orders/orders_response.dart';
import 'package:flutter_app_erp/widgets/orders/toobal_orders.dart';

class ShowTableOrders extends StatefulWidget {
  final String token;

  const ShowTableOrders({
    super.key,
    required this.token,
  });

  @override
  State<ShowTableOrders> createState() => _ShowTableOrders();
}

class _ShowTableOrders extends State<ShowTableOrders> {
  String search = '';
  int numberPage = 1;
  Future? futureList;
  Map<String, String>? order = {"field": "number", "type": "desc"};
  List<OrdersResponse> result = <OrdersResponse>[];

  @override
  void initState() {
    setState(() {
      futureList = onResquestApi();
    });

    super.initState();
  }

  Future<void> onResquestApi() async {
    final List<OrdersResponse> orders = await getListOrders(
      token: widget.token,
      order: order,
      search: search,
      page: numberPage,
    );

    setState(() {
      result = orders;
    });
  }

  Future<void> onRequest() async {
    setState(() {
      futureList = onResquestApi();
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
  Widget build(BuildContext build) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ToobalOrders(
            onOrden: onSortOrder,
              inputSearch: InputSearch(
            onSearch: onSearch,
          )),
          Expanded(
            child: ContainerWhite(
                child: LayourtTwiceBuilder(
              mobile: ListTileOrders(
                page: numberPage,
                future: futureList,
                onForward: onForwad,
                orders: result,
                onAfterChange: onRequest,
              ),
              desktop: DataTableOrders(
                list: result,
                future: futureList,
                onOrden: onSortOrder,
                onForwad: onForwad,
                numberPage: numberPage,
                onAfterDelete: onRequest,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                ButtonNewOrder(
                  token: widget.token,
                  onSave: onResquestApi,
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}
