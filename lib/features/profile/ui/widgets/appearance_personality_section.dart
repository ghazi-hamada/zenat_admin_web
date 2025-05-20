import 'package:flutter/material.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class AppearancePersonalitySection extends StatelessWidget {
  final dynamic user;
  const AppearancePersonalitySection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: S.of(context).appearanceAndPersonality,
      children: [
        InfoRow(S.of(context).description, user.appearanceDescriptive ?? '-'),
        InfoRow(
          S.of(context).loveTraits,
          user.appearanceDescribeYourLove ?? '-',
        ),
      ],
    );
  }
}
