import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/settings/logic/settings_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/members_page.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/personal_info_page.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/password_change_page.dart';

// نموذج لبيانات العضو

class SettingsScreen extends StatefulWidget {
  final int currentUserRole; // 0 = مستخدم عادي, 1 = أدمين, 2 = قراءة فقط

  const SettingsScreen({super.key, required this.currentUserRole});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedMainSection = 0; // 0 = الحساب, 1 = الأعضاء
  int _selectedAccountSection =
      0; // 0 = البيانات الشخصية, 1 = تعديل كلمة المرور

  // متغيرات للتأثيرات التفاعلية
  int? _hoveredMainItem;
  int? _hoveredAccountItem;

  final String _selectedLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context); // Access localization

    return Scaffold(
      appBar: AppBar(
        title: SelectableText(
          localizations.accountSettings, // Use localization key
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFFFA7C1F),
        elevation: 0,
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsShowSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: SelectableText(state.message),
                backgroundColor:
                    state.isError ? Colors.red : const Color(0xFFFA7C1F),
              ),
            );
            return;
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFA7C1F)),
            );
          }
          if (state is SettingsSuccess) {
            // إعادة بناء واجهة المستخدم عند نجاح العملية
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange.shade50, Colors.white],
                ),
              ),
              child: Row(
                children: [
                  // القائمة الرئيسية
                  Card(
                    margin: const EdgeInsets.all(16.0),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFA7C1F).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.settings,
                                  color: Color(0xFFFA7C1F),
                                ),
                                const SizedBox(width: 12),
                                SelectableText(
                                  localizations
                                      .mainMenu, // Use localization key
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          _buildMainMenuItem(
                            index: 0,
                            label:
                                localizations.account, // Use localization key
                            icon: Icons.person,
                          ),
                          if (widget.currentUserRole == 1)
                            _buildMainMenuItem(
                              index: 1,
                              label:
                                  localizations.users, // Use localization key
                              icon: Icons.group,
                            ),
                          const Divider(height: 32),
                          if (_selectedMainSection == 0) ...[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: SelectableText(
                                localizations
                                    .accountSettings, // Use localization key
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildAccountMenuItem(
                              index: 0,
                              label:
                                  localizations
                                      .personalInfo, // Use localization key
                              icon: Icons.account_circle,
                            ),
                            _buildAccountMenuItem(
                              index: 1,
                              label:
                                  localizations
                                      .changePassword, // Use localization key
                              icon: Icons.lock,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  // المحتوى الرئيسي
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _buildContent(localizations),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: SelectableText(
              localizations.unexpectedError, // Use localization key
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainMenuItem({
    required int index,
    required String label,
    required IconData icon,
  }) {
    bool isSelected = _selectedMainSection == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredMainItem = index),
      onExit: (_) => setState(() => _hoveredMainItem = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap:
            () => setState(() {
              _selectedMainSection = index;
              _selectedAccountSection = 0;
            }),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFFFA7C1F)
                    : _hoveredMainItem == index
                    ? const Color(0xFFFDEBD9)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: const Color(0xFFFA7C1F).withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color:
                    isSelected
                        ? Colors.white
                        : _hoveredMainItem == index
                        ? const Color(0xFFFA7C1F)
                        : Colors.grey[700],
              ),
              const SizedBox(width: 12),
              SelectableText(
                label,
                style: TextStyle(
                  color:
                      isSelected
                          ? Colors.white
                          : _hoveredMainItem == index
                          ? const Color(0xFFFA7C1F)
                          : Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(S localizations) {
    switch (_selectedMainSection) {
      case 0:
        return _buildAccountContent(localizations);
      case 1:
        if (widget.currentUserRole == 1) {
          return MembersPage(localizations: localizations);
        }
        break;
    }
    return Center(
      child: SelectableText(
        localizations.contentUnavailable, // Use localization key
        style: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget _buildAccountContent(S localizations) {
    if (_selectedAccountSection == 0) {
      return PersonalInfoPage(localizations: localizations);
    } else {
      return PasswordChangePage(localizations: localizations);
    }
  }

  Widget _buildAccountMenuItem({
    required int index,
    required String label,
    required IconData icon,
  }) {
    bool isSelected = _selectedAccountSection == index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredAccountItem = index),
      onExit: (_) => setState(() => _hoveredAccountItem = null),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _selectedAccountSection = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: _getBackgroundColor(isSelected, index),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFFFA7C1F) : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: _getIconColor(isSelected, index)),
              const SizedBox(width: 8),
              SelectableText(
                label,
                style: TextStyle(
                  color: _getTextColor(isSelected, index),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(bool isSelected, int index) {
    if (isSelected) {
      return const Color(0xFFFDEBD9);
    } else if (_hoveredAccountItem == index) {
      return Colors.orange.shade50;
    }
    return Colors.transparent;
  }

  Color _getIconColor(bool isSelected, int index) {
    if (isSelected || _hoveredAccountItem == index) {
      return const Color(0xFFFA7C1F);
    }
    return Colors.grey[600]!;
  }

  Color _getTextColor(bool isSelected, int index) {
    if (isSelected || _hoveredAccountItem == index) {
      return const Color(0xFFFA7C1F);
    }
    return Colors.grey[600]!;
  }
}
