import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/appoinment_model.dart';
import '../../data/repo/appointment_repo.dart';
import 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo _appointmentRepo;

  AppointmentCubit(this._appointmentRepo)
      : super(AppointmentInitial()) {
    loadAppointments();
  }

  final List<AppointmentModel> _appointments = [];

  List<AppointmentModel> get appointments =>
      List.unmodifiable(_appointments);

  Future<void> loadAppointments() async {
    emit(AppointmentLoading());

    final appointments = await _appointmentRepo.getAppointments();

    _appointments
      ..clear()
      ..addAll(appointments);

    emit(AppointmentUpdated(List.from(_appointments)));
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    _appointments.add(appointment);

    await _appointmentRepo.saveAppointments(_appointments);

    emit(AppointmentUpdated(List.from(_appointments)));
  }

  Future<void> cancelAppointment(AppointmentModel appointment) async {
    final index = _appointments.indexWhere(
          (item) =>
      item.doctor.name == appointment.doctor.name &&
          item.date == appointment.date &&
          item.time == appointment.time,
    );

    if (index != -1) {
      _appointments[index] = AppointmentModel(
        doctor: _appointments[index].doctor,
        date: _appointments[index].date,
        time: _appointments[index].time,
        status: 'Cancelled',
      );
    }

    await _appointmentRepo.saveAppointments(_appointments);

    emit(AppointmentUpdated(List.from(_appointments)));
  }
}