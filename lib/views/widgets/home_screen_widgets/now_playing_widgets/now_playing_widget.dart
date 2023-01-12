import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/now_playing_bloc/cubit/now_playing_cubit.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/movie_widget_loader.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/movies_list_horizontal.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/now_playing_widgets/now_playing_list.dart';

import '../../../../bloc/theme_bloc/theme_controller.dart';
import '../../../../services/movie_repository.dart';

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget({
    Key? key,
    required this.themeController,
    required this.movieRepository,
  }) : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _NowPlayingWidgetState createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: NowPlayingList(
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
      ),
    );
  }
}
