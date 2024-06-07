import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../shared/shared.dart';

class MessageResponsePage extends StatelessWidget {

  final String messageId;
  static const name = 'MessageResponsePage';
  
  const MessageResponsePage({super.key, required this.messageId});

  @override
  Widget build(BuildContext context) {

    final color = AppTheme().getTheme().colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.primary,
        title: const Text('Responder Mensaje'),
        
      ),
      body: const BackgroundImageWidget(
        opacity: 0.1, 
        child: Placeholder()
        // _MessageResponsePage(),
      ),
    );
  }
}