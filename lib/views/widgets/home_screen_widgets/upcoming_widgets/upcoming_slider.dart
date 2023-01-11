import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_bloc/bloc/upcoming_bloc/upcoming_bloc_cubit.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

class UpcomingSlider extends StatefulWidget {
  const UpcomingSlider({Key? key}) : super(key: key);

  @override
  _UpcomingSliderState createState() => _UpcomingSliderState();
}

class _UpcomingSliderState extends State<UpcomingSlider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingBlocCubit(
        repository: context.read<MovieRepository>(),
      )..fetchUpComing(),
      child: const UpcomingView(),
    );
  }
}

class UpcomingView extends StatelessWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UpcomingBlocCubit>().state;

    return Container();
  }
}
