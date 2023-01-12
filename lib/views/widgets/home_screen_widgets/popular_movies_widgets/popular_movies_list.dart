import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/popular_movies_bloc/cubit/popular_movies_cubit.dart';
import 'package:movie_app_bloc/bloc/theme_bloc/theme_controller.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

import '../movie_widget_loader.dart';
import '../movies_list_horizontal.dart';

class PopularMoviesList extends StatefulWidget {
  PopularMoviesList({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _PopularMoviesListState createState() => _PopularMoviesListState();
}

class _PopularMoviesListState extends State<PopularMoviesList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PopularMoviesCubit(movieRepository: context.read<MovieRepository>())
            ..fetchList(),
      child: PopularMoviesView(
        movieRepository: widget.movieRepository,
        themeController: widget.themeController,
      ),
    );
  }
}

class PopularMoviesView extends StatelessWidget {
  const PopularMoviesView({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PopularMoviesCubit>().state;

    switch (state.status) {
      case ListStatus.failure:
        return const Center(
          child: Text('Oops something went wrong!'),
        );
      case ListStatus.success:
        if (state.movies.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      'No More Popular Movies',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ],
                )
              ],
            ),
          );
        } else {
          return MoviesListHorizontal(
            movieRepository: movieRepository,
            themeController: themeController,
            movies: state.movies,
          );
        }
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
