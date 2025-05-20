class SubscriptionsModel {
  int? id;
  int? subscriptionPlan;
  double? amount;
  String? currency;
  String? status;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? usersName;
  String? usersEmail;
  int? usersPhone;

  SubscriptionsModel({
    this.id,
    this.subscriptionPlan,
    this.amount,
    this.currency,
    this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.usersName,
    this.usersEmail,
    this.usersPhone,
  });

  SubscriptionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionPlan = json['subscription_plan'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    usersName = json['users_name'];
    usersEmail = json['users_email'];
    usersPhone = json['users_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subscription_plan'] = subscriptionPlan;
    data['amount'] = amount;
    data['currency'] = currency;
    data['status'] = status;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['users_name'] = usersName;
    data['users_email'] = usersEmail;
    data['users_phone'] = usersPhone;
    return data;
  }
}
