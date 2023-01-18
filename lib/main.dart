import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/all_movies_bloc/all_movies_bloc.dart';
import 'package:movie_app_bloc/consts/app_themes.dart';
import 'package:movie_app_bloc/views/pages/main_screen.dart';

import 'bloc/theme_bloc/theme_controller.dart';
import 'bloc/theme_bloc/theme_service.dart';
import 'services/movie_repository.dart';

Future<void> main() async {
  final movieRepository = MovieRepository();
  final themeController = ThemeController(ThemeService());
  await themeController.loadSettings();
  runApp(MyApp(
    themeController: themeController,
    movieRepository: movieRepository,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.themeController,
      required this.movieRepository});

  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (context) => MovieBloc(movieRepository: movieRepository!),
        ),
      ],
      child: AnimatedBuilder(
          animation: themeController!,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              restorationScopeId: "app",
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeController!.themeMode,
              home: MainScreen(
                themeController: themeController,
                movieRepository: movieRepository,
              ),
            );
          }),
    );
  }
}
