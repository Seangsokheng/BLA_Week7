import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/data/repository/local/local_ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
//import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/ui/provider/async_value.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  final LocalRidePreferencesRepository repository;

  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> _pastPreferences;

  RidesPreferencesProvider({required this.repository}) {
    _fetchPastPreferences();
  }

  void _fetchPastPreferences() async {
    print("object");
    //1 - Handle loading
    _pastPreferences = AsyncValue.loading();
    notifyListeners();

    try {
      // 2 Fectch data
      List<RidePreference> pastPrefs = await repository.getPastPreferences();

      // 3 - Handle success
      _pastPreferences = AsyncValue.success(pastPrefs);
    } catch (e) {
      _pastPreferences = AsyncValue.error(e);
    }
    notifyListeners();
  }

  // Get current preference
  RidePreference? get currentPreference => _currentPreference;

  AsyncValue<List<RidePreference>> get preferencesHistory =>
      AsyncValue.success((_pastPreferences.data ?? []).reversed.toList());

  Future<void> _addPreference(RidePreference pref) async {
    try {
      await repository.addPreference(pref);
      //_fetchPastPreferences();
      _pastPreferences.data!.add(pref);
      //notifyListeners();
    } catch (e) {
      _pastPreferences = AsyncValue.error(e);
    }
    notifyListeners();
  }

  // Set new preference
  void setCurrentPreference(RidePreference newPreference) {
    if (_currentPreference == newPreference) {
      return;
    }

    _currentPreference = newPreference;

    // Ensure unique history
    if (!(_pastPreferences.data ?? []).contains(newPreference)) {
      // _pastPreferences.data!.add(newPreference);
      _addPreference(newPreference);
    }

    notifyListeners();
  }
}
