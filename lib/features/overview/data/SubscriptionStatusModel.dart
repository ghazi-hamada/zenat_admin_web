class SubscriptionStatusModel {
  final String status;
  final int count;
  final double percent;

  SubscriptionStatusModel({
    required this.status,
    required this.count,
    required this.percent,
  });

  factory SubscriptionStatusModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatusModel(
      status: json['status'],
      count: json['count'],
      percent: json['percent'].toDouble(),
    );
  }
}
