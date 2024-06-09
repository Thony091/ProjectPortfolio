import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portafolio_project/presentation/presentation_container.dart';

import '../../../config/config.dart';
import 'compornents/card_messages.dart';

class MessagesPage extends StatelessWidget {

  static const name = 'MessagePage';
  
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {

    final color = AppTheme().getTheme().colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primary,
        title: const Text('Mensajes de Contacto'),
        
      ),
      body: const BackgroundImageWidget(
        opacity: 0.1, 
        child: 
        _MessageAdminPage(),
      ),
    );
  }
}

class _MessageAdminPage extends ConsumerStatefulWidget {
  const _MessageAdminPage();

  @override
  _MessageAdminPageState createState() => _MessageAdminPageState();
}

class _MessageAdminPageState extends ConsumerState {
  @override
  Widget build(BuildContext context) {

    final messageState = ref.watch( messagesProvider );
    
    return Padding(
      padding: const EdgeInsets.only( left: 20, top: 10),
      child:  ListView.builder(
        itemCount: messageState.messages.length,
        itemBuilder: ( context, index) {
          final message = messageState.messages[index];
          return Column(
            children:
              [
                MessageCard(
                  message: message,
                  onTapdResponse: () => context.push('/message-response/${message.id}'),
                  onTapDelete: () {
                    showDialog(
                      context: context, 
                      builder: (context){
                        return PopUpPreguntaWidget(
                          pregunta: '¿Estas seguro de eliminar el mensaje?', 
                          // confirmar: () {},
                          confirmar: () => ref.read(messagesProvider.notifier).deleteMessage(message.id).then((value) => context.pop()), 
                          cancelar: () => context.pop()
                        );
                      }
                    );
                  } 
                ),
                const SizedBox(height: 10),
              ] 
          );
        },
        
      ),
    );
  }
}