// screens/main_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_screen.dart';
import 'posts_screen.dart';
import 'photos_screen.dart';
import 'users_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  // List of all screens
  final List<Widget> screens = [
    const DashboardScreen(),    // Dashboard with charts
    const PostsScreen(),        // Your posts API
    const PhotosScreen(),       // Your photos API
    const UsersScreen(),        // Your users API
    const Center(child: Text('Analytics Coming Soon')),
    const Center(child: Text('Reports Coming Soon')),
  ];

  // Screen titles
  final List<String> screenTitles = [
    'Dashboard',
    'Catalogue',
    'Orders',
    'Customers',
    'Analytics',
    'Reports',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectedIndex == 0 ? null : AppBar(
        title: Text(
          screenTitles[selectedIndex],
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.dashboard, 'Dashboard', 0),
          _buildNavItem(Icons.article, 'Catalogs', 1),
          _buildNavItem(Icons.photo, 'Orders', 2),
          _buildNavItem(Icons.people, 'Customers', 3),
          _buildNavItem(Icons.analytics, 'Analytics', 4),
          _buildNavItem(Icons.receipt, 'Reports', 5),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isActive ? Colors.blue : const Color(0xFF718096),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: 10,
                color: isActive ? Colors.blue : const Color(0xFF718096),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}