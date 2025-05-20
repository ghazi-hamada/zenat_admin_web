import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/overview/logic/overview_cubit.dart';
import 'package:zenat_admin_web/features/overview/ui/widgets/SubscriptionPieCard.dart';
import 'package:zenat_admin_web/features/overview/ui/widgets/users_line_chart.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);
    return BlocProvider(
      create: (context) {
        final cubit = OverviewCubit();
        cubit.getOverviewData();
        cubit.getDataToChart();
        cubit.getDataToPieChart();

        return cubit;
      },
      child: BlocBuilder<OverviewCubit, OverviewState>(
        builder: (context, state) {
          final cubit = context.read<OverviewCubit>();

          if (state is OverviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OverviewFailure) {
            return Text('${localizations.loadingFailed}: ${state.message}');
          }

          if (state is OverviewSuccess && cubit.overviewData != null ||
              state is OverviewChartLoading) {
            final data = cubit.overviewData!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.overviewTitle,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _StatCard(
                        title: localizations.totalUsers,
                        value: '${data.totalUsers}',
                        icon: Icons.people,
                      ),
                      _StatCard(
                        title: localizations.totalFavorites,
                        value: '${data.totalFavorites}',
                        icon: Icons.favorite,
                      ),
                      _StatCard(
                        title: localizations.totalPayments,
                        value: '${data.totalPayments}',
                        icon: Icons.payment,
                      ),
                      _StatCard(
                        title: localizations.totalComplaints,
                        value: '${data.totalComplaints}',
                        icon: Icons.report,
                      ),
                      _StatCard(
                        title: localizations.totalBlocked,
                        value: '${data.totalBlocked}',
                        icon: Icons.block,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 900) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UsersGrowthCard(
                              data: cubit.chartData,
                              selectedPeriod: cubit.selectedPeriod,
                              onPeriodChange: (period) {
                                cubit.setSelectedPeriod(period);
                                cubit.getDataToChart(period: period);
                              },
                            ),
                            const SizedBox(height: 24),
                            const SubscriptionPieCard(),
                          ],
                        );
                      } else {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: UsersGrowthCard(
                                data: cubit.chartData,
                                selectedPeriod: cubit.selectedPeriod,
                                onPeriodChange: (period) {
                                  cubit.setSelectedPeriod(period);
                                  cubit.getDataToChart(period: period);
                                },
                                title: localizations
                                    .usersGrowthTitle('{period}')
                                    .replaceFirst(
                                      '{period}',
                                      cubit.selectedPeriod == 'weekly'
                                          ? localizations.weekly
                                          : cubit.selectedPeriod == 'monthly'
                                          ? localizations.monthly
                                          : cubit.selectedPeriod == '6months'
                                          ? localizations.sixMonths
                                          : localizations.yearly,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            const Expanded(
                              flex: 1,
                              child: SubscriptionPieCard(),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox(); // أو شاشة انتظار مبدئية
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 30, color: const Color(0xFFFB962B)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
