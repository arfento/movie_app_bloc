import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  TopRatedMoviesCubit({required this.movieRepository})
      : super(const TopRatedMoviesState.loading());

  final MovieRepository movieRepository;

  Future<void> fetchList() async {
    try {
      final movieResponse = await movieRepository.getTopRatedMovies();
      emit(TopRatedMoviesState.success(movieResponse.movies));
    } on Exception {
      emit(const TopRatedMoviesState.failure());
    } catch (e) {
      emit(const TopRatedMoviesState.failure());
    }
  }
}
