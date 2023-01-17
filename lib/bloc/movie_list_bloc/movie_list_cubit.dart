import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit({required this.movieRepository})
      : super(const MovieListState.loading());

  final MovieRepository movieRepository;

  Future<void> fetchList() async {
    try {
      final movieResponse = await movieRepository.getMovies(1);
      emit(MovieListState.success(movieResponse.movies));
    } on Exception {
      emit(MovieListState.failure());
    } catch (e) {
      emit(MovieListState.failure());
    }
  }
}
