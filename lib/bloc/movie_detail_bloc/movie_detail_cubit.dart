import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/movie.dart';
import '../../models/movie_detail.dart';
import '../../services/movie_repository.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({required this.repository})
      : super(const MovieDetailState.loading());
  final MovieRepository repository;

  Future<void> fetchMovie(int id) async {
    try {
      final movieResponse = await repository.getMovieDetail(id);

      emit(MovieDetailState.success(movieResponse.movieDetail));
    } on Exception {
      emit(const MovieDetailState.failure());
    }
  }
}
