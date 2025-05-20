import 'package:flutter/material.dart';
import 'package:zenat_admin_web/core/static/static_profile.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class EducationWorkSection extends StatelessWidget {
  final dynamic user;
  const EducationWorkSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SectionCard(
      title: S.of(context).educationAndWork,
      children: [
        InfoRow(
          S.of(context).educationLevel,
          isArabic
              ? AppStaticProfile()
                  .educationLevelsAr[user.educationWorkEducationLevel ?? 0]
              : AppStaticProfile()
                  .educationLevelsEn[user.educationWorkEducationLevel ?? 0],
        ),
        InfoRow(
          S.of(context).financialStatus,
          isArabic
              ? AppStaticProfile()
                  .financialStatusAr[user.educationWorkFinancialStatus ?? 0]
              : AppStaticProfile()
                  .financialStatusEn[user.educationWorkFinancialStatus ?? 0],
        ),
        InfoRow(
          S.of(context).workScope,
          isArabic
              ? AppStaticProfile().jobFieldsAr[user.educationWorkScopeOfWork ??
                  0]
              : AppStaticProfile().jobFieldsEn[user.educationWorkScopeOfWork ??
                  0],
        ),
        InfoRow(
          S.of(context).monthlyIncome,
          isArabic
              ? AppStaticProfile()
                  .incomeLevelsAr[user.educationWorkMonthlyIncome ?? 0]
              : AppStaticProfile()
                  .incomeLevelsEn[user.educationWorkMonthlyIncome ?? 0],
        ),
        InfoRow(
          S.of(context).healthStatus,
          isArabic
              ? AppStaticProfile()
                  .healthConditionsAr[user.educationWorkHealthStatus ?? 0]
              : AppStaticProfile()
                  .healthConditionsEn[user.educationWorkHealthStatus ?? 0],
        ),
        InfoRow(S.of(context).job, user.educationWorkJob ?? '-'),
      ],
    );
  }
}
