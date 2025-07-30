// models/dashboard_model.dart
class DashboardData {
  final int customers;
  final double sales;
  final int orders;
  final int pageViews;
  final int products;
  final int catalogs;
  final List<double> orderStats;
  final List<double> customerStats;

  DashboardData({
    required this.customers,
    required this.sales,
    required this.orders,
    required this.pageViews,
    required this.products,
    required this.catalogs,
    required this.orderStats,
    required this.customerStats,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      customers: json['customers'] ?? 0,
      sales: (json['sales'] ?? 0).toDouble(),
      orders: json['orders'] ?? 0,
      pageViews: json['pageViews'] ?? 0,
      products: json['products'] ?? 0,
      catalogs: json['catalogs'] ?? 0,
      orderStats: List<double>.from(json['orderStats'] ?? []),
      customerStats: List<double>.from(json['customerStats'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customers': customers,
      'sales': sales,
      'orders': orders,
      'pageViews': pageViews,
      'products': products,
      'catalogs': catalogs,
      'orderStats': orderStats,
      'customerStats': customerStats,
    };
  }
}

class StatCard {
  final String title;
  final String value;
  final String icon;
  final String color;
  final bool showTrend;

  StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.showTrend = false,
  });
}