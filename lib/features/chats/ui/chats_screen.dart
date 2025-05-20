import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenat_admin_web/features/chats/data/MessageModel.dart';
import 'package:zenat_admin_web/features/chats/logic/chats/chats_cubit.dart';
import 'package:zenat_admin_web/features/chats/logic/message_cubit.dart';
import 'package:zenat_admin_web/features/chats/logic/message_state.dart';
import 'package:intl/intl.dart'; // إضافة لتنسيق التاريخ
import 'package:zenat_admin_web/generated/l10n.dart'; // Import localization

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChatsCubit()..fetchChats()),
        BlocProvider(create: (_) => MessageCubit()),
      ],
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 700) {
              return BlocBuilder<ChatsCubit, ChatsState>(
                builder: (context, state) {
                  if (state is ChatsLoaded && state.selectedChat != null) {
                    return WhatsappChatDetailView(chat: state.selectedChat!);
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        // رأس قائمة المحادثات
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 16,
                          ),
                          color: const Color(0xFFFA7C1F), // لون واتس ويب
                          child: Row(
                            children: [
                              Text(
                                localizations.chatsTitle,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // Spacer(),
                              // Icon(Icons.search, color: Colors.white),
                              // SizedBox(width: 20),
                              // Icon(Icons.more_vert, color: Colors.white),
                            ],
                          ),
                        ),

                        // حقل البحث عن المحادثات
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          color: Colors.grey.shade100,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: localizations.searchHint,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<ChatsCubit, ChatsState>(
                            builder: (context, state) {
                              if (state is ChatsLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFA7C1F),
                                  ),
                                );
                              }
                              if (state is ChatsLoaded) {
                                final filteredChats =
                                    state.chats.where((chat) {
                                      final chatTitle =
                                          _getChatTitle(chat).toLowerCase();
                                      return chatTitle.contains(_searchQuery);
                                    }).toList();

                                return ListView.separated(
                                  itemCount: filteredChats.length,
                                  separatorBuilder:
                                      (context, index) => Divider(
                                        height: 1,
                                        indent: 72,
                                        color: Colors.grey.shade300,
                                      ),
                                  itemBuilder: (ctx, i) {
                                    final chat = filteredChats[i];
                                    final isSelected =
                                        state.selectedChat != null &&
                                        state.selectedChat!.chatId ==
                                            chat.chatId;

                                    return ListTile(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 5,
                                      ),
                                      leading: CircleAvatar(
                                        radius: 28,
                                        backgroundColor: Color(0xFFFA7C1F),
                                        child: Icon(
                                          Icons.group,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                      title: Text(
                                        _getChatTitle(chat),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      subtitle: Text(
                                        chat.lastMessage,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            DateFormat(
                                              isToday(
                                                    chat.lastMessageTime
                                                        .toDate(),
                                                  )
                                                  ? 'HH:mm'
                                                  : 'dd/MM/yyyy',
                                            ).format(
                                              chat.lastMessageTime.toDate(),
                                            ),
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          // يمكن إضافة علامة عدد الرسائل غير المقروءة هنا
                                        ],
                                      ),
                                      tileColor:
                                          isSelected
                                              ? Color(0xFFE8F1F3)
                                              : null, // Highlight selected chat
                                      shape:
                                          isSelected
                                              ? RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Color(0xFFFA7C1F),
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              )
                                              : null,
                                      onTap: () {
                                        context.read<ChatsCubit>().selectChat(
                                          chat,
                                        );
                                        context
                                            .read<MessageCubit>()
                                            .fetchMessages(chat.chatId);
                                      },
                                    );
                                  },
                                );
                              }
                              if (state is ChatsError) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        state.message,
                                        style: TextStyle(color: Colors.red),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.grey,
                                      size: 48,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      localizations.noChats,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Row(
              children: [
                // قائمة المحادثات (مع إضافة شريط تمرير)
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Column(
                    children: [
                      // رأس قائمة المحادثات
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 16,
                        ),
                        color: const Color(0xFFFA7C1F), // لون واتس ويب
                        child: Row(
                          children: [
                            Text(
                              localizations.chatsTitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Spacer(),
                            // Icon(Icons.search, color: Colors.white),
                            // SizedBox(width: 20),
                            // Icon(Icons.more_vert, color: Colors.white),
                          ],
                        ),
                      ),

                      // حقل البحث عن المحادثات
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Colors.grey.shade100,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: localizations.searchHint,
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),

                      // قائمة المحادثات مع شريط تمرير
                      Expanded(
                        child: BlocBuilder<ChatsCubit, ChatsState>(
                          builder: (context, state) {
                            if (state is ChatsLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFFA7C1F),
                                ),
                              );
                            }
                            if (state is ChatsLoaded) {
                              final filteredChats =
                                  state.chats.where((chat) {
                                    final chatTitle =
                                        _getChatTitle(chat).toLowerCase();
                                    return chatTitle.contains(_searchQuery);
                                  }).toList();

                              return ListView.separated(
                                itemCount: filteredChats.length,
                                separatorBuilder:
                                    (context, index) => Divider(
                                      height: 1,
                                      indent: 72,
                                      color: Colors.grey.shade300,
                                    ),
                                itemBuilder: (ctx, i) {
                                  final chat = filteredChats[i];
                                  String chatTitle = _getChatTitle(chat);

                                  // تحديد إذا كانت هذه المحادثة هي المحادثة المختارة
                                  final isSelected =
                                      state.selectedChat != null &&
                                      state.selectedChat!.chatId == chat.chatId;

                                  // تاريخ آخر رسالة
                                  final lastMsgDate =
                                      chat.lastMessageTime.toDate();
                                  String timeStr;

                                  if (isToday(lastMsgDate)) {
                                    // إذا كانت اليوم، عرض الوقت فقط
                                    timeStr = DateFormat(
                                      'HH:mm',
                                    ).format(lastMsgDate);
                                  } else {
                                    // إذا كانت قبل اليوم، عرض التاريخ
                                    timeStr = DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(lastMsgDate);
                                  }

                                  return ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 5,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: Color(0xFFFA7C1F),
                                      child: Icon(
                                        Icons.group,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                    ),
                                    title: Text(
                                      chatTitle,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      chat.lastMessage,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          timeStr,
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        // يمكن إضافة علامة عدد الرسائل غير المقروءة هنا
                                      ],
                                    ),
                                    tileColor:
                                        isSelected
                                            ? Color(0xFFE8F1F3)
                                            : null, // Highlight selected chat
                                    shape:
                                        isSelected
                                            ? RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Color(0xFFFA7C1F),
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            )
                                            : null,
                                    onTap: () {
                                      context.read<ChatsCubit>().selectChat(
                                        chat,
                                      );
                                      context
                                          .read<MessageCubit>()
                                          .fetchMessages(chat.chatId);
                                    },
                                  );
                                },
                              );
                            }
                            if (state is ChatsError) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 48,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      state.message,
                                      style: TextStyle(color: Colors.red),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.grey,
                                    size: 48,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    localizations.noChats,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // مساحة عرض المحادثة (مع شريط تمرير)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // خلفية صورة واتس ويب المميزة
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://web.whatsapp.com/img/bg-chat-tile-light_a4be8e61601d61f6815cfbe8bd526a0a.png',
                        ),
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                    child: BlocBuilder<ChatsCubit, ChatsState>(
                      builder: (context, state) {
                        if (state is ChatsLoaded &&
                            state.selectedChat != null) {
                          return WhatsappChatDetailView(
                            chat: state.selectedChat!,
                          );
                        }
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200,
                                ),
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  size: 64,
                                  color: Color(0xFFFA7C1F),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                localizations.selectChat,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                localizations.viewMessages,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // دالة لإنشاء عنوان المحادثة من اسماء المشاركين
  String _getChatTitle(ChatModel chat) {
    List<String> participantNames = [];

    for (var participantId in chat.participants) {
      final info = chat.participantsInfo[participantId];
      if (info != null && info['name'] != null) {
        participantNames.add(info['name']);
      } else {
        participantNames.add('User');
      }
    }

    return participantNames.join(' & ');
  }

  // التحقق مما إذا كان التاريخ هو اليوم
  bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }
}

