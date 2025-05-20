import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/showSnackBar.dart';
import 'package:zenat_admin_web/features/settings/logic/settings_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class PersonalInfoPage extends StatelessWidget {
  final S localizations;

  const PersonalInfoPage({super.key, required this.localizations});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SettingsCubit>();
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
       if(state is SettingsShowSnackbar){
        showSnackBar(context, state.message , isError: state.isError);
       }
      },
      builder: (context, state) {
        if (state is SettingsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Color(0xFFFA7C1F),
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    SelectableText(
                      localizations.personalInfo,
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
                  localizations.updatePersonalInfo,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF777777),
                  ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange.shade50,
                                border: Border.all(
                                  color: const Color(0xFFFA7C1F),
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 64,
                                  color: Colors.orange.shade300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: SelectableText(
                                        localizations.chooseProfilePicture,
                                      ),
                                    ),
                                  );
                                },
                                child: SelectableText(
                                  localizations.changePicture,
                                  style: TextStyle(
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: _textInput(
                              cubit.nameCtrl,
                              localizations.fullName,
                              prefixIcon: const Icon(Icons.person_outline),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _textInput(
                              cubit.emailCtrl,
                              localizations.email,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _textInput(
                              cubit.phoneCtrl,
                              localizations.phoneNumber,
                              prefixIcon: const Icon(Icons.phone_outlined),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _textInput(
                              cubit.birthDateCtrl,
                              localizations.birthDate,
                              prefixIcon: const Icon(
                                Icons.calendar_today_outlined,
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (pickedDate != null) {
                                  cubit.birthDateCtrl.text =
                                      "${pickedDate.toLocal()}".split(' ')[0];
                                }
                              },
                              readOnly: true,
                            ),
                          ),
                        ],
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
                                cubit.editProfile();
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
                                localizations.saveChanges,
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
              ],
            ),
          ),
        );
      },
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
