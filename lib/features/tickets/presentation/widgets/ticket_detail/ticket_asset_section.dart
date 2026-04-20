import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/utils/color_resolver.dart';
import 'package:itam_app/core/utils/icon_resolver.dart';
import 'package:itam_app/features/assets/presentation/providers/asset_detail_provider.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';

class TicketAssetSection extends ConsumerWidget {
  final TicketAsset? asset;

  const TicketAssetSection({super.key, required this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assetColor = ColorResolver.resolve(asset!.colorKey ?? 'blue');
    final iconData = IconResolver.resolve(asset!.iconKey ?? 'laptop');
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Text(
              'MATÉRIEL CONCERNÉ',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          if (asset == null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Aucun matériel associé',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            )
          else
            GestureDetector(
              onTap: () {
                ref.invalidate(assetDetailProvider(asset!.id.toString()));
                context.push('/assets/${asset!.id}?fromTicket=true');
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: assetColor.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: assetColor),
                      ),
                      child: Icon(iconData, color: Colors.white, size: 27),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            asset!.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            [asset!.brand, asset!.model]
                                .where((e) => e != null)
                                .join(' · '),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}