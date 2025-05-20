import 'package:flutter/material.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/custom_text_input.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class AddUserDialog extends StatefulWidget {
  final S localizations;
  final Function(Map<String, String>) onAddUser;

  const AddUserDialog({
    super.key,
    required this.localizations,
    required this.onAddUser,
  });

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController birthDateCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  String selectedGender = '1'; // 1 = Male, 0 = Female
  String selectedAccountType = '1'; // 1 = Admin, 2 = Read Only

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: SelectableText(widget.localizations.addUser),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextInput(
              controller: fullNameCtrl,
              label: widget.localizations.fullName,
              prefixIcon: const Icon(Icons.person),
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              controller: emailCtrl,
              label: widget.localizations.email,
              prefixIcon: const Icon(Icons.email),
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              controller: birthDateCtrl,
              label: widget.localizations.birthDate,
              prefixIcon: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  birthDateCtrl.text = "${pickedDate.toLocal()}".split(' ')[0];
                }
              },
              readOnly: true,
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              controller: phoneCtrl,
              label: widget.localizations.phoneNumber,
              prefixIcon: const Icon(Icons.phone),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: [
                DropdownMenuItem(
                  value: '1',
                  child: SelectableText(widget.localizations.male),
                ),
                DropdownMenuItem(
                  value: '0',
                  child: SelectableText(widget.localizations.female),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedGender = value);
                }
              },
              decoration: InputDecoration(
                labelText: widget.localizations.gender,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedAccountType,
              items: [
                DropdownMenuItem(
                  value: '1',
                  child: SelectableText(widget.localizations.admin),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: SelectableText(widget.localizations.readOnly),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedAccountType = value);
                }
              },
              decoration: InputDecoration(
                labelText: widget.localizations.accountType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              controller: passwordCtrl,
              label: widget.localizations.password,
              obscure: true,
              prefixIcon: const Icon(Icons.lock),
            ),
            const SizedBox(height: 8),
            CustomTextInput(
              controller: confirmPasswordCtrl,
              label: widget.localizations.confirmPassword,
              obscure: true,
              prefixIcon: const Icon(Icons.lock),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: SelectableText(
            widget.localizations.cancel,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onAddUser({
              'name': fullNameCtrl.text,
              'email': emailCtrl.text,
              'phone': phoneCtrl.text,
              'birthDate': birthDateCtrl.text,
              'gender': selectedGender,
              'password': passwordCtrl.text,
              'usersType': selectedAccountType,
            });
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
          ),
          child: SelectableText(widget.localizations.addUser),
        ),
      ],
    );
  }
}
