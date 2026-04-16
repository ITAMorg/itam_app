import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';
import 'package:itam_app/features/assets/presentation/providers/assets_provider.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_card.dart';
import 'package:itam_app/features/assets/presentation/widgets/asset_filter_sheet.dart';
import 'package:itam_app/features/auth/presentation/providers/auth_provider.dart';

class AssetListPage extends ConsumerStatefulWidget {
  const AssetListPage({super.key});

  @override
  ConsumerState<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends ConsumerState<AssetListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  AssetStatus? _selectedStatus;
  String? _selectedType;
  int? _selectedLocationId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
      _selectedStatus != null ||
      _selectedType != null ||
      _selectedLocationId != null;

  Future<void> _openFilterSheet(
      List<Asset> assets, bool isUser) async {
    final types = assets.map((a) => a.assetType.name).toSet().toList()..sort();
    final locations = assets
        .where((a) => a.location != null)
        .map((a) => a.location!)
        .fold<Map<int, String>>({}, (map, loc) => map..[loc.id] = loc.name);

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AssetFilterSheet(
        availableTypes: types,
        availableLocations: locations,
        showLocations: !isUser,
        initialStatus: _selectedStatus,
        initialType: _selectedType,
        initialLocationId: _selectedLocationId,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedStatus = result['status'] as AssetStatus?;
        _selectedType = result['type'] as String?;
        _selectedLocationId = result['locationId'] as int?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final assetsAsync = ref.watch(assetsProvider);
    final authState = ref.watch(authNotifierProvider);
    final isUser = authState.user?.role == 'USER';
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final horizontalPadding = isDesktop ? 32.0 : 16.0;
    final statusColors = Theme.of(context)
        .extension<AssetStatusThemeExtension>()!
        .statusColors;

    return Column(
      children: [
        // Barre de recherche
        Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, 16, horizontalPadding, 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) =>
                      setState(() => _searchQuery = value.toLowerCase()),
                  decoration: const InputDecoration(
                    hintText: 'Recherche...',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => assetsAsync.whenData((assets) =>
                    _openFilterSheet(assets, isUser)),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _hasActiveFilters
                        ? AppColors.primary.withValues(alpha: 0.2)
                        : AppColors.surface,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: _hasActiveFilters
                          ? AppColors.primary
                          : AppColors.border.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Icon(
                    Icons.tune_rounded,
                    color: _hasActiveFilters
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Chips filtres actifs uniquement
        if (_hasActiveFilters)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(
                horizontalPadding, 0, horizontalPadding, 8),
            child: Row(
              children: [
                if (_selectedStatus != null)
                  _ActiveFilterChip(
                    label: _statusLabel(_selectedStatus!, statusColors),
                    color: _statusColor(_selectedStatus!, statusColors),
                    onRemove: () =>
                        setState(() => _selectedStatus = null),
                  ),
                if (_selectedType != null) ...[
                  if (_selectedStatus != null) const SizedBox(width: 8),
                  _ActiveFilterChip(
                    label: _selectedType!,
                    color: AppColors.primary,
                    onRemove: () => setState(() => _selectedType = null),
                  ),
                ],
                if (_selectedLocationId != null) ...[
                  if (_selectedStatus != null || _selectedType != null)
                    const SizedBox(width: 8),
                  _ActiveFilterChip(
                    label: assetsAsync.maybeWhen(
                      data: (assets) => assets
                              .firstWhere(
                                (a) => a.location?.id == _selectedLocationId,
                                orElse: () => assets.first,
                              )
                              .location
                              ?.name ??
                          '',
                      orElse: () => '',
                    ),
                    color: AppColors.textSecondary,
                    onRemove: () =>
                        setState(() => _selectedLocationId = null),
                  ),
                ],
              ],
            ),
          ),

        // Liste
        Expanded(
          child: assetsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(
              child: Text('Erreur : $e',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            data: (assets) {
              final filtered = assets.where((a) {
                final matchesSearch =
                    a.name.toLowerCase().contains(_searchQuery) ||
                        (a.location?.name ?? '')
                            .toLowerCase()
                            .contains(_searchQuery) ||
                        a.assetType.name.toLowerCase().contains(_searchQuery);
                final matchesStatus =
                    _selectedStatus == null || a.status == _selectedStatus;
                final matchesType =
                    _selectedType == null || a.assetType.name == _selectedType;
                final matchesLocation = _selectedLocationId == null ||
                    a.location?.id == _selectedLocationId;

                return matchesSearch &&
                    matchesStatus &&
                    matchesType &&
                    matchesLocation;
              }).toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Text('Aucun asset trouvé',
                      style: Theme.of(context).textTheme.bodyMedium),
                );
              }

              return RefreshIndicator(
                onRefresh: () => ref.read(assetsProvider.notifier).refresh(),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding, vertical: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) =>
                      AssetCard(asset: filtered[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _statusLabel(AssetStatus status, AssetStatusColors colors) =>
      switch (status) {
        AssetStatus.inService => 'En service',
        AssetStatus.broken => 'En panne',
        AssetStatus.maintenance => 'Maintenance',
        AssetStatus.inStock => 'En stock',
      };

  Color _statusColor(AssetStatus status, AssetStatusColors colors) =>
      switch (status) {
        AssetStatus.inService => colors.inService,
        AssetStatus.broken => colors.broken,
        AssetStatus.maintenance => colors.maintenance,
        AssetStatus.inStock => colors.inStock,
      };
}

class _ActiveFilterChip extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onRemove;

  const _ActiveFilterChip({
    required this.label,
    required this.color,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.close_rounded, color: color, size: 14),
          ],
        ),
      ),
    );
  }
}