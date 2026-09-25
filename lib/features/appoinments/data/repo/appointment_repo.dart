import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/appoinment_model.dart';

class AppointmentRepo {
  final SharedPreferences _prefs;

  AppointmentRepo(this._prefs);

  static const String appointmentsKey = 'appointments';

  Future<List<AppointmentModel>> getAppointments() async {
    final appointmentsJson = _prefs.getStringList(appointmentsKey);

    if (appointmentsJson == null || appointmentsJson.isEmpty) {
      return [];
    }

    return appointmentsJson.map((appointmentJson) {
      final appointmentMap = jsonDecode(appointmentJson);

      return AppointmentModel.fromJson(
        Map<String, dynamic>.from(appointmentMap),
      );
    }).toList();
  }

  Future<void> saveAppointments(
      List<AppointmentModel> appointments,
      ) async {
    final appointmentsJson = appointments.map((appointment) {
      return jsonEncode(appointment.toJson());
    }).toList();

    await _prefs.setStringList(
      appointmentsKey,
      appointmentsJson,
    );
  }
}