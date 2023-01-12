import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/services/movie_repository.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit({required this.movieRepository})
      : super(const NowPlayingState.loading());

  final MovieRepository movieRepository;

  Future<void> fetchList() async {
    try {
      final movieResponse = await movieRepository.getNowPlaying(1);
      emit(NowPlayingState.success(movieResponse.movies));
    } on Exception {
      emit(NowPlayingState.failure());
    } catch (e) {
      emit(NowPlayingState.failure());
    }
  }
}
