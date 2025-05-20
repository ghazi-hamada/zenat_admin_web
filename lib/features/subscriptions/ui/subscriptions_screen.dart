import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/subscriptions/logic/subscriptions_cubit.dart';
import 'package:intl/intl.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionsCubit()..initialize(),
      child: BlocConsumer<SubscriptionsCubit, SubscriptionsState>(
        listener: (context, state) {
          if (state is SubscriptionsShowSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor:
                    state.isError ? Colors.red : const Color(0xFFFA7C1F),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<SubscriptionsCubit>();

          if (state is SubscriptionsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFA7C1F)),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).manageSubscriptions,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              backgroundColor: const Color(0xFFFA7C1F),
              elevation: 0,
            ),
            body: Row(
              children: [
                // Sidebar for subscription prices
                Container(
                  width: 300,
                  color: Colors.orange.shade50,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).setupSubscriptionPrices,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPriceInputField(
                        label: S.of(context).monthlyPrice,
                        controller: cubit.monthlyController,
                      ),
                      const SizedBox(height: 16),
                      _buildPriceInputField(
                        label: S.of(context).semiAnnualPrice,
                        controller: cubit.sixMonthsController,
                      ),
                      const SizedBox(height: 16),
                      _buildPriceInputField(
                        label: S.of(context).annualPrice,
                        controller: cubit.yearlyController,
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed:
                                cubit.isEditingEnabled
                                    ? () {
                                      cubit.editPrice();
                                    }
                                    : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  cubit.isEditingEnabled
                                      ? const Color(0xFFFA7C1F)
                                      : Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              S.of(context).savePrices,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1, color: Colors.grey),
                // Main content
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.orange.shade50, Colors.white],
                      ),
                    ),
                    child: BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
                      builder: (context, state) {
                        if (state is SubscriptionsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFFA7C1F),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Card(
                            color: Colors.white,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.subscriptions,
                                              color: const Color(0xFFFA7C1F),
                                              size: 28,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              S
                                                  .of(context)
                                                  .manageSubscriptionsCount(
                                                    cubit
                                                        .subscriptionData
                                                        .length,
                                                  ),
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF333333),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 16,
                                                color: Colors.grey[600],
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                DateFormat(
                                                  'dd/MM/yyyy',
                                                ).format(DateTime.now()),
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Expanded(
                                    child: Scrollbar(
                                      controller:
                                          ScrollController(), // Attach a ScrollController
                                      thumbVisibility: true,
                                      trackVisibility: true,
                                      thickness: 8,
                                      radius: const Radius.circular(8),
                                      child: SingleChildScrollView(
                                        controller:
                                            ScrollController(), // Attach the same ScrollController
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: DataTable(
                                            headingRowColor:
                                                WidgetStateProperty.all(
                                                  const Color(0xFFFFF1E5),
                                                ),
                                            dataRowColor:
                                                WidgetStateProperty.resolveWith(
                                                  (states) {
                                                    if (states.contains(
                                                      WidgetState.selected,
                                                    )) {
                                                      return Colors.orange[50];
                                                    }
                                                    return null;
                                                  },
                                                ),
                                            dataRowHeight: 60,
                                            headingRowHeight: 56,
                                            horizontalMargin: 20,
                                            columnSpacing: 24,
                                            border: TableBorder(
                                              horizontalInside: BorderSide(
                                                width: 1,
                                                color: Colors.grey[300]!,
                                              ),
                                              verticalInside: BorderSide(
                                                width: 1,
                                                color: Colors.grey[300]!,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            columns: [
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).number,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).userName,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).email,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).phoneNumber,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S
                                                      .of(context)
                                                      .subscriptionType,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).amount,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).currency,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).paymentStatus,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).startDate,
                                                ),
                                              ),
                                              DataColumn(
                                                label: Text(
                                                  S.of(context).endDate,
                                                ),
                                              ),
                                            ],
                                            rows: List.generate(
                                              cubit.subscriptionData.length,
                                              (index) {
                                                final sub =
                                                    cubit
                                                        .subscriptionData[index];
                                                return DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Text('${index + 1}'),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        sub.usersName ?? '-',
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        sub.usersEmail ?? '-',
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        sub.usersPhone
                                                                ?.toString() ??
                                                            '-',
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        planName(
                                                          context,
                                                          sub.subscriptionPlan ==
                                                                  1
                                                              ? 'monthly'
                                                              : sub.subscriptionPlan ==
                                                                  2
                                                              ? 'semiannual'
                                                              : 'annual',
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        sub.amount.toString() ??
                                                            '-',
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(sub.currency ?? '-'),
                                                    ),
                                                    DataCell(
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            sub.status ==
                                                                    'active'
                                                                ? Icons
                                                                    .check_circle
                                                                : Icons
                                                                    .hourglass_bottom,
                                                            color:
                                                                sub.status ==
                                                                        'active'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .orange,
                                                            size: 20,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            statusText(
                                                              context,
                                                              sub.status,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        sub.startDate ?? '-',
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(sub.endDate ?? '-'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper method to build input fields for prices
  Widget _buildPriceInputField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }

  String statusText(BuildContext context, String? status) {
    switch (status) {
      case 'active':
        return S.of(context).statusCompleted;

      default:
        return S.of(context).statusUnknown;
    }
  }

  String planName(BuildContext context, String? plan) {
    switch (plan) {
      case 'monthly':
        return S.of(context).planMonthly;
      case 'semiannual':
        return S.of(context).planSemiAnnual;
      case 'annual':
        return S.of(context).planAnnual;
      default:
        return S.of(context).planUndefined;
    }
  }
}
