import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/features/home/data/models/doctor_model.dart';

import '../../data/repo/favourite_repo.dart';
import 'favourite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepo _favoriteRepo;

  FavoriteCubit(this._favoriteRepo) : super(FavoriteInitial()) {
    loadFavorites();
  }

  final List<DoctorModel> _favorites = [];

  List<DoctorModel> get favorites => List.unmodifiable(_favorites);

  Future<void> loadFavorites() async {
    final favorites = await _favoriteRepo.getFavorites();

    _favorites
      ..clear()
      ..addAll(favorites);

    emit(FavoriteUpdated(List.from(_favorites)));
  }

  Future<void> toggleFavorite(DoctorModel doctor) async {
    print('FAVORITE CLICKED: ${doctor.name}');

    final index = _favorites.indexWhere(
          (item) =>
      item.name == doctor.name &&
          item.specialization == doctor.specialization,
    );

    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(doctor);
    }

    await _favoriteRepo.saveFavorites(_favorites);

    print('FAVORITES COUNT: ${_favorites.length}');

    emit(FavoriteUpdated(List.from(_favorites)));
  }

  bool isFavorite(DoctorModel doctor) {
    return _favorites.any(
          (item) =>
      item.name == doctor.name &&
          item.specialization == doctor.specialization,
    );
  }
}