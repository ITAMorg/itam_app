import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/widgets/search_filter_bar.dart';
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

  double get _headerHeight => _hasActiveFilters ? 100 : 64;

  Future<void> _openFilterSheet(List<Asset> assets, bool isUser) async {
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

    return Stack(
      children: [
        // Liste qui prend tout l'espace
        assetsAsync.when(
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

            return RefreshIndicator(
              onRefresh: () => ref.read(assetsProvider.notifier).refresh(),
              child: filtered.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          _headerHeight + 8,
                          horizontalPadding,
                          8),
                      children: [
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.3),
                        Center(
                          child: Text(
                            'Aucun asset trouvé',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          _headerHeight + 8,
                          horizontalPadding,
                          8),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) =>
                          AssetCard(asset: filtered[index]),
                    ),
            );
          },
        ),

        // Header flottant avec gradient
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding:
                EdgeInsets.fromLTRB(horizontalPadding, 12, horizontalPadding, 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.background,
                  AppColors.background,
                  AppColors.background.withValues(alpha: 0),
                ],
                stops: const [0.0, 0.75, 1.0],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchFilterBar(
                  controller: _searchController,
                  onChanged: (value) =>
                      setState(() => _searchQuery = value.toLowerCase()),
                  onFilterTap: () => assetsAsync.whenData(
                      (assets) => _openFilterSheet(assets, isUser)),
                  hasActiveFilters: _hasActiveFilters,
                ),
                if (_hasActiveFilters) ...[
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                          if (_selectedStatus != null)
                            const SizedBox(width: 8),
                          _ActiveFilterChip(
                            label: _selectedType!,
                            color: AppColors.primary,
                            onRemove: () =>
                                setState(() => _selectedType = null),
                          ),
                        ],
                        if (_selectedLocationId != null) ...[
                          if (_selectedStatus != null || _selectedType != null)
                            const SizedBox(width: 8),
                          _ActiveFilterChip(
                            label: assetsAsync.maybeWhen(
                              data: (assets) => assets
                                      .firstWhere(
                                        (a) =>
                                            a.location?.id ==
                                            _selectedLocationId,
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
                ],
              ],
            ),
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