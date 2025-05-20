import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/overview/logic/overview_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class SubscriptionPieCard extends StatelessWidget {
  const SubscriptionPieCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OverviewCubit>();
    final data = cubit.subscriptionData;
    final localizations = S.of(context);

    if (data.isEmpty) {
      return const SizedBox(); // أو مؤشر تحميل إذا بتحب
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // Adjusted for web
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.subscriptionAnalysis,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: PieChart(
              PieChartData(
                sectionsSpace: 4,
                centerSpaceRadius: 50,
                sections:
                    data.map((e) {
                      final color = _getStatusColor(e.status);
                      return PieChartSectionData(
                        color: color,
                        value: e.percent,
                        title: "${e.percent.toStringAsFixed(1)}%",
                        radius: 70,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children:
                data.map((e) {
                  final color = _getStatusColor(e.status);
                  final statusLabel = _getStatusLabel(e.status, localizations);
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(radius: 8, backgroundColor: color),
                      const SizedBox(width: 8),
                      Text(
                        statusLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'notSubscribed':
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status, S localizations) {
    switch (status) {
      case 'completed':
        return localizations.subscribed;
      case 'pending':
        return localizations.pendingPayment;
      case 'notSubscribed':
      default:
        return localizations.notSubscribed;
    }
  }
}
