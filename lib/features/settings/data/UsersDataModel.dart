class UsersDataModel {
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
  int? usersIsDeleted;
  String? usersDeleteReason;
  String? usersDeletedAt;
  String? usersCreatedAt;

  UsersDataModel({
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
    this.usersDeleteReason,
    this.usersDeletedAt,
    this.usersCreatedAt,
  });

  UsersDataModel.fromJson(Map<String, dynamic> json) {
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
    usersDeleteReason = json['users_delete_reason'];
    usersDeletedAt = json['users_deleted_at'];
    usersCreatedAt = json['users_created_at'];
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
    data['users_delete_reason'] = usersDeleteReason;
    data['users_deleted_at'] = usersDeletedAt;
    data['users_created_at'] = usersCreatedAt;
    return data;
  }
}
