// models.dart
import 'package:cloud_firestore/cloud_firestore.dart';

// Message model representing a single chat message
class MessageModel {
  final String messageId;
  final String senderId;
  final String text;
  final Timestamp timestamp;
  final bool isRead;

  MessageModel({
    required this.messageId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isRead = false,
  });

  factory MessageModel.fromMap(String id, Map<String, dynamic> data) {
    return MessageModel(
      messageId: id,
      senderId: data['senderId'] as String? ?? '',
      text: data['text'] as String? ?? '',
      timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
      isRead: data['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'text': text,
        'timestamp': timestamp,
        'isRead': isRead,
      };
}

// Chat model representing a conversation between users
class ChatModel {
  final String chatId;
  final List<String> participants;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final Map<String, Map<String, dynamic>> participantsInfo;
  final bool isRead;
  final String lastSenderId;
  final Map<String, Timestamp> lastReadTime;

  ChatModel({
    required this.chatId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participantsInfo,
    required this.isRead,
    required this.lastSenderId,
    required this.lastReadTime,
  });

  factory ChatModel.fromMap(String id, Map<String, dynamic> data) {
    final rawInfo = data['participantsInfo'] as Map<String, dynamic>? ?? {};
    final parsedInfo = rawInfo.map((key, value) => MapEntry(
        key, Map<String, dynamic>.from(value as Map<String, dynamic>)));
    final rawRead = data['lastReadTime'] as Map<String, dynamic>? ?? {};
    final parsedRead = rawRead.map(
        (key, value) => MapEntry(key, value as Timestamp));

    return ChatModel(
      chatId: id,
      participants:
          List<String>.from(data['participants'] as List<dynamic>? ?? []),
      lastMessage: data['lastMessage'] as String? ?? '',
      lastMessageTime:
          data['lastMessageTime'] as Timestamp? ?? Timestamp.now(),
      participantsInfo: parsedInfo,
      isRead: data['isRead'] as bool? ?? true,
      lastSenderId: data['lastSenderId'] as String? ?? '',
      lastReadTime: parsedRead,
    );
  }

  Map<String, dynamic> toMap() => {
        'participants': participants,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime,
        'participantsInfo': participantsInfo,
        'isRead': isRead,
        'lastSenderId': lastSenderId,
        'lastReadTime': lastReadTime,
      };
}
