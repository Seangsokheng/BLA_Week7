import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preference_dto.dart';
import 'package:week_3_blabla_project/data/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsList = prefs.getStringList(_preferencesKey);

    if (prefsList == null || prefsList.isEmpty) {
      await prefs.setStringList(
        _preferencesKey,
        fakeRidePrefs
            .map((pref) =>
                jsonEncode(RidePreferenceDto.fromModel(pref).toJson()))
            .toList(),
      );
      return List.from(_pastPreferences);
    }

    return prefsList
        .map((json) => RidePreferenceDto.fromJson(jsonDecode(json)).toModel())
        .toList();
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    
    final prefs = await SharedPreferences.getInstance();

    final currentPreferences = await getPastPreferences();

    currentPreferences.add(preference);

    await prefs.setStringList(
      _preferencesKey,
      currentPreferences
          .map((pref) => jsonEncode(RidePreferenceDto.fromModel(pref).toJson()))
          .toList(),
    );
  }
}
