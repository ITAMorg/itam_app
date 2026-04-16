import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/widgets/action_button.dart';
import 'package:itam_app/features/tickets/domain/entities/ticket.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_provider.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_card.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_filter_sheet.dart';

class TicketListPage extends ConsumerStatefulWidget {
  const TicketListPage({super.key});

  @override
  ConsumerState<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends ConsumerState<TicketListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  TicketStatus? _selectedStatus;
  TicketPriority? _selectedPriority;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
      _selectedStatus != null || _selectedPriority != null;

  Future<void> _openFilterSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TicketFilterSheet(
        initialStatus: _selectedStatus,
        initialPriority: _selectedPriority,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedStatus = result['status'] as TicketStatus?;
        _selectedPriority = result['priority'] as TicketPriority?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ticketsAsync = ref.watch(ticketListProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;
    final horizontalPadding = isDesktop ? 32.0 : 16.0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              horizontalPadding, 12, horizontalPadding, 12),
          child: ActionButton(
            label: 'Ouvrir un incident',
            color: Colors.red,
            icon: Icons.add_rounded,
            onPressed: () => context.push('/tickets/create'),
          ),
        ),
      ),
      body: Column(
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
                  onTap: _openFilterSheet,
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

          // Chips filtres actifs
          if (_hasActiveFilters)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(
                  horizontalPadding, 0, horizontalPadding, 8),
              child: Row(
                children: [
                  if (_selectedStatus != null)
                    _ActiveFilterChip(
                      label: _statusLabel(_selectedStatus!),
                      color: _statusColor(_selectedStatus!),
                      onRemove: () =>
                          setState(() => _selectedStatus = null),
                    ),
                  if (_selectedPriority != null) ...[
                    if (_selectedStatus != null) const SizedBox(width: 8),
                    _ActiveFilterChip(
                      label: _priorityLabel(_selectedPriority!),
                      color: _priorityColor(_selectedPriority!),
                      onRemove: () =>
                          setState(() => _selectedPriority = null),
                    ),
                  ],
                ],
              ),
            ),

          // Liste
          Expanded(
            child: ticketsAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text('Erreur : $e',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              data: (tickets) {
                final filtered = tickets.where((t) {
                  final matchesSearch =
                      t.title.toLowerCase().contains(_searchQuery) ||
                          (t.asset?.name ?? '')
                              .toLowerCase()
                              .contains(_searchQuery) ||
                          t.reference.toLowerCase().contains(_searchQuery);
                  final matchesStatus = _selectedStatus == null ||
                      t.status == _selectedStatus;
                  final matchesPriority = _selectedPriority == null ||
                      t.priority == _selectedPriority;
                  return matchesSearch && matchesStatus && matchesPriority;
                }).toList();

                filtered.sort((a, b) {
                  int statusPriority(TicketStatus s) => switch (s) {
                        TicketStatus.open => 0,
                        TicketStatus.inProgress => 1,
                        TicketStatus.resolved => 2,
                        TicketStatus.closed => 3,
                      };
                  final cmp = statusPriority(a.status)
                      .compareTo(statusPriority(b.status));
                  if (cmp != 0) return cmp;
                  return b.createdAt.compareTo(a.createdAt);
                });

                return RefreshIndicator(
                  onRefresh: () => ref.read(ticketListProvider.notifier).refresh(),
                  child: filtered.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding, vertical: 8),
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                            Center(
                              child: Text(
                                'Aucun ticket trouvé',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding, vertical: 8),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 10),
                          itemBuilder: (context, index) =>
                              TicketCard(ticket: filtered[index]),
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(TicketStatus s) => switch (s) {
        TicketStatus.open => 'Ouvert',
        TicketStatus.inProgress => 'En cours',
        TicketStatus.resolved => 'Résolu',
        TicketStatus.closed => 'Fermé',
      };

  Color _statusColor(TicketStatus s) => switch (s) {
        TicketStatus.open => Colors.red,
        TicketStatus.inProgress => Colors.orange,
        TicketStatus.resolved => Colors.green,
        TicketStatus.closed => AppColors.textSecondary,
      };

  String _priorityLabel(TicketPriority p) => switch (p) {
        TicketPriority.low => 'Basse',
        TicketPriority.medium => 'Moyenne',
        TicketPriority.high => 'Haute',
      };

  Color _priorityColor(TicketPriority p) => switch (p) {
        TicketPriority.low => Colors.green,
        TicketPriority.medium => Colors.orange,
        TicketPriority.high => Colors.red,
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