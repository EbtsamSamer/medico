import 'package:medico/features/home/data/models/doctor_model.dart';


abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<DoctorModel> favorites;

  FavoriteUpdated(this.favorites);
}