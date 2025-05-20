// تعديل ملف chats_state.dart
part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}
class ChatsLoading extends ChatsState {}
class ChatsLoaded extends ChatsState { 
  final List<ChatModel> chats;
  final ChatModel? selectedChat; // محادثة مختارة اختيارية
  
  ChatsLoaded(this.chats, {this.selectedChat});
}
class ChatsError extends ChatsState { 
  final String message; 
  ChatsError(this.message); 
}