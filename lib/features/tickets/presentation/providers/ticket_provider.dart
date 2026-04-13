import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/ticket_repository_impl.dart';
import '../../domain/entities/ticket.dart';

class TicketNotifier extends AsyncNotifier<List<Ticket>> {
  @override
  Future<List<Ticket>> build() async {
    return _fetch();
  }

  Future<List<Ticket>> _fetch() async {
    final repository = ref.read(ticketRepositoryProvider);
    return repository.getTickets();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}

final ticketListProvider = AsyncNotifierProvider<TicketNotifier, List<Ticket>>(
  TicketNotifier.new,
);