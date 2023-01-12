import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/theme_bloc/theme_controller.dart';
import 'package:movie_app_bloc/bloc/top_rated_movies_bloc/cubit/top_rated_movies_cubit.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

import '../movie_widget_loader.dart';
import '../movies_list_horizontal.dart';

class TopRatedMoviesList extends StatefulWidget {
  const TopRatedMoviesList({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _TopRatedMoviesListState createState() => _TopRatedMoviesListState();
}

class _TopRatedMoviesListState extends State<TopRatedMoviesList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TopRatedMoviesCubit(movieRepository: context.read<MovieRepository>())
            ..fetchList(),
      child: TopRatedMoviesView(
        movieRepository: widget.movieRepository,
        themeController: widget.themeController,
      ),
    );
  }
}

class TopRatedMoviesView extends StatelessWidget {
  const TopRatedMoviesView({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TopRatedMoviesCubit>().state;

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
