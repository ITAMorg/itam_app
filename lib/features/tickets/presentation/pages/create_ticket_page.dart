import 'package:flutter/material.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';

class CreateTicketPage extends StatelessWidget {
  final int? assetId;

  const CreateTicketPage({super.key, this.assetId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailTopBar(title: 'Nouveau ticket'),
      body: const SizedBox.shrink(),
    );
  }
}