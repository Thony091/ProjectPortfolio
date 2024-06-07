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
        _ImageViewer( 
          title: message.name,
          recivedMessage: message.message,
          email: message.email,
          onTapdResponse: onTapdResponse,
          onTapDelete: onTapDelete,
        ),
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {
  
  final String title;
  final String email;
  final String recivedMessage;
  final Function()? onTapdResponse;
  final Function()? onTapDelete;

  const _ImageViewer({
    this.title = '', 
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
        child: Container(width: size.width * 0.93,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: Offset(0, 3)
              ),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            
                Image.asset('assets/images/no-image.jpg', 
                  fit: BoxFit.cover,
                  height: 110,
                  width: size.width * 0.23,
                ),
                Container(
                  width: size.width * 0.50,
                  padding: const EdgeInsets.only( left: 5, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox( height: 10 ),
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
