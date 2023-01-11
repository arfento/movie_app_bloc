import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

part 'upcoming_bloc_state.dart';

class UpcomingBlocCubit extends Cubit<UpcomingBlocState> {
  UpcomingBlocCubit({required this.repository})
      : super(const UpcomingBlocState.loading());

  final MovieRepository repository;

  Future<void> fetchUpComing() async {
    try {
      final movieResponse = await repository.getUpcomingMovies();
      emit(UpcomingBlocState.success(movieResponse.movies));
    } on Exception {
      emit(const UpcomingBlocState.failure());
    } catch (e) {
      print(e.toString());
    }
  }
}
