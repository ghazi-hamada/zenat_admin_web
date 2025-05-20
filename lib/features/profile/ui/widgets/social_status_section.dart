import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/static/static_profile.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class SocialStatusSection extends StatelessWidget {
  final dynamic user;
  const SocialStatusSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SectionCard(
      title: S.of(context).socialStatus,
      children: [
        InfoRow(
          S.of(context).status,
          isArabic
              ? AppStaticProfile()
                  .maritalStatusAr[user.socialStatusMaritalStatus ?? 0]
              : AppStaticProfile()
                  .maritalStatusEn[user.socialStatusMaritalStatus ?? 0],
        ),
        InfoRow(
          S.of(context).marriageType,
          isArabic
              ? AppStaticProfile()
                  .multipleWivesPreferenceAr[user.socialStatusMarriageType ?? 0]
              : AppStaticProfile().multipleWivesPreferenceEn[user
                      .socialStatusMarriageType ??
                  0],
        ),
        InfoRow(S.of(context).age, user.socialStatusAge.toString()),
        InfoRow(
          S.of(context).hasChildren,
          user.socialStatusHasChildren.toString(),
        ),
      ],
    );
  }
}
