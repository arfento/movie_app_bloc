import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/top_rated_movies_widgets/top_rated_movies_list.dart';

import '../../../../bloc/theme_bloc/theme_controller.dart';
import '../../../../services/movie_repository.dart';

class TopRatedMoviesWidget extends StatefulWidget {
  const TopRatedMoviesWidget({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _TopRatedMoviesWidgetState createState() => _TopRatedMoviesWidgetState();
}

class _TopRatedMoviesWidgetState extends State<TopRatedMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: TopRatedMoviesList(
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
      ),
    );
  }
}
