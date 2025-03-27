import 'dart:convert';
import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/location/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferenceDto {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  RidePreferenceDto({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

  factory RidePreferenceDto.fromJson(Map<String, dynamic> json) {
    return RidePreferenceDto(
      departure: LocationDto.fromJson(json['departure']),
      departureDate: DateTime.parse(json['departureDate']),
      arrival: LocationDto.fromJson(json['arrival']),
      requestedSeats: json['requestedSeats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departure': LocationDto.toJson(departure),
      'departureDate': departureDate.toIso8601String(),
      'arrival': LocationDto.toJson(arrival),
      'requestedSeats': requestedSeats,
    };
  }

  RidePreference toModel() {
    return RidePreference(
      departure: departure,
      departureDate: departureDate,
      arrival: arrival,
      requestedSeats: requestedSeats,
    );
  }

  factory RidePreferenceDto.fromModel(RidePreference model) {
    return RidePreferenceDto(
      departure: model.departure,
      departureDate: model.departureDate,
      arrival: model.arrival,
      requestedSeats: model.requestedSeats,
    );
  }
}