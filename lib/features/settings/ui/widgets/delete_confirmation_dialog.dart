import 'package:flutter/material.dart';
import 'package:zenat_admin_web/features/settings/data/UsersDataModel.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final UsersDataModel member;
  final S localizations;
  final VoidCallback onDelete;

  const DeleteConfirmationDialog({
    super.key,
    required this.member,
    required this.localizations,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SelectableText(localizations.deleteConfirmation),
      content: SelectableText(localizations.confirmDelete(member.usersName!)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: SelectableText(
            localizations.cancel,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: onDelete,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: SelectableText(localizations.delete),
        ),
      ],
    );
  }
}
