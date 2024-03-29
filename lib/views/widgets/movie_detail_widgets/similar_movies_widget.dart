import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/theme_bloc/theme_controller.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

import '../../../bloc/similar_movies_bloc/similar_movies_cubit.dart';
import '../home_screen_widgets/movie_widget_loader.dart';
import '../home_screen_widgets/movies_list_horizontal.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget(
      {Key? key,
      required this.movieId,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SimilarMoviesCubit(
        movieRepository: context.read<MovieRepository>(),
      )..fetchList(movieId),
      child: SimilarMoviesList(
        movieId: movieId,
        movieRepository: movieRepository,
        themeController: themeController,
      ),
    );
  }
}

class SimilarMoviesList extends StatelessWidget {
  const SimilarMoviesList(
      {Key? key,
      required this.movieId,
      required this.themeController,
      required this.movieRepository})
      : super(key: key);
  final ThemeController themeController;
  final MovieRepository movieRepository;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SimilarMoviesCubit>().state;

    switch (state.status) {
      case ListStatus.failure:
        return const Center(
            child: Text(
          'Oops something went wrong!',
          style: TextStyle(color: Colors.white),
        ));
      case ListStatus.success:
        return MoviesListHorizontal(
          movies: state.movies,
          movieRepository: movieRepository,
          themeController: themeController,
        );
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
