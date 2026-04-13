// lib/features/tickets/presentation/pages/ticket_detail_page.dart

import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  final int ticketId;

  const TicketDetailPage({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiche ticket'),
      ),
      body: Center(child: Text('Ticket $ticketId')),
    );
  }
}