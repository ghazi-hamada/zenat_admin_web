import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/core/functions/showSnackBar.dart';
import 'package:zenat_admin_web/features/settings/data/UsersDataModel.dart';
import 'package:zenat_admin_web/features/settings/logic/members/members_cubit.dart';
import 'package:zenat_admin_web/generated/l10n.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/edit_role_dialog.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/delete_confirmation_dialog.dart';
import 'package:zenat_admin_web/features/settings/ui/widgets/add_user_dialog.dart';

class MembersPage extends StatelessWidget {
  final S localizations;

  const MembersPage({super.key, required this.localizations});

  @override
  Widget build(BuildContext context) {
    // Fetch the members data when the widget is built
    context.read<MembersCubit>().getMembers();
    return BlocConsumer<MembersCubit, MembersState>(
      listener: (context, state) {
        if (state is MembersShowSnackbar) {
          showSnackBar(context, state.message, isError: state.isError);
        }
      },
      builder: (context, state) {
        if (state is MembersLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFFA7C1F)),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        color: Color(0xFFFA7C1F),
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      SelectableText(
                        localizations.manageUsers,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showAddUserDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.add, color: Colors.white),
                      label: SelectableText(
                        localizations.addUser,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SingleChildScrollView(
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(
                          Colors.orange.shade50,
                        ),
                        columnSpacing: 20,
                        columns: [
                          DataColumn(
                            label: SelectableText(
                              localizations.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SelectableText(
                              localizations.email,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SelectableText(
                              localizations.role,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: SelectableText(
                              localizations.actions,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        ],
                        rows:
                            context.read<MembersCubit>().membersData.map((
                              member,
                            ) {
                              return DataRow(
                                cells: [
                                  DataCell(SelectableText(member.usersName!)),
                                  DataCell(SelectableText(member.usersEmail!)),
                                  DataCell(
                                    SelectableText(
                                      member.usersType == 1
                                          ? localizations.admin
                                          : localizations.readOnly,
                                      style: TextStyle(
                                        color:
                                            member.usersType == 1
                                                ? Colors.green
                                                : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () {
                                            _showEditRoleDialog(
                                              context,
                                              member,
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DeleteConfirmationDialog(
                                                  member: member,
                                                  localizations: localizations,
                                                  onDelete: () {
                                                    context
                                                        .read<MembersCubit>()
                                                        .removeAccountMember(
                                                          userId:
                                                              member.usersId!,
                                                        );
                                                    Navigator.of(context).pop();
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddUserDialog(
          localizations: localizations,
          onAddUser: (userData) {
            context.read<MembersCubit>().createNewAccountMember(
              name: userData['name']!,
              email: userData['email']!,
              phone: userData['phone']!,
              birthDate: userData['birthDate']!,
              gender: userData['gender']!,
              password: userData['password']!,
              usersType: userData['usersType']!,
            );
          },
        );
      },
    );
  }

  void _showEditRoleDialog(BuildContext context, UsersDataModel member) {
    showDialog(
      context: context,
      builder: (context) {
        return EditRoleDialog(
          member: member,
          localizations: localizations,
          onSave: (newRole) {
            context.read<MembersCubit>().editRole(
              userId: member.usersId!,
              newRole: newRole.toString(),
            );
          },
        );
      },
    );
  }
}
