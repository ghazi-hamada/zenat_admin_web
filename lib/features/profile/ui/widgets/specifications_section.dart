import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/static/static_profile.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class SpecificationsSection extends StatelessWidget {
  final dynamic user;
  const SpecificationsSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SectionCard(
      title: S.of(context).specifications,
      children: [
        InfoRow(
          S.of(context).heightCm,
          user.specificationsHeightCm?.toString() ?? '-',
        ),
        InfoRow(
          S.of(context).weightKg,
          user.specificationsWeightKg?.toString() ?? '-',
        ),
        InfoRow(
          S.of(context).physique,
          isArabic
              ? AppStaticProfile().bodyTypesAr[user.specificationsPhysique ?? 0]
              : AppStaticProfile().bodyTypesEn[user.specificationsPhysique ??
                  0],
        ),
        InfoRow(
          S.of(context).skinColor,
          isArabic
              ? AppStaticProfile().skinColorsAr[user.specificationsSkinColor ??
                  0]
              : AppStaticProfile().skinColorsEn[user.specificationsSkinColor ??
                  0],
        ),
        InfoRow(
          S.of(context).eyeColor,
          isArabic
              ? AppStaticProfile().eyeColorsAr[user.specificationsEyeColor ?? 0]
              : AppStaticProfile().eyeColorsEn[user.specificationsEyeColor ??
                  0],
        ),
      ],
    );
  }
}
