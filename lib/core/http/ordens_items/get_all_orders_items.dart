import 'package:flutter_app_erp/core/http/ordens_items/get_list_orders_items.dart';
import 'package:flutter_app_erp/core/response/orders_items/orders_items_response.dart';

Future<List<OrdersItemsResponse>> getAllOrdersItems({
  required String token,
  required int orderId,
}) async {
  int page = 1;
  List<OrdersItemsResponse> articles = [];
  List<OrdersItemsResponse> list = [];

  while (list.length == 20 * (page - 1)) {
    list = await getListOrdersItemsResponse(
      token: token,
      page: page,
      orderId: orderId,
      metadata: true,
    );

    for (final OrdersItemsResponse item in list) {
      articles.add(item);
    }

    page += 1;
  }

  return articles;
}
