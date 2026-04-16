import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:itam_app/features/auth/data/datasources/auth_remote_datasource.dart';

part 'technician_provider.g.dart';

@riverpod
Future<List<TechnicianModel>> technicianList(Ref ref) async {
  final datasource = ref.watch(authRemoteDataSourceProvider);
  return datasource.getUsersByRole('TECHNICIAN');
}