part of 'upcoming_bloc_cubit.dart';

enum ListStatus { loading, success, failure }

// abstract class UpcomingBlocState extends Equatable {
class UpcomingBlocState extends Equatable {
  const UpcomingBlocState._({
    this.status = ListStatus.loading,
    this.movies = const <Movie>[],
  });

  const UpcomingBlocState.loading() : this._();

  const UpcomingBlocState.success(List<Movie> movies)
      : this._(status: ListStatus.success, movies: movies);

  const UpcomingBlocState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<Movie> movies;

  @override
  List<Object> get props => [status, movies];
}

// class UpcomingBlocInitial extends UpcomingBlocState {
//   UpcomingBlocInitial.loading() : super.loading();
// }
