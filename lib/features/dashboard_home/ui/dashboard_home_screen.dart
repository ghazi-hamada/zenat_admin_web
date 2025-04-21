import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/functions/extensions.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/dashboard_home/data/loadMockUsers.dart';
import 'package:zenat_admin_web/features/dashboard_home/data/user_model.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  OverlayEntry? _overlayEntry;
  final List<String> pageTitles = [
    'نظرة عامة',
    'المستخدمين',
    'طلبات التوافق',
    'الإعجابات',
    'المحظورين',
    'الإعدادات',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            color: const Color(0xFFF5F5F5),
            child: Column(
              children: [
                Expanded(
                  child: NavigationRail(
                    backgroundColor: const Color(0xFFF5F5F5),
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (int index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    selectedIconTheme: const IconThemeData(
                      color: Color(0xFFFB962B),
                    ),
                    selectedLabelTextStyle: const TextStyle(
                      color: Color(0xFFFB962B),
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard),
                        label: Text('نظرة عامة'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.people),
                        label: Text('المستخدمين'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('طلبات التوافق'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.thumb_up),
                        label: Text('الإعجابات'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.block),
                        label: Text('المحظورين'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('الإعدادات'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                //log out button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(Icons.logout, color: Colors.red),
                    onPressed: () async {
                      // Perform logout logic here
                      await SharedPrefHelper.clearAllData();
                      context.pushReplacementNamed(Routes.loginScreen);
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _buildPage(selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _overviewPage();
      case 1:
        return _usersPage();
      case 2:
        return _requestsPage();
      case 3:
        return _likesPage();
      case 4:
        return _blockedPage();
      case 5:
        return _settingsPage();
      default:
        return const Center(child: Text('صفحة غير موجودة'));
    }
  }

  Widget _overviewPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'نظرة عامة',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: const [
            _StatCard(
              title: 'عدد المستخدمين',
              value: '1245',
              icon: Icons.people,
            ),
            _StatCard(
              title: 'طلبات التوافق',
              value: '310',
              icon: Icons.favorite,
            ),
            _StatCard(
              title: 'الإعجابات المرسلة',
              value: '890',
              icon: Icons.thumb_up,
            ),
            _StatCard(title: 'عدد المحظورين', value: '45', icon: Icons.block),
          ],
        ),
      ],
    );
  }

  Widget _usersPage() {
    return FutureBuilder<List<User>>(
      future: loadMockUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('حدث خطأ أثناء تحميل المستخدمين'));
        } else {
          final users = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('الاسم')),
                DataColumn(label: Text('العمر')),
                DataColumn(label: Text('المنطقة')),
                DataColumn(label: Text('التعليم')),
                DataColumn(label: Text('الطول')),
                DataColumn(label: Text('الحالة')),
              ],
              rows:
                  users.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Text(user.name)),
                        DataCell(Text('${user.age}')),
                        DataCell(Text(user.region)),
                        DataCell(Text(user.education)),
                        DataCell(Text('${user.height}')),
                        DataCell(Text(user.status)),
                      ],
                    );
                  }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget _requestsPage() {
    return const Center(child: Text('طلبات التوافق'));
  }

  Widget _likesPage() {
    return const Center(child: Text('الإعجابات'));
  }

  Widget _blockedPage() {
    return const Center(child: Text('المستخدمين المحظورين'));
  }

  Widget _settingsPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('الإعدادات العامة'),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () async {
              final shouldLogout = await _showLogoutConfirmationDialog();
              if (shouldLogout) {
                // Perform logout logic here
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('تسجيل الخروج'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFB962B),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('تأكيد تسجيل الخروج'),
                content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('إلغاء'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('تأكيد'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: Color(0xFFFB962B)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
