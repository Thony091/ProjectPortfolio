
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final messageProvider = StateNotifierProvider.autoDispose<MessageNotifier, MessageState>((ref) {

  final messageRepository = MessageRepositoryImpl();

  return MessageNotifier(
    messageRepository: messageRepository
  );
});


class MessageNotifier extends StateNotifier<MessageState>{

  final MessageRepository messageRepository;

  MessageNotifier({
    required this.messageRepository
  }): super(MessageState()){
    getMessages();
  }

  Future<void> postMessage(String name, String email, String message) async{

    try {

      final messsage = await messageRepository.createUpdateMessage(name, email, message);

      state = state.copyWith(
        message: messsage
      );

    } on CustomError catch(e){
      state = state.copyWith(
        errorMessage: e.message
      );
    }
  }

    Future<void> getMessages() async {
    
    state = state.copyWith(isLoading: true);

    try {
      
      final messages = await messageRepository.getMessagesByPage();
      
      state = state.copyWith(
        messages: messages,
        isLoading: false
      );

    } catch (e) {
      
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error al obtener los servicios'
      );

    }
  }

}

class MessageState{

  final bool isLoading;
  final Message? message;
  final List<Message> messages;
  final String errorMessage;

  MessageState({
    this.messages = const [],
    this.isLoading = false,
    this.message,
    this.errorMessage = ''
  });

  MessageState copyWith({
    List<Message>? messages,
    bool? isLoading,
    Message? message,
    String? errorMessage
  }) => MessageState(
    messages: messages ?? this.messages,
    isLoading: isLoading ?? this.isLoading,
    message: message ?? this.message,
    errorMessage: errorMessage ?? this.errorMessage
  );

}