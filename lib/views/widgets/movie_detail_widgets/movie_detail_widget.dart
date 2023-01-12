import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/theme_bloc/theme_controller.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';
import 'package:movie_app_bloc/views/widgets/movie_detail_widgets/movie_detail_view.dart';

class MovieDetailWidget extends StatefulWidget {
  MovieDetailWidget({
    Key? key,
    required this.movieId,
    required this.movieRepository,
    required this.themeController,
  }) : super(key: key);

  int? movieId;
  ThemeController? themeController;
  MovieRepository? movieRepository;

  @override
  _MovieDetailWidgetState createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: MovieDetailView(
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
        movieId: widget.movieId,
      ),
    );
  }
}
