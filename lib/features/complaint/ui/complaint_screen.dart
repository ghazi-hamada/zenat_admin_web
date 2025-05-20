import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/complaint/data/complaint_model.dart';
import 'package:zenat_admin_web/features/complaint/logic/complaint_cubit.dart';
import 'package:intl/intl.dart' as intl;

import '../../../generated/l10n.dart';

// عناوين الشكاوى
const List<String> subjectsEn = [
  'Technical Support',
  'Feedback',
  'General Inquiry',
  'Other',
];
const List<String> subjectsAr = [
  'الدعم الفني',
  'ملاحظات',
  'استفسار عام',
  'أخرى',
];

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final l10n = S.of(context);

    return BlocProvider(
      create: (context) => ComplaintCubit()..fetchComplaints(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                l10n.complaintManagementTitle,
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
              child: BlocBuilder<ComplaintCubit, ComplaintState>(
                builder: (context, state) {
                  if (state is ComplaintLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFA7C1F),
                      ),
                    );
                  } else if (state is ComplaintError) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${l10n.errorOccurred}: ${state.error}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<ComplaintCubit>().fetchComplaints();
                            },
                            icon: const Icon(Icons.refresh),
                            label: Text(l10n.retry),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFA7C1F),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is ComplaintLoaded) {
                    final complaints = state.complaints;

                    if (complaints.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.noComplaints,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                                          Icons.support_agent,
                                          color: const Color(0xFFFA7C1F),
                                          size: 28,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          '${l10n.complaintTableTitle} (${complaints.length})',
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
                                            _getCurrentDate(),
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
                                  controller: scrollController,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  thickness: 8,
                                  radius: const Radius.circular(8),
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: 600,
                                          minHeight:
                                              MediaQuery.of(
                                                context,
                                              ).size.height -
                                              250,
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            dividerColor: Colors.grey[300],
                                            dataTableTheme: DataTableThemeData(
                                              headingTextStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF333333),
                                                fontSize: 16,
                                              ),
                                              dataTextStyle: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
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
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            columns: [
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.tag,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.complaintNumber),
                                                  ],
                                                ),
                                              ),
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.userName),
                                                  ],
                                                ),
                                              ),
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.email,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.userEmail),
                                                  ],
                                                ),
                                              ),
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.userPhone),
                                                  ],
                                                ),
                                              ),
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.category,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.subject),
                                                  ],
                                                ),
                                              ),
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.message,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.message),
                                                  ],
                                                ),
                                              ),
                                              DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.event,
                                                      size: 16,
                                                      color: const Color(
                                                        0xFFFA7C1F,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(l10n.sentDate),
                                                  ],
                                                ),
                                              ),
                                              const DataColumn(
                                                label: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.more_horiz,
                                                      size: 16,
                                                      color: Color(0xFFFA7C1F),
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text('إجراءات'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            rows: List.generate(complaints.length, (
                                              index,
                                            ) {
                                              final complaint =
                                                  complaints[index];
                                              return DataRow(
                                                onSelectChanged: (_) {
                                                  _showComplaintDetailsDialog(
                                                    context,
                                                    complaint,
                                                  );
                                                },
                                                cells: [
                                                  DataCell(
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                          0xFFFA7C1F,
                                                        ).withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        '${index + 1}',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                            0xFFFA7C1F,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      complaint.userName ?? '-',
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Tooltip(
                                                      message:
                                                          complaint.userEmail ??
                                                          '',
                                                      child: Text(
                                                        complaint.userEmail ??
                                                            '-',
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Text(
                                                      complaint.userPhone
                                                              ?.toString() ??
                                                          '-',
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: _getSubjectColor(
                                                          complaint
                                                              .subjectIndex,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                      ),
                                                      child: Text(
                                                        getComplaintSubject(
                                                          complaint
                                                              .subjectIndex,
                                                          complaint
                                                              .customSubject,
                                                        ),
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    ConstrainedBox(
                                                      constraints:
                                                          const BoxConstraints(
                                                            maxWidth: 200,
                                                          ),
                                                      child: Tooltip(
                                                        message:
                                                            complaint.message ??
                                                            '',
                                                        child: Text(
                                                          _getShortMessage(
                                                            complaint.message ??
                                                                '',
                                                          ),
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.access_time,
                                                          size: 14,
                                                          color:
                                                              Colors.grey[600],
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          complaint.createdAt ??
                                                              '-',
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  DataCell(
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          icon: const Icon(
                                                            Icons.visibility,
                                                            color: Color(
                                                              0xFFFA7C1F,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            _showComplaintDetailsDialog(
                                                              context,
                                                              complaint,
                                                            );
                                                          },
                                                          tooltip:
                                                              'عرض التفاصيل',
                                                        ),
                                                        // IconButton(
                                                        //   icon: const Icon(
                                                        //     Icons.mark_email_read,
                                                        //     color: Colors.green,
                                                        //   ),
                                                        //   onPressed: () {
                                                        //     // إضافة وظيفة لتحديد الشكوى كمقروءة
                                                        //     ScaffoldMessenger.of(
                                                        //       context,
                                                        //     ).showSnackBar(
                                                        //       const SnackBar(
                                                        //         content: Text(
                                                        //           'تم تحديد الشكوى كمقروءة',
                                                        //         ),
                                                        //         backgroundColor:
                                                        //             Colors.green,
                                                        //       ),
                                                        //     );
                                                        //   },
                                                        //   tooltip: 'تحديد كمقروءة',
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
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
                  } else {
                    return Center(child: Text(l10n.noData));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // اختصار الرسالة للعرض في الجدول
  String _getShortMessage(String message) {
    return message.length > 30 ? '${message.substring(0, 30)}...' : message;
  }

  // الحصول على التاريخ الحالي
  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }

  // الحصول على لون مناسب للموضوع
  Color _getSubjectColor(int? subjectIndex) {
    switch (subjectIndex) {
      case 0: // الدعم الفني
        return Colors.blue;
      case 1: // ملاحظات
        return Colors.purple;
      case 2: // استفسار عام
        return Colors.teal;
      case 3: // أخرى
        return Colors.amber[800]!;
      default:
        return Colors.grey;
    }
  }

  // عرض تفاصيل الشكوى في نافذة منبثقة
  void _showComplaintDetailsDialog(
    BuildContext context,
    ComplaintModel complaint,
  ) {
    final l10n = S.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFA7C1F),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.message,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              l10n.complaintDetailsTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoCard(context, complaint: complaint),
                            const SizedBox(height: 24),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.message,
                                        color: Color(0xFFFA7C1F),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${l10n.message}:',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.copy,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          // يمكن إضافة وظيفة نسخ النص هنا
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(l10n.messageCopied),
                                              duration: const Duration(
                                                seconds: 1,
                                              ),
                                            ),
                                          );
                                        },
                                        tooltip: l10n.copyText,
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  SelectableText(
                                    complaint.message ?? '',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _showReplyDialog(context, complaint);
                                  },
                                  icon: const Icon(Icons.reply),
                                  label: Text(l10n.replyToComplaint),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFA7C1F),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(Icons.check),
                                  label: Text(l10n.close),
                                ),
                              ],
                            ),
                          ],
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
    );
  }

  void _showReplyDialog(BuildContext context, ComplaintModel complaint) {
    final l10n = S.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.replyToComplaint,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 16),
                Form(
                  key: context.read<ComplaintCubit>().formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller:
                            context.read<ComplaintCubit>().subjectController,
                        decoration: InputDecoration(
                          labelText: l10n.messageSubject,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.enterMessageSubject;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller:
                            context.read<ComplaintCubit>().messageController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: l10n.messageContent,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.enterMessageContent;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFA7C1F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        print('Replying to complaint...');

                        context.read<ComplaintCubit>().sendEmailToUser(
                          email: complaint.userEmail!,
                        );
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.messageSentSuccessfully),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: Text(l10n.send),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(BuildContext context, {required dynamic complaint}) {
    final l10n = S.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: Color(0xFFFA7C1F), size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n.complaintDetailsTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildInfoItem(
                  context,
                  icon: Icons.person,
                  label: l10n.userName,
                  value: complaint.userName ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.email,
                  label: l10n.userEmail,
                  value: complaint.userEmail ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.phone,
                  label: l10n.userPhone,
                  value: complaint.userPhone?.toString() ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.category,
                  label: l10n.subject,
                  value: getComplaintSubject(
                    complaint.subjectIndex,
                    complaint.customSubject,
                  ),
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.event,
                  label: l10n.sentDate,
                  value: complaint.createdAt ?? '-',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة لتحويل subjectIndex أو customSubject لنص واضح
  String getComplaintSubject(int? index, String? customSubject) {
    if (customSubject != null && customSubject.trim().isNotEmpty) {
      return customSubject;
    } else if (index != null && index >= 0 && index < subjectsAr.length) {
      return subjectsAr[index];
    } else {
      return 'غير محدد';
    }
  }
}
