import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit({required this.movieRepository})
      : super(const SimilarMoviesState.loading());

  final MovieRepository movieRepository;

  Future<void> fetchList(int movieId) async {
    try {
      final movieResponse = await movieRepository.getSimilarMovies(movieId);
      emit(SimilarMoviesState.success(movieResponse.movies));
    } on Exception {
      emit(SimilarMoviesState.failure());
    } catch (e) {
      emit(SimilarMoviesState.failure());
    }
  }
}
