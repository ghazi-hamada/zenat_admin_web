class OverviewModel {
  final int totalUsers;
  final int totalFavorites;
  final int totalPayments;
  final int totalComplaints;
  final int totalBlocked;

  OverviewModel({
    required this.totalUsers,
    required this.totalFavorites,
    required this.totalPayments,
    required this.totalComplaints,
    required this.totalBlocked,
  });

  factory OverviewModel.fromJson(Map<String, dynamic> json) {
    return OverviewModel(
      totalUsers: json['total_users'] ?? 0,
      totalFavorites: json['total_favorites'] ?? 0,
      totalPayments: json['total_payments'] ?? 0,
      totalComplaints: json['total_complaints'] ?? 0,
      totalBlocked: json['total_blocked'] ?? 0,
    );
  }
}