class WhatsappChatDetailView extends StatelessWidget {
  final ChatModel chat;

  const WhatsappChatDetailView({super.key, required this.chat});

  // دالة لإنشاء عنوان المحادثة من اسماء المشاركين
  String _getChatTitle(ChatModel chat) {
    List<String> participantNames = [];

    for (var participantId in chat.participants) {
      final info = chat.participantsInfo[participantId];
      if (info != null && info['name'] != null) {
        participantNames.add(info['name']);
      } else {
        participantNames.add('User');
      }
    }

    return participantNames.join(' & ');
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Column(
      children: [
        // Header (user details) - WhatsApp Web style
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: const Color(0xFFFA7C1F),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.group, color: Colors.grey.shade800),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getChatTitle(chat),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      localizations.lastSeenTodayAt("10:30 AM"),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.search, color: Colors.white),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: Icon(Icons.more_vert, color: Colors.white),
              //   onPressed: () {},
              // ),
            ],
          ),
        ),

        // جسم الرسائل (مع شريط تمرير)
        Expanded(
          child: BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              if (state is MessageLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Color(0xFFFA7C1F)),
                );
              }
              if (state is MessageLoaded) {
                // نحدد المرسل الأصلي للمحادثة
                final firstParticipant = chat.participants.first;

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  itemCount: state.messages.length,
                  reverse: true,
                  itemBuilder: (ctx, i) {
                    final msg = state.messages[i];
                    final senderInfo = chat.participantsInfo[msg.senderId];
                    final senderName = senderInfo?['name'] ?? 'مستخدم';

                    // نحدد اتجاه الرسالة
                    final isOriginalSender = msg.senderId == firstParticipant;

                    // تنسيق وقت الرسالة
                    final msgTime = DateFormat(
                      'HH:mm',
                    ).format(msg.timestamp.toDate());

                    // تجميع الرسائل المتتالية من نفس المرسل
                    final bool showSender =
                        i == state.messages.length - 1 ||
                        state.messages[i + 1].senderId != msg.senderId;

                    return Column(
                      children: [
                        // عرض خط تاريخي للفصل بين الأيام (يمكن تنفيذه بشكل أكثر دقة)
                        if (i == state.messages.length - 1 ||
                            !isSameDay(
                              msg.timestamp.toDate(),
                              state.messages[i + 1].timestamp.toDate(),
                            ))
                          _buildDateSeparator(msg.timestamp.toDate(),context),

                        Align(
                          alignment:
                              isOriginalSender
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment:
                                isOriginalSender
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              // عرض اسم المرسل فقط عند تغيير المرسل
                              if (showSender)
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                    right: isOriginalSender ? 8 : 0,
                                    left: isOriginalSender ? 0 : 8,
                                  ),
                                  child: Text(
                                    senderName,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          isOriginalSender
                                              ? Color(0xFFFA7C1F)
                                              : Colors.blue.shade800,
                                    ),
                                  ),
                                ),

                              // فقاعة الرسالة
                              Container(
                                margin: EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                  right: isOriginalSender ? 0 : 30,
                                  left: isOriginalSender ? 30 : 0,
                                ),
                                padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                                decoration: BoxDecoration(
                                  color:
                                      isOriginalSender
                                          ? Color(0xFFDCF8C6)
                                          : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      offset: Offset(0, 1),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      msg.text,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(height: 3),
                                    // توقيت الرسالة
                                    Text(
                                      msgTime,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              if (state is MessageError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      SizedBox(height: 16),
                      Text(
                        state.error,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message, color: Colors.grey, size: 48),
                    SizedBox(height: 16),
                    Text(
                      localizations.noMessages,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // فاصل لعرض التاريخ بين المحادثات من أيام مختلفة
  Widget _buildDateSeparator(DateTime date, BuildContext context) {
    String dateStr = _formatDateForSeparator(date, context);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey.shade400)),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFE1F3FB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              dateStr,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey.shade400)),
        ],
      ),
    );
  }

  // تنسيق التاريخ للفاصل
  String _formatDateForSeparator(DateTime date,BuildContext context) {
    final localizations = S.of(context); // Access localization
    final now = DateTime.now();

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return localizations.today; // Use localization for "Today"
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return localizations.yesterday; // Use localization for "Yesterday"
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  // التحقق من أن التاريخين في نفس اليوم
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
