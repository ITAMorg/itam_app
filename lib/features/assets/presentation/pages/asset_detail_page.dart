import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/core/widgets/action_button.dart';
import 'package:itam_app/features/assets/presentation/providers/asset_detail_provider.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_header_card.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_info_section.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_affectation_section.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_history_section.dart';

class AssetDetailPage extends ConsumerWidget {
  final String assetId;

  const AssetDetailPage({super.key, required this.assetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetAsync = ref.watch(assetDetailProvider(assetId));
    final authState = ref.watch(authNotifierProvider);
    final isAdmin = authState.user?.role == 'ADMIN';
    final canEdit = isAdmin || authState.user?.role == 'TECHNICIAN';

    return Scaffold(
      extendBody: true,
      appBar: DetailTopBar(
        title: 'Fiche matériel',
        onEdit: isAdmin ? () {
          // TODO: navigation vers page édition
        } : null,
        onDelete: isAdmin ? () {
          // TODO: dialog confirmation suppression
        } : null,
      ),
      bottomNavigationBar: ColoredBox(
        color: Colors.transparent,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: ActionButton(
              label: 'Signaler un incident',
              color: Colors.red,
              icon: Icons.warning_amber_rounded,
              onPressed: () => context.push('/tickets/create?assetId=$assetId'),
            ),
          ),
        ),
      ),
      body: assetAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Erreur : $e'),
        ),
        data: (asset) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetHeaderCard(asset: asset),
              const SizedBox(height: 12),
              AssetInfoSection(asset: asset),
              const SizedBox(height: 12),
              AssetAffectationSection(
                asset: asset,
                canEdit: canEdit,
              ),
              const SizedBox(height: 12),
              AssetHistorySection(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}