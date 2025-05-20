class ComplaintModel {
  int? complaintId;
  String? userName;
  String? userEmail;
  int? userPhone;
  int? subjectIndex;
  String? customSubject;
  String? message;
  String? createdAt;

  ComplaintModel({
    this.complaintId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.subjectIndex,
    this.customSubject,
    this.message,
    this.createdAt,
  });

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    complaintId = json['complaint_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    subjectIndex = json['subject_index'];
    customSubject = json['custom_subject'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['complaint_id'] = complaintId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_phone'] = userPhone;
    data['subject_index'] = subjectIndex;
    data['custom_subject'] = customSubject;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
