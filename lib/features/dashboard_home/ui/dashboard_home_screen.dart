import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/extensions.dart';
import 'package:zenat_admin_web/core/helper/shared_pref_helper.dart';
import 'package:zenat_admin_web/core/routing/routes.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/features/chats/logic/chats/chats_cubit.dart';
import 'package:zenat_admin_web/features/chats/ui/chats_screen.dart';
import 'package:zenat_admin_web/features/complaint/ui/complaint_screen.dart';
import 'package:zenat_admin_web/features/dashboard_home/data/loadMockUsers.dart';
import 'package:zenat_admin_web/features/dashboard_home/data/user_model.dart';
import 'package:zenat_admin_web/features/overview/ui/overview_screen.dart';
import 'package:zenat_admin_web/features/settings/logic/settings_cubit.dart'
    show SettingsCubit;
import 'package:zenat_admin_web/features/settings/ui/settings_screen.dart';
import 'package:zenat_admin_web/features/stories/logic/stories_cubit.dart';
import 'package:zenat_admin_web/features/stories/ui/stories_screen.dart'
    show StoriesScreen;
import 'package:zenat_admin_web/features/subscriptions/ui/subscriptions_screen.dart';
import 'package:zenat_admin_web/features/users/ui/users_screen.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  OverlayEntry? _overlayEntry;

  @override
  Widget build(BuildContext context) {
    // final List<String> pageTitles = [
    //   S.of(context).overviewTitle,
    //   S.of(context).usersTitle,
    //   S.of(context).compatibilityRequests,
    //   S.of(context).likes,
    //   S.of(context).blockedUsers,
    //   S.of(context).settings,
    // ];
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
                    destinations: [
                      NavigationRailDestination(
                        icon: const Icon(Icons.dashboard),
                        label: Text(S.of(context).overviewTitle),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.people),
                        label: Text(S.of(context).usersTitle),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.chat),
                        label: Text(S.of(context).chatsTitle),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.subscriptions),
                        label: Text(S.of(context).subscriptionsTitle),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.report),
                        label: Text(S.of(context).complaintsTitle),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.book),
                        label: Text(S.of(context).storiesTitle),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.settings),
                        label: Text(S.of(context).settings),
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
        return OverviewScreen();
      case 1:
        return UsersScreen();
      case 2:
        return BlocProvider(
          create: (context) => ChatsCubit(),
          child: ChatsScreen(),
        );
      case 3:
        return SubscriptionsScreen();
      case 4:
        return ComplaintScreen();
      case 5:
        return BlocProvider(
          create: (context) => StoriesCubit(),
          child: StoriesScreen(),
        );
      case 6:
        return BlocProvider(
          create: (context) => SettingsCubit()..init(),
          child: SettingsScreen(currentUserRole: 1),
        );

      default:
        return Center(child: Text(S.of(context).pageNotFound));
    }
  }

  Future<bool> _showLogoutConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(S.of(context).logoutConfirmationTitle),
                content: Text(S.of(context).logoutConfirmationMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(S.of(context).cancel),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(S.of(context).confirm),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
