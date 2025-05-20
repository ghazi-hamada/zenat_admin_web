import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/stories/logic/stories_cubit.dart';
import 'package:zenat_admin_web/features/stories/data/StoriesModel.dart';
import 'package:intl/intl.dart';
import 'package:zenat_admin_web/generated/l10n.dart';

class StoriesScreen extends StatelessWidget {
  StoriesScreen({super.key});

  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoriesCubit()..fetchStories(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).storiesTitle,
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
          child: BlocBuilder<StoriesCubit, StoriesState>(
            builder: (context, state) {
              if (state is StoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFFFA7C1F)),
                );
              } else if (state is StoriesError) {
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
                        '${S.of(context).errorOccurred}: ${state.error}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<StoriesCubit>().fetchStories();
                        },
                        icon: const Icon(Icons.refresh),
                        label: Text(S.of(context).retry),
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
              } else if (state is StoriesLoaded) {
                final stories = state.stories;

                if (stories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          S.of(context).noStories,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: const Color(0xFFFA7C1F),
                                      size: 28,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      S
                                          .of(context)
                                          .storyTableTitle(stories.length),
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
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minWidth: 600,
                                      minHeight:
                                          MediaQuery.of(context).size.height -
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
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        columns: [
                                          DataColumn(
                                            label: Text(S.of(context).storyId),
                                          ),
                                          DataColumn(
                                            label: Text(S.of(context).userName),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              S.of(context).partnerName,
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              S.of(context).description,
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              S.of(context).marriageDate,
                                            ),
                                          ),

                                          DataColumn(
                                            label: Text(S.of(context).rating),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              S.of(context).isApproved,
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                              S.of(context).createdAt,
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(S.of(context).action),
                                          ),
                                        ],
                                        rows: List.generate(stories.length, (
                                          index,
                                        ) {
                                          final story = stories[index];
                                          return DataRow(
                                            onSelectChanged: (_) {
                                              _showStoryDetailsDialog(
                                                context,
                                                story,
                                              );
                                            },
                                            cells: [
                                              DataCell(
                                                Text(story.id.toString()),
                                              ),
                                              DataCell(
                                                Text(story.userName ?? '-'),
                                              ),
                                              DataCell(
                                                Text(story.partnerName ?? '-'),
                                              ),
                                              DataCell(
                                                Text(story.description ?? '-'),
                                              ),
                                              DataCell(
                                                Text(story.marriageDate ?? '-'),
                                              ),

                                              DataCell(
                                                Text(
                                                  story.rating?.toString() ??
                                                      '-',
                                                ),
                                              ),
                                              DataCell(
                                                Text(
                                                  (story.isApproved ?? 0) == 1
                                                      ? S.of(context).yes
                                                      : S.of(context).no,
                                                ),
                                              ),
                                              DataCell(
                                                Text(story.createdAt ?? '-'),
                                              ),
                                              DataCell(
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    _confirmDelete(
                                                      context,
                                                      story.id!,
                                                    );
                                                  },
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
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, int storyId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(S.of(context).confirmDelete as String),
            content: Text(S.of(context).deleteStoryConfirmation),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  S.of(context).cancel,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteStory(context, storyId);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  S.of(context).delete,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  void _deleteStory(BuildContext context, int storyId) {
    context.read<StoriesCubit>().deleteStory(storyId: storyId.toString());
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(S.of(context).storyDeleted)));
  }

  void _showStoryDetailsDialog(BuildContext context, StoriesModel story) {
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
                              Icons.book,
                              color: Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              S.of(context).storyDetailsTitle,
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
                            _buildInfoCard(context, story: story),
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
                                        Icons.description,
                                        color: Color(0xFFFA7C1F),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        S.of(context).description,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  SelectableText(
                                    story.description ?? '',
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
                                  label: Text(S.of(context).close),
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

  Widget _buildInfoCard(BuildContext context, {required StoriesModel story}) {
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
                  S.of(context).storyData,
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
                  label: S.of(context).userName,
                  value: story.userName ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.person_outline,
                  label: S.of(context).partnerName,
                  value: story.partnerName ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.event,
                  label: S.of(context).marriageDate,
                  value: story.marriageDate ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.star,
                  label: S.of(context).rating,
                  value: story.rating?.toString() ?? '-',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.check_circle,
                  label: S.of(context).isApproved,
                  value: (story.isApproved ?? 0) == 1 ? 'نعم' : 'لا',
                ),
                _buildInfoItem(
                  context,
                  icon: Icons.date_range,
                  label: S.of(context).createdAt,
                  value: story.createdAt ?? '-',
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
}
