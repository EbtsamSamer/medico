import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:medico/features/home/data/models/doctor_model.dart';

class FavoriteRepo {
  final SharedPreferences _prefs;

  FavoriteRepo(this._prefs);

  static const String favoritesKey = 'favorite_doctors';

  Future<List<DoctorModel>> getFavorites() async {
    final favoritesJson = _prefs.getStringList(favoritesKey);

    if (favoritesJson == null || favoritesJson.isEmpty) {
      return [];
    }

    return favoritesJson.map((doctorJson) {
      final doctorMap = jsonDecode(doctorJson);

      return DoctorModel.fromJson(doctorMap);
    }).toList();
  }

  Future<void> saveFavorites(List<DoctorModel> favorites) async {
    final favoritesJson = favorites.map((doctor) {
      return jsonEncode(doctor.toJson());
    }).toList();

    await _prefs.setStringList(favoritesKey, favoritesJson);
  }
}