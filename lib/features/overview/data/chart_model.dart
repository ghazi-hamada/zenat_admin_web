class ChartData {
  final String label;
  final int count;

  ChartData({required this.label, required this.count});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json['label'],
      count: json['count'],
    );
  }
}
