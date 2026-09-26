import 'package:medico/features/profile/data/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final ProfileModel profile;

  ProfileUpdated(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}