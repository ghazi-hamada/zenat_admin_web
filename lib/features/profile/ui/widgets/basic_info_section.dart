import 'package:flutter/material.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class BasicInfoSection extends StatelessWidget {
  final dynamic user;
  const BasicInfoSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: S.of(context).basicInfo,
      children: [
        InfoRow(S.of(context).name, user.usersName ?? '-'),
        InfoRow(S.of(context).email, user.usersEmail ?? '-'),
        InfoRow(S.of(context).phoneNumber, user.usersPhone?.toString() ?? '-'),
        InfoRow(
          S.of(context).gender,
          user.usersGender == 1 ? S.of(context).male : S.of(context).female,
        ),
        InfoRow(S.of(context).birthDate, user.usersBirthDate ?? '-'),
        InfoRow(S.of(context).verificationStatus, user.usersApprove.toString()),
        InfoRow(S.of(context).type, user.usersType.toString()),
        InfoRow(S.of(context).isDeleted, user.usersIsDeleted.toString()),
        InfoRow(S.of(context).joinedAt, user.usersCreatedAt ?? '-'),
        InfoRow(S.of(context).subscription, user.paymentStatus ?? '-'),
      ],
    );
  }
}
