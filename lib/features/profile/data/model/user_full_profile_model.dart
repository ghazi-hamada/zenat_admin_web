class UserFullProfileModel {
  int? usersId;
  String? usersName;
  String? usersEmail;
  String? usersImegUrl;
  String? usersPassword;
  String? usersBirthDate;
  int? usersGender;
  int? usersPhone;
  int? usersVerifyCode;
  int? usersApprove;
  int? usersProfileStep;
  int? usersType;
  String? usersCreatedAt;
  int? specificationsId;
  int? specificationsUserid;
  int? specificationsHeightCm;
  int? specificationsWeightKg;
  int? specificationsPhysique;
  int? specificationsSkinColor;
  int? specificationsEyeColor;
  String? specificationsImageUserUrl;
  int? religionId;
  int? religionUserid;
  int? religionPrayer;
  int? religionReligiosity;
  int? religionHijab;
  int? religionSmoking;
  int? religionMusic;
  int? religionBeard;
  int? socialStatusId;
  int? socialStatusUserid;
  int? socialStatusMaritalStatus;
  int? socialStatusMarriageType;
  int? socialStatusAge;
  int? socialStatusHasChildren;
  int? appearanceId;
  int? appearanceUserid;
  String? appearanceDescriptive;
  String? appearanceDescribeYourLove;
  int? educationWorkId;
  int? educationWorkUserId;
  int? educationWorkEducationLevel;
  int? educationWorkFinancialStatus;
  int? educationWorkScopeOfWork;
  int? educationWorkMonthlyIncome;
  int? educationWorkHealthStatus;
  String? educationWorkJob;
  int? nationalityResidenceId;
  int? nationalityResidenceUserid;
  int? nationalityResidenceNationality;
  String? nationalityResidenceCity;
  String? nationalityResidenceAddress;
  String? paymentStatus;
  String? subscriptionPlan;
  int? paymentId;
  int? likeIt;
  int? usersIsDeleted;

  UserFullProfileModel({
    this.usersId,
    this.usersName,
    this.usersEmail,
    this.usersImegUrl,
    this.usersPassword,
    this.usersBirthDate,
    this.usersGender,
    this.usersPhone,
    this.usersVerifyCode,
    this.usersApprove,
    this.usersProfileStep,
    this.usersType,
    this.usersIsDeleted,
    this.usersCreatedAt,
    this.specificationsId,
    this.specificationsUserid,
    this.specificationsHeightCm,
    this.specificationsWeightKg,
    this.specificationsPhysique,
    this.specificationsSkinColor,
    this.specificationsEyeColor,
    this.specificationsImageUserUrl,
    this.religionId,
    this.religionUserid,
    this.religionPrayer,
    this.religionReligiosity,
    this.religionHijab,
    this.religionSmoking,
    this.religionMusic,
    this.religionBeard,
    this.socialStatusId,
    this.socialStatusUserid,
    this.socialStatusMaritalStatus,
    this.socialStatusMarriageType,
    this.socialStatusAge,
    this.socialStatusHasChildren,
    this.appearanceId,
    this.appearanceUserid,
    this.appearanceDescriptive,
    this.appearanceDescribeYourLove,
    this.educationWorkId,
    this.educationWorkUserId,
    this.educationWorkEducationLevel,
    this.educationWorkFinancialStatus,
    this.educationWorkScopeOfWork,
    this.educationWorkMonthlyIncome,
    this.educationWorkHealthStatus,
    this.educationWorkJob,
    this.nationalityResidenceId,
    this.nationalityResidenceUserid,
    this.nationalityResidenceNationality,
    this.nationalityResidenceCity,
    this.nationalityResidenceAddress,
    this.paymentStatus,
    this.subscriptionPlan,
    this.paymentId,
  });

  UserFullProfileModel.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersImegUrl = json['users_imeg_url'];
    usersPassword = json['users_password'];
    usersBirthDate = json['users_birth_date'];
    usersGender = json['users_gender'];
    usersPhone = json['users_phone'];
    usersVerifyCode = json['users_verify_code'];
    usersApprove = json['users_approve'];
    usersProfileStep = json['users_profile_step'];
    usersType = json['users_type'];
    usersIsDeleted = json['users_is_deleted'];
    usersCreatedAt = json['users_created_at'];
    specificationsId = json['specifications_id'];
    specificationsUserid = json['specifications_userid'];
    specificationsHeightCm = json['specifications_height_cm'];
    specificationsWeightKg = json['specifications_weight_kg'];
    specificationsPhysique = json['specifications_physique'];
    specificationsSkinColor = json['specifications_skin_color'];
    specificationsEyeColor = json['specifications_eye_color'];
    specificationsImageUserUrl = json['specifications_image_user_url'];
    religionId = json['religion_id'];
    religionUserid = json['religion_userid'];
    religionPrayer = json['religion_prayer'];
    religionReligiosity = json['religion_religiosity'];
    religionHijab = json['religion_hijab'];
    religionSmoking = json['religion_smoking'];
    religionMusic = json['religion_music'];
    religionBeard = json['religion_beard'];
    socialStatusId = json['social_status_id'];
    socialStatusUserid = json['social_status_userid'];
    socialStatusMaritalStatus = json['social_status_marital_status'];
    socialStatusMarriageType = json['social_status_marriage_type'];
    socialStatusAge = json['social_status_age'];
    socialStatusHasChildren = json['social_status_has_children'];
    appearanceId = json['appearance_id'];
    appearanceUserid = json['appearance_userid'];
    appearanceDescriptive = json['appearance_descriptive'];
    appearanceDescribeYourLove = json['appearance_describe_your_love'];
    educationWorkId = json['education_work_id'];
    educationWorkUserId = json['education_work_user_id'];
    educationWorkEducationLevel = json['education_work_education_level'];
    educationWorkFinancialStatus = json['education_work_financial_status'];
    educationWorkScopeOfWork = json['education_work_Scope_of_work'];
    educationWorkMonthlyIncome = json['education_work_monthly_income'];
    educationWorkHealthStatus = json['education_work_health_status'];
    educationWorkJob = json['education_work_job'];
    nationalityResidenceId = json['nationality_residence_id'];
    nationalityResidenceUserid = json['nationality_residence_userid'];
    nationalityResidenceNationality = json['nationality_residence_nationality'];
    nationalityResidenceCity = json['nationality_residence_city'];
    nationalityResidenceAddress = json['nationality_residence_address'];
    paymentStatus = json['payment_status'];
    subscriptionPlan = json['subscription_plan'];
    paymentId = json['payment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users_id'] = usersId;
    data['users_name'] = usersName;
    data['users_email'] = usersEmail;
    data['users_imeg_url'] = usersImegUrl;
    data['users_password'] = usersPassword;
    data['users_birth_date'] = usersBirthDate;
    data['users_gender'] = usersGender;
    data['users_phone'] = usersPhone;
    data['users_verify_code'] = usersVerifyCode;
    data['users_approve'] = usersApprove;
    data['users_profile_step'] = usersProfileStep;
    data['users_type'] = usersType;
    data['users_is_deleted'] = usersIsDeleted;
    data['users_created_at'] = usersCreatedAt;
    data['specifications_id'] = specificationsId;
    data['specifications_userid'] = specificationsUserid;
    data['specifications_height_cm'] = specificationsHeightCm;
    data['specifications_weight_kg'] = specificationsWeightKg;
    data['specifications_physique'] = specificationsPhysique;
    data['specifications_skin_color'] = specificationsSkinColor;
    data['specifications_eye_color'] = specificationsEyeColor;
    data['specifications_image_user_url'] = specificationsImageUserUrl;
    data['religion_id'] = religionId;
    data['religion_userid'] = religionUserid;
    data['religion_prayer'] = religionPrayer;
    data['religion_religiosity'] = religionReligiosity;
    data['religion_hijab'] = religionHijab;
    data['religion_smoking'] = religionSmoking;
    data['religion_music'] = religionMusic;
    data['religion_beard'] = religionBeard;
    data['social_status_id'] = socialStatusId;
    data['social_status_userid'] = socialStatusUserid;
    data['social_status_marital_status'] = socialStatusMaritalStatus;
    data['social_status_marriage_type'] = socialStatusMarriageType;
    data['social_status_age'] = socialStatusAge;
    data['social_status_has_children'] = socialStatusHasChildren;
    data['appearance_id'] = appearanceId;
    data['appearance_userid'] = appearanceUserid;
    data['appearance_descriptive'] = appearanceDescriptive;
    data['appearance_describe_your_love'] = appearanceDescribeYourLove;
    data['education_work_id'] = educationWorkId;
    data['education_work_user_id'] = educationWorkUserId;
    data['education_work_education_level'] = educationWorkEducationLevel;
    data['education_work_financial_status'] = educationWorkFinancialStatus;
    data['education_work_Scope_of_work'] = educationWorkScopeOfWork;
    data['education_work_monthly_income'] = educationWorkMonthlyIncome;
    data['education_work_health_status'] = educationWorkHealthStatus;
    data['education_work_job'] = educationWorkJob;
    data['nationality_residence_id'] = nationalityResidenceId;
    data['nationality_residence_userid'] = nationalityResidenceUserid;
    data['nationality_residence_nationality'] = nationalityResidenceNationality;
    data['nationality_residence_city'] = nationalityResidenceCity;
    data['nationality_residence_address'] = nationalityResidenceAddress;
    data['payment_status'] = paymentStatus;
    data['subscription_plan'] = subscriptionPlan;
    data['payment_id'] = paymentId;
    return data;
  }
}
