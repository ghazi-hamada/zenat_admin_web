import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/showSnackBar.dart';
import 'package:zenat_admin_web/features/profile/ui/profile_screen.dart';
import 'package:zenat_admin_web/features/users/logic/users_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';
import 'package:intl/intl.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit()..getUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).usersTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xFFFA7C1F),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.orange.shade50, Colors.white],
            ),
          ),
          child: BlocConsumer<UsersCubit, UsersState>(
            listener: (context, state) {
              if (state is UsersBlockSuccess) {
                showSnackBar(context, 'تم حظر المستخدم بنجاح', isError: false);
              } else if (state is UsersFailure) {
                showSnackBar(context, state.message, isError: true);
              }
            },
            builder: (context, state) {
              if (state is UsersLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFA7C1F)),
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
                    padding: const EdgeInsets.all(14.0), // Reduced from 16.0
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            14.0,
                          ), // Reduced from 16.0
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.people,
                                    color: const Color(0xFFFA7C1F),
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${S.of(context).usersTitle} (${context.read<UsersCubit>().usersList.length})',
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
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
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
                                      style: TextStyle(color: Colors.grey[700]),
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
                            controller: _verticalController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            thickness: 8,
                            radius: const Radius.circular(8),
                            child: SingleChildScrollView(
                              controller: _verticalController,
                              child: SingleChildScrollView(
                                controller: _horizontalController,
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 14.0,
                                  ), // Reduced from 16.0
                                  child: DataTable(
                                    headingRowColor: WidgetStateProperty.all(
                                      const Color(0xFFFFF1E5),
                                    ),
                                    dataRowColor:
                                        WidgetStateProperty.resolveWith((
                                          states,
                                        ) {
                                          if (states.contains(
                                            WidgetState.selected,
                                          )) {
                                            return Colors.orange[50];
                                          }
                                          return null;
                                        }),
                                    dataRowHeight: 55, // Reduced from 60
                                    headingRowHeight: 50, // Reduced from 56
                                    horizontalMargin: 15, // Reduced from 20
                                    columnSpacing: 20, // Reduced from 24
                                    showCheckboxColumn: false,
                                    border: TableBorder(
                                      horizontalInside: BorderSide(
                                        width: 1,
                                        color: Colors.grey[300]!,
                                      ),
                                      verticalInside: BorderSide(
                                        width: 1,
                                        color: Colors.grey[300]!,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    columns: [
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).number,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).email,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).phoneNumber,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).gender,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).birthDate,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).verificationStatus,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).isDeleted,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).createdAt,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).subscription,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          'block status',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SelectableText(
                                          S.of(context).options,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      context
                                          .read<UsersCubit>()
                                          .usersList
                                          .length,
                                      (index) {
                                        final user =
                                            context
                                                .read<UsersCubit>()
                                                .usersList[index];
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              SelectableText(
                                                (index + 1).toString(),
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersName ?? '-',
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersEmail ?? '-',
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersPhone?.toString() ??
                                                    '-',
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersGender == 1
                                                    ? S.of(context).male
                                                    : S.of(context).female,
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersBirthDate ==
                                                        "0000-00-00 00:00:00"
                                                    ? '-'
                                                    : user.usersBirthDate ??
                                                        '-',
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersApprove == 1
                                                    ? S.of(context).yes
                                                    : S.of(context).no,
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersIsDeleted == 1
                                                    ? S.of(context).yes
                                                    : S.of(context).no,
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.usersCreatedAt ?? '-',
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.subscriptionStatus ?? '-',
                                              ),
                                            ),
                                            DataCell(
                                              SelectableText(
                                                user.blockStatus == 'blocked'
                                                    ? S.of(context).yes
                                                    : S.of(context).no,
                                              ),
                                            ),
                                            DataCell(
                                              Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.visibility,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                _,
                                                              ) => ProfileScreen(
                                                                userId:
                                                                    context
                                                                        .read<
                                                                          UsersCubit
                                                                        >()
                                                                        .usersList[index]
                                                                        .usersId
                                                                        .toString(),
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                  ),

                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.block,
                                                      color: Colors.redAccent,
                                                    ),
                                                    onPressed: () {
                                                      _showBlockDialog(
                                                        context,
                                                        context
                                                            .read<UsersCubit>(),
                                                        user.usersId.toString(),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
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
    );
  }

  void _showBlockDialog(BuildContext ctx, UsersCubit cubit, String userId) {
    final reasonCtl = TextEditingController();
    final notesCtl = TextEditingController();
    DateTime? expires;
    bool isPermanent = false;

    showDialog(
      context: ctx,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('حظر المستخدم'),
            content: StatefulBuilder(
              builder: (context, setSt) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: reasonCtl,
                        decoration: const InputDecoration(labelText: 'السبب'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Checkbox(
                            value: isPermanent,
                            onChanged: (v) => setSt(() => isPermanent = v!),
                          ),
                          const Text('دائم'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (!isPermanent)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                expires == null
                                    ? 'تاريخ الانتهاء'
                                    : DateFormat('yyyy-MM-dd').format(expires!),
                              ),
                            ),
                            TextButton(
                              child: const Text('اختر'),
                              onPressed: () async {
                                final dt = await showDatePicker(
                                  context: ctx,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    const Duration(days: 365),
                                  ),
                                );
                                if (dt != null) setSt(() => expires = dt);
                              },
                            ),
                          ],
                        ),
                      TextField(
                        controller: notesCtl,
                        decoration: const InputDecoration(labelText: 'ملاحظات'),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                child: const Text('إلغاء'),
                onPressed: () => Navigator.pop(ctx),
              ),
              ElevatedButton(
                child: const Text('حظر'),
                onPressed: () {
                  final expStr =
                      isPermanent
                          ? ''
                          : (expires != null
                              ? DateFormat('yyyy-MM-dd').format(expires!)
                              : '');
                  cubit.addBlockUser(
                    userId: userId,
                    reason: reasonCtl.text,
                    expiresAt: expStr,
                    isPermanent: isPermanent ? '1' : '0',
                    notes: notesCtl.text,
                  );
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
    );
  }
}
