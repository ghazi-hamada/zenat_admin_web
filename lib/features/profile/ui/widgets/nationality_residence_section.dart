import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/static/static_profile.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class NationalityResidenceSection extends StatelessWidget {
  final dynamic user;
  const NationalityResidenceSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SectionCard(
      title: S.of(context).nationalityAndResidence,
      children: [
        InfoRow(
          S.of(context).nationality,
          isArabic
              ? AppStaticProfile()
                  .nationalitiesAr[user.nationalityResidenceNationality ?? 0]
              : AppStaticProfile()
                  .nationalitiesEn[user.nationalityResidenceNationality ?? 0],
        ),
        InfoRow(S.of(context).city, user.nationalityResidenceCity ?? '-'),
        InfoRow(S.of(context).address, user.nationalityResidenceAddress ?? '-'),
      ],
    );
  }
}
