import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itam_app/features/locations/domain/entities/location.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class LocationModel with _$LocationModel {
  const factory LocationModel({
    required int id,
    required String name,
    required String building,
    required int floor,
  }) = _LocationModel;

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}

extension LocationModelMapper on LocationModel {
  Location toEntity() => Location(
        id: id,
        name: name,
        building: building,
        floor: floor,
      );
}