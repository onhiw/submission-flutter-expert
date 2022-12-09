part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchlistEvent extends Equatable {}

class GetListMovieWatchlist extends MovieWatchlistEvent {
  @override
  List<Object> get props => [];
}

class GetListMovieWatchlistStatus extends MovieWatchlistEvent {
  final int id;

  GetListMovieWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class MovieWatchlistAdd extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  MovieWatchlistAdd(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieWatchlistRemove extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  MovieWatchlistRemove(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
