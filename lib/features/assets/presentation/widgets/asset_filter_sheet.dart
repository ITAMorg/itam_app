import 'package:flutter/material.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/assets/domain/entities/asset.dart';

class AssetFilterSheet extends StatefulWidget {
  final List<String> availableTypes;
  final Map<int, String> availableLocations;
  final bool showLocations;
  final AssetStatus? initialStatus;
  final String? initialType;
  final int? initialLocationId;

  const AssetFilterSheet({
    super.key,
    required this.availableTypes,
    required this.availableLocations,
    required this.showLocations,
    this.initialStatus,
    this.initialType,
    this.initialLocationId,
  });

  @override
  State<AssetFilterSheet> createState() => _AssetFilterSheetState();
}

class _AssetFilterSheetState extends State<AssetFilterSheet> {
  AssetStatus? _status;
  String? _type;
  int? _locationId;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
    _type = widget.initialType;
    _locationId = widget.initialLocationId;
  }

  @override
  Widget build(BuildContext context) {
    final statusColors =
        Theme.of(context).extension<AssetStatusThemeExtension>()!.statusColors;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Header
          Row(
            children: [
              Text(
                'Filtres',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              if (_status != null || _type != null || _locationId != null)
                GestureDetector(
                  onTap: () => setState(() {
                    _status = null;
                    _type = null;
                    _locationId = null;
                  }),
                  child: Text(
                    'Réinitialiser',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.primary,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),

          // Statut
          Text(
            'STATUT',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 10),
          _buildStatusOptions(statusColors),
          const SizedBox(height: 20),

          // Type
          Text(
            'TYPE',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 10),
          _buildDropdown(
            value: _type,
            hint: 'Tous les types',
            items: widget.availableTypes,
            labelBuilder: (v) => v,
            onChanged: (v) => setState(() => _type = v),
          ),

          // Localisation (ADMIN et TECH seulement)
          if (widget.showLocations) ...[
            const SizedBox(height: 20),
            Text(
              'LOCALISATION',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
            ),
            const SizedBox(height: 10),
            _buildDropdown(
              value: _locationId?.toString(),
              hint: 'Toutes les localisations',
              items: widget.availableLocations.keys
                  .map((k) => k.toString())
                  .toList(),
              labelBuilder: (v) =>
                  widget.availableLocations[int.parse(v)] ?? v,
              onChanged: (v) =>
                  setState(() => _locationId = v != null ? int.parse(v) : null),
            ),
          ],

          const SizedBox(height: 24),

          // Bouton appliquer
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop({
                'status': _status,
                'type': _type,
                'locationId': _locationId,
              }),
              child: const Text('Appliquer'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOptions(AssetStatusColors statusColors) {
    final options = [
      (AssetStatus.inService, 'En service', statusColors.inService),
      (AssetStatus.broken, 'En panne', statusColors.broken),
      (AssetStatus.maintenance, 'Maintenance', statusColors.maintenance),
      (AssetStatus.inStock, 'En stock', statusColors.inStock),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final (status, label, color) = opt;
        final selected = _status == status;
        return GestureDetector(
          onTap: () =>
              setState(() => _status = selected ? null : status),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color:
                  selected ? color.withValues(alpha: 0.2) : AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected ? color : AppColors.border.withValues(alpha: 0.3),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: selected ? color : AppColors.textSecondary,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required String Function(String) labelBuilder,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(
          hint,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.textSecondary),
        ),
        isExpanded: true,
        underline: const SizedBox.shrink(),
        dropdownColor: AppColors.surface,
        icon: const Icon(Icons.expand_more_rounded,
            color: AppColors.textSecondary),
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(
              hint,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.textSecondary),
            ),
          ),
          ...items.map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  labelBuilder(item),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )),
        ],
        onChanged: onChanged,
      ),
    );
  }
}