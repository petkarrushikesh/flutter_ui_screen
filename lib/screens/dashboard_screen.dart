// screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/dashboard_service.dart';
import '../models/dashboard_model.dart';
import '../widgets/stat_card.dart';
import '../widgets/chart_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<DashboardData> dashboardFuture;

  @override
  void initState() {
    super.initState();
    dashboardFuture = DashboardService.fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: FutureBuilder<DashboardData>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitFadingCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(
                    'Error loading dashboard',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        dashboardFuture = DashboardService.fetchDashboardData();
                      });
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildStatsGrid(data),
                    const SizedBox(height: 24),
                    _buildOrderChart(data),
                    const SizedBox(height: 24),
                    _buildCustomerChart(data),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'friday sales team',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: const Color(0xFF718096),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildNotificationIcon(Colors.blue, Icons.message),
              const SizedBox(width: 8),
              _buildNotificationIcon(Colors.blue, Icons.notifications),
              const SizedBox(width: 8),
              _buildNotificationIcon(Colors.orange, Icons.shopping_bag),
              const SizedBox(width: 12),
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.red,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon(Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildStatsGrid(DashboardData data) {
    final stats = [
      StatCard(
        title: 'Customers',
        value: '${data.customers}',
        icon: 'people',
        color: 'blue',
        showTrend: true,
      ),
      StatCard(
        title: 'Sales',
        value: '\$${data.sales.toInt()}',
        icon: 'trending_up',
        color: 'green',
        showTrend: true,
      ),
      StatCard(
        title: 'Orders',
        value: '${data.orders}',
        icon: 'shopping_cart',
        color: 'orange',
      ),
      StatCard(
        title: 'Page Views',
        value: '${data.pageViews}',
        icon: 'visibility',
        color: 'purple',
      ),
      StatCard(
        title: 'Products',
        value: '${data.products}',
        icon: 'inventory',
        color: 'teal',
      ),
      StatCard(
        title: 'Catalogs',
        value: '${data.catalogs}',
        icon: 'folder',
        color: 'indigo',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return StatCardWidget(stat: stats[index]);
      },
    );
  }

  Widget _buildOrderChart(DashboardData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order and Sale Stats',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 20),
          ChartWidget(
            data: data.orderStats,
            height: 120,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerChart(DashboardData data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Stats',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 20),
          ChartWidget(
            data: data.customerStats,
            height: 120,
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'
            ].map((month) => Text(
              month,
              style: GoogleFonts.roboto(
                color: const Color(0xFF718096),
                fontSize: 12,
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}