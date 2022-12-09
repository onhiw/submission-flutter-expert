part of 'now_playing_tv_bloc.dart';

abstract class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvInitial extends NowPlayingTvState {
  const NowPlayingTvInitial();

  @override
  List<Object> get props => [];
}

class NowPlayingTvLoading extends NowPlayingTvState {}

class NowPlayingTvLoaded extends NowPlayingTvState {
  final List<Tv> tv;

  const NowPlayingTvLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class NowPlayingTvError extends NowPlayingTvState {
  final String message;

  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}
