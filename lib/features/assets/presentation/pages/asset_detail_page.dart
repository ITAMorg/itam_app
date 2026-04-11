import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/widgets/detail_top_bar.dart';
import 'package:itam_app/features/assets/presentation/providers/asset_detail_provider.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

class AssetDetailPage extends ConsumerWidget {
  final String assetId;

  const AssetDetailPage({super.key, required this.assetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetAsync = ref.watch(assetDetailProvider(assetId));
    final authState = ref.watch(authNotifierProvider);
    final isAdmin = authState.user?.role == 'ADMIN';

    return Scaffold(
      appBar: DetailTopBar(
        title: 'Fiche matériel',
        onEdit: isAdmin ? () {
          // TODO: navigation vers page édition
        } : null,
        onDelete: isAdmin ? () {
          // TODO: dialog confirmation suppression
        } : null,
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
              // TODO: AssetHeaderCard(asset: asset)
              // TODO: AssetInfoSection(asset: asset)
              // TODO: AssetAffectationSection(asset: asset)
              // TODO: AssetHistorySection() ← placeholder désactivé
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}