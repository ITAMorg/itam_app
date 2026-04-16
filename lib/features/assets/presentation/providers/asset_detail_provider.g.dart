// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assetDetailHash() => r'14a3ef8947f6a69419b6bcf3d4b31a6c412ebf56';

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

abstract class _$AssetDetail extends BuildlessAutoDisposeAsyncNotifier<Asset> {
  late final String assetId;

  FutureOr<Asset> build(String assetId);
}

/// See also [AssetDetail].
@ProviderFor(AssetDetail)
const assetDetailProvider = AssetDetailFamily();

/// See also [AssetDetail].
class AssetDetailFamily extends Family<AsyncValue<Asset>> {
  /// See also [AssetDetail].
  const AssetDetailFamily();

  /// See also [AssetDetail].
  AssetDetailProvider call(String assetId) {
    return AssetDetailProvider(assetId);
  }

  @override
  AssetDetailProvider getProviderOverride(
    covariant AssetDetailProvider provider,
  ) {
    return call(provider.assetId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assetDetailProvider';
}

/// See also [AssetDetail].
class AssetDetailProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AssetDetail, Asset> {
  /// See also [AssetDetail].
  AssetDetailProvider(String assetId)
    : this._internal(
        () => AssetDetail()..assetId = assetId,
        from: assetDetailProvider,
        name: r'assetDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$assetDetailHash,
        dependencies: AssetDetailFamily._dependencies,
        allTransitiveDependencies: AssetDetailFamily._allTransitiveDependencies,
        assetId: assetId,
      );

  AssetDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.assetId,
  }) : super.internal();

  final String assetId;

  @override
  FutureOr<Asset> runNotifierBuild(covariant AssetDetail notifier) {
    return notifier.build(assetId);
  }

  @override
  Override overrideWith(AssetDetail Function() create) {
    return ProviderOverride(
      origin: this,
      override: AssetDetailProvider._internal(
        () => create()..assetId = assetId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        assetId: assetId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AssetDetail, Asset> createElement() {
    return _AssetDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetDetailProvider && other.assetId == assetId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, assetId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssetDetailRef on AutoDisposeAsyncNotifierProviderRef<Asset> {
  /// The parameter `assetId` of this provider.
  String get assetId;
}

class _AssetDetailProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AssetDetail, Asset>
    with AssetDetailRef {
  _AssetDetailProviderElement(super.provider);

  @override
  String get assetId => (origin as AssetDetailProvider).assetId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
