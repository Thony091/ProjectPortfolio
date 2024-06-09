import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mailto/mailto.dart';
import 'package:portafolio_project/domain/domain.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../config/config.dart';
import '../../presentation_container.dart';
import '../../shared/widgets/custom_product_field.dart';

class MessageResponsePage extends ConsumerWidget {

  final String messageId;
  static const name = 'MessageResponsePage';
  
  const MessageResponsePage({super.key, required this.messageId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final color = AppTheme().getTheme().colorScheme;
    final messageState = ref.watch( messageProvider( messageId ) );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primary,
        title: const Text('Responder Mensaje'),
        
      ),
      body: messageState.isLoading 
        ? const Center(child: CircularProgressIndicator())
        :  BackgroundImageWidget(
            opacity: 0.1, 
            child: _MessageBodyResponsePage( message: messageState.message! )
          ),
    );
  }
}

class _MessageBodyResponsePage extends ConsumerWidget {

  final Message message;
  
  const _MessageBodyResponsePage({ required this.message, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView(
      children: [

        const SizedBox(height: 20),

        _MessageResponseInfo( message: message ),
        
      ],
    );
  }
}

class _MessageResponseInfo extends ConsumerWidget {

  final Message message;
  const _MessageResponseInfo({ required this.message });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final messageForm = ref.watch( messageFormProvider.notifier );
    final stateMessage = ref.watch( messageFormProvider );

    void sendReplyEmail() async {
      final email = message.email;
      final response = stateMessage.reply.value;

      if (email.isEmpty || response.isEmpty) {
        print('Email or response is empty');
        return;
      }

      final mailtoLink = Mailto(
        to: [email],
        subject: 'Respuesta a tu mensaje',
        body: response,
      );

      final uri = Uri.parse(mailtoLink.toString());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        print('Email launched!');
        context.pop();
      } else {
        throw 'Could not launch $uri';
      }
    }

  // void sendEmail() async {
  //   // Configura el cliente SMTP
  //   final smtpServer = gmail("tony.0091","Lucian.091"); // Usa Gmail como ejemplo

  //   // Define el mensaje
  //   final message = mailer.Message()
  //   ..from = const mailer.Address("soporte@detailing.com", 'Tu Aplicación')
  //   ..recipients.add(stateMessage.email.toString()) // 'to' es la dirección de correo electrónico del destinatario
  //   ..subject = 'Respuesta a tu mensaje'
  //   ..text = stateMessage.reply.toString();

  //   try {
  //     final sendReport = await mailer.send(message, smtpServer);
  //     print('Mensaje enviado: $sendReport');
  //   } on mailer.MailerException catch (e) {
  //     print('Error al enviar el correo: ${e.message}');
  //   }
  // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Detalles del Mensaje', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15 ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2)
                )
              ]
            ),
            child: Column(
              children: [
                CustomProductField(
                  color: Colors.blueGrey.shade50,
                  readOnly: true,
                  isTopField: true,
                  label: 'Nombre',
                  initialValue: message.name,
                ),
                CustomProductField( 
                  color: Colors.blueGrey.shade50,
                  readOnly: true,
                  isBottomField: false,
                  label: 'Email',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  initialValue: message.email,
                ),
                CustomProductField( 
                  color: Colors.blueGrey.shade50,
                  readOnly: true,
                  isBottomField: true,
                  maxLines: 6,
                  label: 'Mensaje',
                  keyboardType: TextInputType.multiline,
                  initialValue: message.message,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30 ),
          CustomProductField(
            maxLines: 6,
            label: 'Mensaje de Respuesta',
            keyboardType: TextInputType.multiline,
            // initialValue: 'Responder Mensaje' ,
            onChanged:  messageForm.onResponseChange,
            hint: 'Respuesta al mensaje',
          ),
          const SizedBox(height: 20 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => sendReplyEmail(),
                child: const Text('Enviar Mensaje'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}