import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/core/widgets/action_button.dart';
import 'package:itam_app/core/widgets/search_filter_bar.dart';
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
  Set<TicketStatus> _selectedStatuses = {};
  Set<TicketPriority> _selectedPriorities = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
    _selectedStatuses.isNotEmpty || _selectedPriorities.isNotEmpty;

  double get _headerHeight => _hasActiveFilters ? 100 : 64;

  Future<void> _openFilterSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => TicketFilterSheet(
        initialStatuses: _selectedStatuses,
        initialPriorities: _selectedPriorities,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedStatuses = (result['statuses'] as List<TicketStatus>).toSet();
        _selectedPriorities = (result['priorities'] as List<TicketPriority>).toSet();
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
      body: Stack(
        children: [
          ticketsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
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
                final matchesStatus =
                    _selectedStatuses.isEmpty || _selectedStatuses.contains(t.status);
                final matchesPriority =
                    _selectedPriorities.isEmpty || _selectedPriorities.contains(t.priority);
                return matchesSearch && matchesStatus && matchesPriority;
              }).toList();

              filtered.sort((a, b) {
                int statusPriority(TicketStatus s) => switch (s) {
                      TicketStatus.open => 0,
                      TicketStatus.inProgress => 1,
                      TicketStatus.resolved => 2,
                      TicketStatus.closed => 3,
                    };
                final cmp =
                    statusPriority(a.status).compareTo(statusPriority(b.status));
                if (cmp != 0) return cmp;
                return b.createdAt.compareTo(a.createdAt);
              });

              return RefreshIndicator(
                onRefresh: () =>
                    ref.read(ticketListProvider.notifier).refresh(),
                child: filtered.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            _headerHeight + 8,
                            horizontalPadding,
                            80,
                          ),
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.3),
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
                        padding: EdgeInsets.fromLTRB(
                            horizontalPadding,
                            _headerHeight + 8,
                            horizontalPadding,
                            80,
                          ),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) =>
                            TicketCard(ticket: filtered[index]),
                      ),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  horizontalPadding, 12, horizontalPadding, 8),
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
                    onFilterTap: _openFilterSheet,
                    hasActiveFilters: _hasActiveFilters,
                  ),
                  if (_hasActiveFilters) ...[
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ..._selectedStatuses.map((status) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _ActiveFilterChip(
                              label: _statusLabel(status),
                              color: _statusColor(status),
                              onRemove: () => setState(() => _selectedStatuses.remove(status)),
                            ),
                          )),
                          ..._selectedPriorities.map((priority) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _ActiveFilterChip(
                              label: _priorityLabel(priority),
                              color: _priorityColor(priority),
                              onRemove: () => setState(() => _selectedPriorities.remove(priority)),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: horizontalPadding,
            right: horizontalPadding,
            child: SafeArea(
              child: ActionButton(
                label: 'Ouvrir un incident',
                color: Colors.red,
                icon: Icons.add_rounded,
                onPressed: () => context.push('/tickets/create'),
              ),
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
        TicketStatus.open => AppColors.primary,
        TicketStatus.inProgress => Colors.orange,
        TicketStatus.resolved => Colors.green,
        TicketStatus.closed => AppColors.textSecondary,
      };

  String _priorityLabel(TicketPriority p) => switch (p) {
        TicketPriority.low => 'Faible',
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