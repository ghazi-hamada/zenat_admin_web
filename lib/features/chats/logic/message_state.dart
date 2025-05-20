
// message_state.dart
import 'package:meta/meta.dart';
import 'package:zenat_admin_web/features/chats/data/MessageModel.dart';
 
@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}
class MessageLoading extends MessageState {}
class MessageLoaded extends MessageState { final List<MessageModel> messages; MessageLoaded(this.messages); }
class MessageError extends MessageState { final String error; MessageError(this.error); }
class MessageShowSubscriptionDialog extends MessageState {}
