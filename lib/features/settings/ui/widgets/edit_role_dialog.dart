import 'package:flutter/material.dart';
import 'package:zenat_admin_web/features/settings/data/UsersDataModel.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class EditRoleDialog extends StatefulWidget {
  final UsersDataModel member;
  final S localizations;
  final Function(int) onSave;

  const EditRoleDialog({
    super.key,
    required this.member,
    required this.localizations,
    required this.onSave,
  });

  @override
  State<EditRoleDialog> createState() => _EditRoleDialogState();
}

class _EditRoleDialogState extends State<EditRoleDialog> {
  late int newRole;

  @override
  void initState() {
    super.initState();
    newRole = widget.member.usersType!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SelectableText(widget.localizations.editRole),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<int>(
            value: 1,
            groupValue: newRole,
            onChanged: (value) {
              if (value != null) {
                setState(() => newRole = value);
              }
            },
            title: SelectableText(widget.localizations.admin),
          ),
          RadioListTile<int>(
            value: 2,
            groupValue: newRole,
            onChanged: (value) {
              if (value != null) {
                setState(() => newRole = value);
              }
            },
            title: SelectableText(widget.localizations.readOnly),
          ),
        ],
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
            widget.onSave(newRole);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFA7C1F),
          ),
          child: SelectableText(widget.localizations.save),
        ),
      ],
    );
  }
}
