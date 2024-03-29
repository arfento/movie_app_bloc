import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/now_playing_widgets/now_playing_list.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/popular_movies_widgets/popular_movies_list.dart';

import '../../../../bloc/theme_bloc/theme_controller.dart';
import '../../../../services/movie_repository.dart';

class PopularMoviesWidget extends StatefulWidget {
  const PopularMoviesWidget({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _PopularMoviesWidgetState createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: PopularMoviesList(
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
      ),
    );
  }
}
