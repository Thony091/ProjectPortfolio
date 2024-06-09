import 'package:flutter/material.dart';

import '../../../../domain/domain.dart' show Message;
import '../../../shared/shared.dart';

class MessageCard extends StatelessWidget {

  final Message message;
  final Function()? onTapdResponse;
  final Function()? onTapDelete;

  const MessageCard({
    super.key,
    required this.message,
    this.onTapdResponse,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CardViewer( 
          name: message.name,
          email: message.email,
          recivedMessage: message.message,
          onTapdResponse: onTapdResponse,
          onTapDelete: onTapDelete,
        ),
      ],
    );
  }
}

class _CardViewer extends StatelessWidget {
  
  final String name;
  final String email;
  final String recivedMessage;
  final Function()? onTapdResponse;
  final Function()? onTapDelete;

  const _CardViewer({
    this.name = '', 
    this.recivedMessage = '',
    this.onTapdResponse,
    this.onTapDelete, 
    this.email = '',
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
  
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: size.width * 0.93,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 247, 207, 207),
                blurRadius: 5,
                offset: Offset(0, 3)
              ),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 7, left: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.60,
                  padding: const EdgeInsets.only( left: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            
                      Text(
                        'Remitente : $name\nCorreo       : $email',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox( height: 10 ),
                      const Text(
                        'Mensaje Enviado:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        maxLines: 4,
                        recivedMessage,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox( height: 10 ),

                    ],
                  ),
                ),

                Row( children:
                  [
                    const SizedBox( width: 10 ),
                    CustomIconButton(
                      onTap: onTapdResponse ?? () {},
                      icon: Icons.mail_outline_outlined,
                      size: 22,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox( width: 10 ),
                    CustomIconButton(
                      onTap: onTapDelete ?? () {}, 
                      icon: Icons.delete,
                      size: 22,
                      color: Colors.redAccent,
                    ),
                  ]
                ),

              ],
            ),
          ),
        ),
      );
    }



  }
