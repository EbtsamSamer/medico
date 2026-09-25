import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico/core/routes/themes/app_colors.dart';
import 'package:medico/core/widgets/doctor_card.dart';
import '../cubit/favourite_cubit.dart';
import '../cubit/favourite_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Favorites',
          style: TextStyle(
            color: AppColors.mainText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          final favorites = context.read<FavoriteCubit>().favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorite doctors yet',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => SizedBox(height: 14),
            itemBuilder: (context, index) {
              final doctor = favorites[index];

              return DoctorCardWidget(
                doctor: doctor,
                isFavorite: true,
                onFavoriteTap: () {
                  context.read<FavoriteCubit>().toggleFavorite(doctor);
                },
                onBookTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}