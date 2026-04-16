import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:itam_app/core/network/dio_client.dart';
import 'package:itam_app/features/locations/data/models/location_model.dart';
import 'package:itam_app/features/locations/domain/entities/location.dart';

part 'locations_provider.g.dart';

@riverpod
Future<List<Location>> locations(Ref ref) async {
  final dio = ref.watch(dioClientProvider);
  final response = await dio.get('/locations');
  final list = response.data as List<dynamic>;
  return list
      .map((e) => LocationModel.fromJson(e as Map<String, dynamic>).toEntity())
      .toList();
}