class SubscriptionPricesModel {
  final double monthly;
  final double sixMonths;
  final double yearly;
  final String currency;

  SubscriptionPricesModel({
    required this.monthly,
    required this.sixMonths,
    required this.yearly,
    required this.currency,
  });

  factory SubscriptionPricesModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPricesModel(
      monthly: (json['monthly'] as num).toDouble(),
      sixMonths: (json['6months'] as num).toDouble(),
      yearly: (json['yearly'] as num).toDouble(),
      currency: json['currency'] ?? '',
    );
  }
}
