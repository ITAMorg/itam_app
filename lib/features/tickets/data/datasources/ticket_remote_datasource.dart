import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../models/ticket_model.dart';

part 'ticket_remote_datasource.g.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>> getTickets();
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final Dio _dio;

  const TicketRemoteDataSourceImpl(this._dio);

  @override
  Future<List<TicketModel>> getTickets() async {
    final response = await _dio.get('/tickets');
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => TicketModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
TicketRemoteDataSource ticketRemoteDataSource(Ref ref) {
  return TicketRemoteDataSourceImpl(ref.watch(dioClientProvider));
}