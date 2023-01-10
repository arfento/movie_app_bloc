import 'package:flutter/material.dart';

import '../../../bloc/theme_bloc/theme_controller.dart';
import '../../../services/movie_repository.dart';

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
    return Container();
  }
}
