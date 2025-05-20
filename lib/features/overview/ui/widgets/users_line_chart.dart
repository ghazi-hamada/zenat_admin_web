import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zenat_admin_web/features/overview/data/chart_model.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class UsersGrowthCard extends StatelessWidget {
  final List<ChartData> data;
  final String title;
  final Function(String period) onPeriodChange;
  final String selectedPeriod; // <-- إضافة هذا السطر

  UsersGrowthCard({
    super.key,
    required this.data,
    required this.onPeriodChange,
    required this.selectedPeriod, // <-- تأكد إنه required
    String? title,
  }) : title = title ?? 'Users Growth'; // <-- تأكد إنه title هو اسم المستخدم

  final List<String> periods = ['weekly', 'monthly', '6months', 'yearly'];

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children:
                periods.map((period) {
                  final isSelected =
                      period == selectedPeriod; // <-- يعتمد على البرّا
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected
                                ? const Color(0xFFFB962B)
                                : const Color(0xFFE0E0E0),
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        onPeriodChange(period);
                      },
                      child: Text(
                        period == 'weekly'
                            ? localizations.weekly
                            : period == 'monthly'
                            ? localizations.monthly
                            : period == '6months'
                            ? localizations.sixMonths
                            : localizations.yearly,
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < data.length) {
                          return Text(
                            data[index].label,
                            style: const TextStyle(fontSize: 12),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: const Color(0xFFFB962B),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                    spots:
                        data
                            .asMap()
                            .entries
                            .map(
                              (e) => FlSpot(
                                e.key.toDouble(),
                                e.value.count.toDouble(),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
