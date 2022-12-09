part of 'now_playing_bloc.dart';

abstract class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {
  const NowPlayingInitial();

  @override
  List<Object> get props => [];
}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  final List<Movie> movie;

  const NowPlayingLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class NowPlayingError extends NowPlayingState {
  final String message;

  const NowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
