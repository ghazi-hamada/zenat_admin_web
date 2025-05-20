
// تعديل ملف chats_cubit.dart
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/features/chats/data/MessageModel.dart';
 
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  StreamSubscription? _subscription;
  List<ChatModel> _chats = []; // تخزين المحادثات

  void fetchChats() {
    emit(ChatsLoading());
    _subscription?.cancel();
    _subscription = _firestore
        .collection('chats')
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .listen((snapshot) {
      _chats = snapshot.docs.map((d) => ChatModel.fromMap(d.id, d.data())).toList();
      emit(ChatsLoaded(_chats));
    }, onError: (e) {
      emit(ChatsError(e.toString()));
    });
  }

  void selectChat(ChatModel chat) {
    // الآن نحتفظ بالمحادثات وندمج معها المحادثة المختارة
    emit(ChatsLoaded(_chats, selectedChat: chat));
  }

  @override
  Future<void> close() { 
    _subscription?.cancel(); 
    return super.close(); 
  }
}