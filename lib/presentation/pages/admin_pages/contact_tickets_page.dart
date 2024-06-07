import 'package:flutter/material.dart';

class ContactTicketsPage extends StatelessWidget {

  static const name = 'ContactTickets';
  
  const ContactTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        title: const Text('Tickets de Contacto'),
      ),
      body: const Text('Tickets de Contacto')
    );
  }
}