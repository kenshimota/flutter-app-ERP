import 'dart:convert';
import 'package:flutter_app_erp/core/response/response_base.dart';

class DashboardResponse implements ResponseBase {
  final int totalUsers;
  final int totalProductsWithStock;
  final int totalProductsWithoutStock;
  final int totalInvoicesToday;
  final int totalInvoicesMonth;
  final int totalOrdersToday;
  final int totalProductsBoughtToday;
  final int totalProductsBoughtMonth;
  final int totalOrdersMonth;

  const DashboardResponse({
    required this.totalUsers,
    required this.totalProductsWithStock,
    required this.totalProductsWithoutStock,
    required this.totalInvoicesToday,
    required this.totalInvoicesMonth,
    required this.totalOrdersToday,
    required this.totalProductsBoughtToday,
    required this.totalProductsBoughtMonth,
    required this.totalOrdersMonth,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json){

    print(json);

    return DashboardResponse(
      totalUsers: json['total_users'], 
      totalProductsWithStock: json['total_products_with_stock'], 
      totalProductsWithoutStock: json['total_products_without_stock'], 
      totalInvoicesToday: json['total_invoices_today'], 
      totalInvoicesMonth: json['total_invoices_month'], 
      totalOrdersToday: json['total_orders_today'], 
      totalProductsBoughtToday: json['total_products_bought_today'], 
      totalProductsBoughtMonth: json['total_products_bought_month'], 
      totalOrdersMonth: json['total_orders_month']
    );
  }

  @override
  String toString(){
    final Map<String, dynamic> map = {
      "totalUsers": totalUsers,
      "totalProductsWithStock": totalProductsWithStock,
      "totalProductsWithoutStock": totalProductsWithoutStock,
      "totalInvoicesToday": totalInvoicesToday,
      "totalInvoicesMonth":  totalInvoicesMonth,
      "totalOrdersToday": totalOrdersToday,
      "totalProductsBoughtToday": totalProductsBoughtToday,
      "totalProductsBoughtMonth": totalProductsBoughtMonth,
      "totalOrdersMonth":  totalOrdersMonth,
    };

    return jsonEncode(map);
  }

}