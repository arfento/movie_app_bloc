import 'package:flutter/material.dart';

import '../../../bloc/theme_bloc/theme_controller.dart';
import '../../../services/movie_repository.dart';
import '../../widgets/home_screen_widgets/upcoming_widgets/upcoming_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          UpcomingWidget(
              movieRepository: widget.movieRepository,
              themeController: widget.themeController),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Now Playing"),
          ),
          Container(),
          // NowPlayingWidget(
          //     movieRepository: widget.movieRepository,
          //     themeController: widget.themeController),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Popular Movies"),
          ),
          Container(),
          // PopularMoviesWidget(
          //     movieRepository: widget.movieRepository,
          //     themeController: widget.themeController),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("AllTime Top Rated Movies"),
          ),
          Container(),
          // TopRatedMoviesWidget(
          //     movieRepository: widget.movieRepository,
          //     themeController: widget.themeController)
        ],
      ),
    );
  }
}
