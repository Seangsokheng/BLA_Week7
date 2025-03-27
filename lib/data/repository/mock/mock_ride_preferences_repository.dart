import '../../../model/ride/ride_pref.dart';
import '../ride_preferences_repository.dart';

import '../../dummy_data/dummy_data.dart';

class MockRidePreferencesRepository extends RidePreferencesRepository {
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  Future<List<RidePreference>> getPastPreferences() {
    
    return Future.delayed(Duration(seconds: 2), () {
      return _pastPreferences;
    });
  }

  @override
  Future<void> addPreference(RidePreference preference) {
    return Future.delayed(Duration(seconds: 2), () {
      return _pastPreferences.add(preference);
    });
  }
}
