import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:itam_app/core/theme/app_theme.dart';
import 'package:itam_app/features/tickets/presentation/providers/ticket_provider.dart';
import 'package:itam_app/features/tickets/presentation/widgets/ticket_card.dart';
import 'package:itam_app/core/widgets/action_button.dart';

class TicketListPage extends ConsumerStatefulWidget {
  const TicketListPage({super.key});

  @override
  ConsumerState<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends ConsumerState<TicketListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          padding: EdgeInsets.fromLTRB(horizontalPadding, 12, horizontalPadding, 12),
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
                horizontalPadding, 16, horizontalPadding, 12),
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Icon(
                    Icons.tune_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Liste
          Expanded(
            child: ticketsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Text(
                  'Erreur : $e',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              data: (tickets) {
                final filtered = tickets.where((t) {
                  return t.title.toLowerCase().contains(_searchQuery) ||
                      (t.asset?.name ?? '').toLowerCase().contains(_searchQuery) ||
                      t.reference.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'Aucun ticket trouvé',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => ref.read(ticketListProvider.notifier).refresh(),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: 8,
                    ),
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
}