import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/features/profile/data/models/profile_model.dart';
import 'package:medico/features/profile/data/repo/profile_repo.dart';
import 'package:medico/core/routes/utils/token_storage.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _profileRepo;
  final TokenStorage _tokenStorage;

  ProfileCubit(
      this._profileRepo,
      this._tokenStorage,
      ) : super(ProfileInitial()) {
    loadProfile();
  }

  ProfileModel? _profile;

  ProfileModel? get profile => _profile;

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoading());

      final profile = await _profileRepo.getProfile();

      if (profile == null) {
        emit(ProfileError('Profile data not found'));
        return;
      }

      _profile = profile;

      emit(ProfileUpdated(profile));
    } catch (e) {
      emit(ProfileError('Failed to load profile'));
    }
  }

  Future<void> updateProfile(ProfileModel profile) async {
    try {
      emit(ProfileLoading());

      await _profileRepo.saveProfile(profile);

      _profile = profile;

      emit(ProfileUpdated(profile));
    } catch (e) {
      emit(ProfileError('Failed to update profile'));
    }
  }

  Future<void> logout() async {
    await _tokenStorage.deleteToken();
    await _profileRepo.clearProfile();

    _profile = null;

    emit(ProfileInitial());
  }
}