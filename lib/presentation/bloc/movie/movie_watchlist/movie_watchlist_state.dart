part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlistState {
  const MovieWatchlistInitial();

  @override
  List<Object> get props => [];
}

class MovieWatchlistLoading extends MovieWatchlistState {}

class MovieWatchlistLoaded extends MovieWatchlistState {
  final List<Movie> movie;

  const MovieWatchlistLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieWatchlistIsAdded extends MovieWatchlistState {
  final bool isAdded;

  MovieWatchlistIsAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistMessage extends MovieWatchlistState {
  final String message;

  const MovieWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
