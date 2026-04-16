// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ticketDetailHash() => r'98ded86cf9d738f60e5aca4dd94860b46c324b45';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TicketDetail
    extends BuildlessAutoDisposeAsyncNotifier<Ticket> {
  late final int ticketId;

  FutureOr<Ticket> build(int ticketId);
}

/// See also [TicketDetail].
@ProviderFor(TicketDetail)
const ticketDetailProvider = TicketDetailFamily();

/// See also [TicketDetail].
class TicketDetailFamily extends Family<AsyncValue<Ticket>> {
  /// See also [TicketDetail].
  const TicketDetailFamily();

  /// See also [TicketDetail].
  TicketDetailProvider call(int ticketId) {
    return TicketDetailProvider(ticketId);
  }

  @override
  TicketDetailProvider getProviderOverride(
    covariant TicketDetailProvider provider,
  ) {
    return call(provider.ticketId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'ticketDetailProvider';
}

/// See also [TicketDetail].
class TicketDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TicketDetail, Ticket> {
  /// See also [TicketDetail].
  TicketDetailProvider(int ticketId)
    : this._internal(
        () => TicketDetail()..ticketId = ticketId,
        from: ticketDetailProvider,
        name: r'ticketDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$ticketDetailHash,
        dependencies: TicketDetailFamily._dependencies,
        allTransitiveDependencies:
            TicketDetailFamily._allTransitiveDependencies,
        ticketId: ticketId,
      );

  TicketDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ticketId,
  }) : super.internal();

  final int ticketId;

  @override
  FutureOr<Ticket> runNotifierBuild(covariant TicketDetail notifier) {
    return notifier.build(ticketId);
  }

  @override
  Override overrideWith(TicketDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: TicketDetailProvider._internal(
        () => create()..ticketId = ticketId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ticketId: ticketId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TicketDetail, Ticket>
  createElement() {
    return _TicketDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketDetailProvider && other.ticketId == ticketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ticketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TicketDetailRef on AutoDisposeAsyncNotifierProviderRef<Ticket> {
  /// The parameter `ticketId` of this provider.
  int get ticketId;
}

class _TicketDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TicketDetail, Ticket>
    with TicketDetailRef {
  _TicketDetailProviderElement(super.provider);

  @override
  int get ticketId => (origin as TicketDetailProvider).ticketId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
