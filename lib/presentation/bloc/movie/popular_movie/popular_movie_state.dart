part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {
  const PopularMovieInitial();

  @override
  List<Object> get props => [];
}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> movie;

  const PopularMovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class PopularMovieError extends PopularMovieState {
  final String message;

  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
