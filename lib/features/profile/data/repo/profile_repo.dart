import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:medico/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  final SharedPreferences _prefs;

  ProfileRepo(this._prefs);

  static const String profileKey = 'profile';

  Future<ProfileModel?> getProfile() async {
    final profileJson = _prefs.getString(profileKey);

    if (profileJson == null || profileJson.isEmpty) {
      return null;
    }

    final profileMap = jsonDecode(profileJson);

    return ProfileModel.fromJson(
      Map<String, dynamic>.from(profileMap),
    );
  }

  Future<void> saveProfile(ProfileModel profile) async {
    final profileJson = jsonEncode(profile.toJson());

    await _prefs.setString(
      profileKey,
      profileJson,
    );
  }

  Future<void> clearProfile() async {
    await _prefs.remove(profileKey);
  }
}