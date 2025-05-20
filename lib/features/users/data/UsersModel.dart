class UsersModel {
  int? usersId;
  String? usersName;
  String? usersEmail;
  int? usersPhone;
  int? usersGender;
  String? usersBirthDate;
  int? usersApprove;
  int? usersType;
  int? usersIsDeleted;
  String? usersCreatedAt;
  String? subscriptionStatus;
  String? blockStatus;

  UsersModel({
    this.usersId,
    this.usersName,
    this.usersEmail,
    this.usersPhone,
    this.usersGender,
    this.usersBirthDate,
    this.usersApprove,
    this.usersType,
    this.usersIsDeleted,
    this.usersCreatedAt,
    this.subscriptionStatus,
    this.blockStatus,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    usersId = json['users_id'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
    usersGender = json['users_gender'];
    usersBirthDate = json['users_birth_date'];
    usersApprove = json['users_approve'];
    usersType = json['users_type'];
    usersIsDeleted = json['users_is_deleted'];
    usersCreatedAt = json['users_created_at'];
    subscriptionStatus = json['subscription_status'];
    blockStatus = json['block_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['users_id'] = usersId;
    data['users_name'] = usersName;
    data['users_email'] = usersEmail;
    data['users_phone'] = usersPhone;
    data['users_gender'] = usersGender;
    data['users_birth_date'] = usersBirthDate;
    data['users_approve'] = usersApprove;
    data['users_type'] = usersType;
    data['users_is_deleted'] = usersIsDeleted;
    data['users_created_at'] = usersCreatedAt;
    data['subscription_status'] = subscriptionStatus;
    data['block_status'] = blockStatus;
    return data;
  }
}
