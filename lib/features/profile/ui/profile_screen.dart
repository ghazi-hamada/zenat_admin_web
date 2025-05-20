import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/image_user.dart';
import 'package:zenat_admin_web/core/static/app_api_string.dart';
import 'package:zenat_admin_web/core/static/static_profile.dart';
import 'package:zenat_admin_web/features/profile/logic/profile_cubit.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/section_card.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/info_row.dart';
import 'package:zenat_admin_web/generated/l10n.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/basic_info_section.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/specifications_section.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/religion_section.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/social_status_section.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/appearance_personality_section.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/education_work_section.dart';
import 'package:zenat_admin_web/features/profile/ui/widgets/nationality_residence_section.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..getUserFullProfileData(userId: userId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).profileTitle),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading)
              return const Center(child: CircularProgressIndicator());
            if (state is ProfileFailure)
              return Center(child: Text(state.message));
            if (state is ProfileSuccess) {
              final user = state.userFullProfileModel;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          imageUser(image: user.usersImegUrl!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BasicInfoSection(user: user),
                    const SizedBox(height: 12),
                    SpecificationsSection(user: user),
                    const SizedBox(height: 12),
                    ReligionSection(user: user),
                    const SizedBox(height: 12),
                    SocialStatusSection(user: user),
                    const SizedBox(height: 12),
                    AppearancePersonalitySection(user: user),
                    const SizedBox(height: 12),
                    EducationWorkSection(user: user),
                    const SizedBox(height: 12),
                    NationalityResidenceSection(user: user),
                  ],
                ),
              );
            }
            return Center(child: Text(S.of(context).noData));
          },
        ),
      ),
    );
  }
}
