// services/dashboard_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/dashboard_model.dart';
import '../models/post_model.dart';

class DashboardService {
  // Generate dashboard data based on real API data
  static Future<DashboardData> fetchDashboardData() async {
    try {
      // Fetch posts to simulate dashboard metrics
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final posts = jsonData.map((json) => Post.fromJson(json)).toList();

        // Simulate dashboard data based on posts
        return DashboardData(
          customers: posts.length * 28, // 2800+ customers
          sales: _calculateSales(posts.length),
          orders: posts.length * 30, // More orders than posts
          pageViews: posts.length * 35,
          products: posts.length * 25,
          catalogs: posts.length * 20,
          orderStats: _generateChartData(),
          customerStats: _generateChartData(),
        );
      } else {
        throw Exception('Failed to load dashboard data');
      }
    } catch (e) {
      // Return dummy data if API fails
      return _getDummyDashboardData();
    }
  }

  // Calculate sales based on number of posts
  static double _calculateSales(int postsCount) {
    return (postsCount * 121.22).toDouble(); // Will give us ~12,122
  }

  // Generate random chart data
  static List<double> _generateChartData() {
    Random random = Random();
    return List.generate(30, (index) {
      // Generate more realistic data points
      double baseValue = 20 + random.nextDouble() * 60; // Between 20-80
      // Add some trend
      double trend = (index / 30) * 20; // Slight upward trend
      return baseValue + trend + (random.nextDouble() - 0.5) * 20;
    });
  }

  // Fallback dummy data
  static DashboardData _getDummyDashboardData() {
    return DashboardData(
      customers: 2847,
      sales: 12122.0,
      orders: 2847,
      pageViews: 2847,
      products: 2847,
      catalogs: 2847,
      orderStats: _generateChartData(),
      customerStats: _generateChartData(),
    );
  }

  // Keep your existing posts functionality
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}