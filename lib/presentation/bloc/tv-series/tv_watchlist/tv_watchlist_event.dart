part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {}

class GetListTvWatchlist extends TvWatchlistEvent {
  @override
  List<Object> get props => [];
}

class GetListTvWatchlistStatus extends TvWatchlistEvent {
  final int id;

  GetListTvWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class TvWatchlistAdd extends TvWatchlistEvent {
  final TvDetail tvDetail;

  TvWatchlistAdd(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class TvWatchlistRemove extends TvWatchlistEvent {
  final TvDetail tvDetail;

  TvWatchlistRemove(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
