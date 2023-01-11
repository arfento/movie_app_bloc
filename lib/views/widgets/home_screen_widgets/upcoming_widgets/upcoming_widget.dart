import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/views/widgets/home_screen_widgets/upcoming_widgets/upcoming_slider.dart';

import '../../../../bloc/theme_bloc/theme_controller.dart';
import '../../../../services/movie_repository.dart';

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);
  final ThemeController? themeController;
  final MovieRepository? movieRepository;

  @override
  State<UpcomingWidget> createState() {
    return _UpcomingWidgetState();
  }
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: const UpcomingSlider(),
    );
  }
}
