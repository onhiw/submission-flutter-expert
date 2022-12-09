part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {
  const TvWatchlistInitial();

  @override
  List<Object> get props => [];
}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistLoaded extends TvWatchlistState {
  final List<Tv> tv;

  const TvWatchlistLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class TvWatchlistIsAdded extends TvWatchlistState {
  final bool isAdded;

  TvWatchlistIsAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistMessage extends TvWatchlistState {
  final String message;

  const TvWatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
