import '../../../home/data/models/doctor_model.dart';

class AppointmentModel {
  final DoctorModel doctor;
  final String date;
  final String time;
  final String status;

  const AppointmentModel({
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor.toJson(),
      'date': date,
      'time': time,
      'status': status,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      doctor: DoctorModel.fromJson(
        Map<String, dynamic>.from(json['doctor']),
      ),
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}