import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/theme_bloc/theme_controller.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

import '../../../../bloc/now_playing_bloc/cubit/now_playing_cubit.dart';
import '../movie_widget_loader.dart';
import '../movies_list_horizontal.dart';

class NowPlayingList extends StatefulWidget {
  const NowPlayingList({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _NowPlayingListState createState() => _NowPlayingListState();
}

class _NowPlayingListState extends State<NowPlayingList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NowPlayingCubit(movieRepository: context.read<MovieRepository>())
            ..fetchList(),
      child: NowPlayingView(
        movieRepository: widget.movieRepository,
        themeController: widget.themeController,
      ),
    );
  }
}

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NowPlayingCubit>().state;

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
