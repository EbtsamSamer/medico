
import '../../data/models/appoinment_model.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentUpdated extends AppointmentState {
  final List<AppointmentModel> appointments;

  AppointmentUpdated(this.appointments);
}