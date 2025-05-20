// message_cubit.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenat_admin_web/features/chats/data/MessageModel.dart';
import 'package:zenat_admin_web/features/chats/logic/chats/chats_cubit.dart';
import 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _messageSubscription;

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }

  void fetchMessages(String chatId) {
    emit(MessageLoading());
    _messageSubscription?.cancel();
    _messageSubscription = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            final msgs =
                snapshot.docs
                    .map((doc) => MessageModel.fromMap(doc.id, doc.data()))
                    .toList();
            emit(MessageLoaded(msgs));
          },
          onError: (e) {
            emit(MessageError(e.toString()));
          },
        );
  }



  Future<void> markMessagesAsRead(String chatId, String currentUserId) async {
    try {
      final snapshots =
          await _firestore
              .collection('chats')
              .doc(chatId)
              .collection('messages')
              .where('senderId', isNotEqualTo: currentUserId)
              .where('isRead', isEqualTo: false)
              .get();
      final batch = _firestore.batch();
      for (var doc in snapshots.docs) {
        batch.update(doc.reference, {'isRead': true});
      }
      batch.update(_firestore.collection('chats').doc(chatId), {
        'isRead': true,
      });
      await batch.commit();
    } catch (e) {
      emit(MessageError(e.toString()));
    }
  }
}
