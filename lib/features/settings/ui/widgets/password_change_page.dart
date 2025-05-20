import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/settings/logic/settings_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class PasswordChangePage extends StatelessWidget {
  final S localizations;

  const PasswordChangePage({super.key, required this.localizations});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SettingsCubit>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Color(0xFFFA7C1F),
                  size: 28,
                ),
                const SizedBox(width: 12),
                SelectableText(
                  localizations.changePassword,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              localizations.updatePasswordInfo,
              style: const TextStyle(fontSize: 14, color: Color(0xFF777777)),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textInput(
                      cubit.oldPasswordCtrl,
                      localizations.currentPassword,
                      obscure: cubit.isOldPasswordVisible,
                      prefixIcon: InkWell(
                        onTap: () => cubit.toggleOldPasswordVisibility(),
                        child: Icon(
                          cubit.isOldPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    _textInput(
                      cubit.passwordCtrl,
                      localizations.newPassword,
                      obscure: cubit.isPasswordVisible,
                      prefixIcon: InkWell(
                        onTap: () => cubit.togglePasswordVisibility(),
                        child: Icon(
                          cubit.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _textInput(
                      cubit.confirmPasswordCtrl,
                      localizations.confirmNewPassword,
                      obscure: cubit.isConfirmPasswordVisible,
                      prefixIcon: InkWell(
                        onTap: () => cubit.toggleConfirmPasswordVisibility(),
                        child: Icon(
                          cubit.isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Colors.blue,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              SelectableText(
                                localizations.passwordTipsTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            localizations.passwordTips,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blue,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: SelectableText(
                                    localizations.cancelChanges,
                                  ),
                                ),
                              );
                            },
                            child: SelectableText(
                              localizations.cancel,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              cubit.changePassword();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFA7C1F),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.save, color: Colors.white),
                            label: SelectableText(
                              localizations.updatePassword,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textInput(
    TextEditingController controller,
    String label, {
    bool obscure = false,
    Widget? prefixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localizations.enterField(label);
        }
        return null;
      },
    );
  }
}
