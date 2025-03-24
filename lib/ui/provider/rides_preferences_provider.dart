import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  final RidePreferencesRepository repository;

  RidePreference? _currentPreference;
  List<RidePreference> _pastPreferences = [];

  RidesPreferencesProvider({required this.repository}) {
    _pastPreferences = repository.getPastPreferences(); // Direct call to get data
  }

  // Get current preference
  RidePreference? get currentPreference => _currentPreference;

  // Get past preferences in reverse order (newest to oldest)
  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();

  // Set new preference
  void setCurrentPreference(RidePreference newPreference) {
    if (_currentPreference == newPreference) {
      return; // Do nothing if it's the same preference
    }

    _currentPreference = newPreference;

    // Ensure unique history
    if (!_pastPreferences.contains(newPreference)) {
      _pastPreferences.add(newPreference);
    }

    notifyListeners();
  }
}
