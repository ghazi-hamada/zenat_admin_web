import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/static/static_profile.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class ReligionSection extends StatelessWidget {
  final dynamic user;
  const ReligionSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SectionCard(
      title: S.of(context).religion,
      children: [
        InfoRow(
          S.of(context).prayer,
          isArabic
              ? AppStaticProfile().prayerHabitsAr[user.religionPrayer ?? 0]
              : AppStaticProfile().prayerHabitsEn[user.religionPrayer ?? 0],
        ),
        InfoRow(
          S.of(context).religiosity,
          isArabic
              ? AppStaticProfile()
                  .religiosityLevelsAr[user.religionReligiosity ?? 0]
              : AppStaticProfile()
                  .religiosityLevelsEn[user.religionReligiosity ?? 0],
        ),
        InfoRow(
          S.of(context).hijab,
          isArabic
              ? AppStaticProfile().hijabTypesAr[user.religionHijab ?? 0]
              : AppStaticProfile().hijabTypesEn[user.religionHijab ?? 0],
        ),
        InfoRow(
          S.of(context).smoking,
          isArabic
              ? AppStaticProfile().smokingHabitsAr[user.religionSmoking ?? 0]
              : AppStaticProfile().smokingHabitsEn[user.religionSmoking ?? 0],
        ),
        InfoRow(S.of(context).music, user.religionMusic.toString()),
        InfoRow(
          S.of(context).beard,
          isArabic
              ? AppStaticProfile().beardStatusAr[user.religionBeard ?? 0]
              : AppStaticProfile().beardStatusEn[user.religionBeard ?? 0],
        ),
      ],
    );
  }
}
